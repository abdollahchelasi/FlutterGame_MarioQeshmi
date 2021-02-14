import 'package:flutter/material.dart';
import 'package:trex_game/GameSetting.dart';


class Player{
  

  final double width, heyght,x;
  double y,_dy=0,_jumpforce=15.0;
  final Color color;
  final Image image;
  bool _canjump = true;
  Player({
    this.image,
    this.width,
    this.heyght,
    this.color,
    this.x,
    this.y,

});
  void updatePlayer(){
    this.y += this._dy;
    if(this.heyght + this.y < mainHeight){
      _dy += gravity;
      _canjump = false;
    }else{
      _canjump = true;
      _dy = 0;
      this.y = mainHeight - this.heyght;
    }
  }
  void jump(){
    if(_canjump) _dy -= _jumpforce;
  }

  Widget get getPlayer => Transform.translate(offset: new Offset(this.x,this.y),child: Container(

    width: this.width,
    height: this.heyght,
    color: this.color,
    child: image,

    //child: Image.asset('assets/abdol.jpeg'),

  ),);
}