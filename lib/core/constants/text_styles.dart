import 'package:flutter/material.dart';

const inter = 'Inter';
const gtpro = 'GtPro';

class AppTextStyle {
  static const gt18black =
      TextStyle(fontFamily: gtpro, fontSize: 18, color: Colors.black);

  static const gt18blackbold = TextStyle(
      fontFamily: gtpro,
      fontSize: 18,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  static const gt18white =
      TextStyle(fontFamily: gtpro, fontSize: 18, color: Colors.white);

  static const inter18black =
      TextStyle(fontFamily: inter, fontSize: 18, color: Colors.black);
  static const inter18white =
      TextStyle(fontFamily: inter, fontSize: 18, color: Colors.white);
}
