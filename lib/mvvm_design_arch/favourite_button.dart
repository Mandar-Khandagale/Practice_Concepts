import 'package:flutter/material.dart';
import 'package:form/responsive_pages/size_config.dart';

class FavouriteButton extends StatefulWidget {
  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> with SingleTickerProviderStateMixin {

  AnimationController _animationController;
  Animation<Color> _colorAnimation;
  Animation<double> _sizeAnimation;
  bool isFav = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds:500),
      vsync: this,
    );

    _colorAnimation = ColorTween(begin: Colors.grey[400],end: Colors.amber).animate(_animationController);

    _sizeAnimation = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(
          tween: Tween(begin: 3.8 * SizeConfig.textMultiplier, end: 6.5 * SizeConfig.textMultiplier),
          weight: 6.5 * SizeConfig.textMultiplier,
        ),
        TweenSequenceItem<double>(
          tween: Tween(begin: 6.5 * SizeConfig.textMultiplier, end: 3.8 * SizeConfig.textMultiplier),
          weight: 6.5 * SizeConfig.textMultiplier,
        ),
      ]
    ).animate(_animationController);

    _animationController.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          isFav = true;
        });
      }
      if(status == AnimationStatus.dismissed){
        setState(() {
          isFav = false;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context, _){
          return IconButton(
              icon: Icon(
                Icons.star,
                color: _colorAnimation.value,
                size: _sizeAnimation.value,
              ),
              onPressed: (){
                isFav ? _animationController.reverse() : _animationController.forward();
              });
        });
  }
}
