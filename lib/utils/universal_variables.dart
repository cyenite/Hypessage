import 'package:flutter/material.dart';

class UniversalVariables {
  static final Color blueColor = Color(0xff36d42b);
  static final Color blackColor = Color(0xff292929);
  static final Color greyColor = Color(0xff8f8f8f);
  static final Color userCircleBackground = Color(0xff2b2b33);
  static final Color onlineDotColor = Color(0xff46dc64);
  static final Color lightBlueColor = Color(0xff00d773);
  static final Color separatorColor = Color(0xff272c35);

  static final Color gradientColorStart = Color(0xff00d773);
  static final Color gradientColorEnd = Color(0xff017f04);

  static final Color senderColor = Color(0xff2b343b);
  static final Color receiverColor = Color(0xff1e2225);

  static final Color shimmerColor = Color(0xff585656);

  static final Gradient fabGradient = LinearGradient(
      colors: [gradientColorStart, gradientColorEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight);
}
