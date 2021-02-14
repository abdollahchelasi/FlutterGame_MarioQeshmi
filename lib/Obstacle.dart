import 'package:flutter/material.dart';


class Obstacle{
  final double withe,height,y;
  double x,dx;
  final Color color;
  final Image image;

  Obstacle({
    this.color,
    this.y,
    this.x,
    this.withe,
    this.height,
    this.image,
    this.dx,
});

  void move(){
    this.x -= this.dx;
  }
  Widget get getObstacle => Transform.translate(offset: Offset(
    this.x,
    this.y,
  ),
  child: Container(
    width: this.withe,
    height: this.height,
    color: this.color,
    child: image,

  ),
  );

}