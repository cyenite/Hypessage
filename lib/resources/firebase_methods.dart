import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hypessage/models/user.dart';
import 'package:hypessage/utils/utils.dart';

class FirebaseMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = GoogleSignIn();
  static final Firestore firestore = Firestore.instance;

  User user = User();

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser currentUser;
    currentUser = await _auth.currentUser();
    return currentUser;
  }

  Future<FirebaseUser> signIn() async {
    GoogleSignInAccount _signInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication _signInAuthentication =
        await _signInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _signInAuthentication.idToken,
        accessToken: _signInAuthentication.accessToken);
    FirebaseUser user = await _auth.signInWithCredential(credential);

    return user;
  }

  Future<bool> authenticateUser(FirebaseUser user) async {
    QuerySnapshot result = await firestore
        .collection('users')
        .where('email', isEqualTo: user.email)
        .getDocuments();
    final List<DocumentSnapshot> docs = result.documents;

    return docs.length == 0 ? true : false;
  }

  Future<void> addDataToDb(FirebaseUser currentUser) async {
    String username = Utils.getUsername(currentUser.email);

    user = User(
      uid: currentUser.uid,
      email: currentUser.email,
      name: currentUser.email,
      profilePhoto: currentUser.photoUrl,
      username: username,
    );

    firestore
        .collection('users')
        .document(currentUser.uid)
        .setData(user.toMap(user));
  }

  Future<void> signOut() async {
    await _googleSignIn.disconnect();
    await _googleSignIn.signOut();
    return await _auth.signOut();
  }

  Future<List<User>> fetchAllUsers(FirebaseUser currentUser)async{
    List<User> userList = List<User>();

    QuerySnapshot querySnapshot = await firestore.collection('users').getDocuments();
    for(var i = 0; i < querySnapshot.documents.length; i++){
      if(querySnapshot.documents[i].documentID != currentUser.uid){
        userList.add(User.fromMap(querySnapshot.documents[i].data));
      }
    }

    return userList;
  }
}
