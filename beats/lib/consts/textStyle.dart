import 'package:flutter/material.dart';
import 'colors.dart';

const bold = "bold";
const regular = "regular";

ostyle({fam = "regular", double? size = 14, color = whiteColor}) {
  return TextStyle(fontSize: size, color: color, fontFamily: fam);
}
