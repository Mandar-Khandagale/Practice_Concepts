import 'package:flutter/material.dart';

class SizeConfig {

   static double _screenWidth;
  static double _screenHeight;
  static double _blockSizeWidth = 0;
  static double _blockSizeHeight = 0;

  static double textMultiplier;
  static double imageSizeMultiplier;
  static double heightMultiplier;
  static double widthMultiplier;
  static bool isPortrait = true;
  static bool isMobilePortrait = false;

  void init(BoxConstraints constraints, Orientation orientation){
    print('cons:-$constraints');
    print('ori:-$orientation');
    if(orientation == Orientation.portrait){
      print('mandar');
      _screenWidth = constraints.maxWidth;
      _screenHeight = constraints.maxHeight;
      isPortrait = true;
      if(_screenWidth <450){
        isMobilePortrait = true;
      }
    }else{
      print('mohit');
      _screenWidth = constraints.maxHeight;
      _screenHeight =constraints.maxWidth;
      isPortrait = false;
      isMobilePortrait = false;
    }

    _blockSizeWidth = _screenWidth / 100;
    _blockSizeHeight = _screenHeight / 100;

    textMultiplier = _blockSizeHeight;
    imageSizeMultiplier = _blockSizeWidth;
    heightMultiplier = _blockSizeHeight;
    widthMultiplier = _blockSizeWidth;

    print(_blockSizeWidth);
    print(_blockSizeHeight);
  }
}