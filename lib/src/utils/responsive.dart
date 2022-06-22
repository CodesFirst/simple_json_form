import 'package:flutter/cupertino.dart';
import 'dart:math' as math;

class Responsive {
  double _width = 0, _height = 0, _diagonal = 0;

  double get width => _width;
  double get height => _height;
  double get diagonal => _diagonal;

  static Responsive of(BuildContext context) => Responsive(context);

  Responsive(BuildContext context) {
    final size = MediaQuery.of(context).size;
    _width = size.width;
    _height = size.height;
    _diagonal = math.sqrt((math.pow(_width, 2) + math.pow(_height, 2)));
  }

  double wp(double percent) => _width * percent / 100;
  double hp(double percent) => _height * percent / 100;
  double dp(double percent) => _diagonal * percent / 100;
}

double getpropScreenWidth(double inputWidth, BuildContext context) {
  double screenWidth = Responsive.of(context).width;
  return (inputWidth / 360.0) * screenWidth;
}

double getpropScreenHeight(double inputHeight, BuildContext context) {
  double screenHeight = Responsive.of(context).width;
  return (inputHeight / 640.0) * screenHeight; // **este metodo no se usa mucho**
}
