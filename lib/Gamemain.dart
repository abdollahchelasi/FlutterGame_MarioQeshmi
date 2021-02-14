import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trex_game/GameSetting.dart';
import 'package:trex_game/Obstacle.dart';
import 'Player.dart';
import 'package:google_fonts_arabic/fonts.dart';


class Gamemain extends StatefulWidget {
  @override
  _GamemainState createState() => _GamemainState();
}

class _GamemainState extends State<Gamemain> with SingleTickerProviderStateMixin{


  AnimationController _animationController;

  List<Obstacle> _obstacle = <Obstacle>[];

  static double marioX = 0;

  Player _mplayer;
  bool _gameIsStart = false;



  int score= 0;




  @override
  void initState() {
    createPlayer();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationController.addListener(_update);
    _animationController.repeat();
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    _animationController.dispose();
    // TODO: implement dispose
    super.dispose();
  }
  void _update(){
    if(_mplayer != null){
      setState(() {
        _mplayer.updatePlayer();
       if(_gameIsStart){
         gspeed += 0.0003;
         sp --;
         score++;
         if(sp <= 0){
           createObstacle();
         }
         _obstacle.forEach((obs) {
           obs.move();
            if(_mplayer.width + _mplayer.x >= obs.x &&
            _mplayer.x <= obs.x + obs.withe &&
                _mplayer.y + _mplayer.heyght >= obs.y &&
                _mplayer.y <= obs.y + obs.height
            ){
              _gameover();
            }
         });
       }
      });
    }
  }


  void createObstacle(){

    final randomsp = _createRandomValue(50, 100);
    final randomvalue = _createRandomValue(20, 40);

    final obs = Obstacle(
      withe: randomvalue,
      height: randomvalue,
      x: MediaQuery.of(context).size.width - randomvalue,
      y: mainHeight - randomvalue,
      dx: gspeed,
     // color: Colors.yellow,
      image: Image.asset('assets/qarch.gif',width: 20,height: 20,),

    );
    _obstacle.add(obs);
    sp = randomsp;
  }

  double _createRandomValue(int main ,int max){
    final result= main + Random().nextInt(max - main);
    return result.toDouble();
  }

  void createPlayer(){
    _mplayer = Player(width: 70,heyght: 70,x: 20,y: mainHeight - 35,image: Image.asset('assets/mario.gif',width: 50,height: 60,fit: BoxFit.cover,));
  }


 


  @override
  Widget build(BuildContext context) {



    return Stack(
      children: [
        Scaffold(

          backgroundColor: Colors.green,
          body: _main,
        ),
        if(!_gameIsStart)
          Opacity(opacity: .6,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.black,
            ),
          ),
        if(!_gameIsStart)
          Center(
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TapFadeText(
                  child: FlatButton(
                    onPressed: (){
                      _gameIsStart = true;
                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                        ),
                        child: Text('شروع بازی',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)),

                  ),
                ),

                SizedBox(height: 5,),

                TapFadeText(
                  child: FlatButton(
                    onPressed: (){

                     return showDialog(context: context,

                       builder: (context) => Center(
                         child: Directionality(
                           textDirection: TextDirection.rtl,
                           child: Center(
                             child: Container(
                               child: AlertDialog(


                                 actions: [

                                   Container(
                                     width: 50,
                                     height: 50,

                                     decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/abdol.jpeg'),),
                                         shape: BoxShape.circle
                                     ),
                                   ),
                                   Text('طراح و برنامه نویس : ',style: TextStyle(fontFamily: ArabicFonts.Reem_Kufi,package: 'google_fonts_arabic',fontWeight: FontWeight.w100),),
                                   Text('عبدالله چلاسی',style: TextStyle(fontFamily: ArabicFonts.Mada,package: 'google_fonts_arabic',fontWeight: FontWeight.w900),),

                                 ],
                               ),
                             ),
                           ),
                         ),
                       ),



                     );

                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                        ),
                        child: Text('درباره من',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)),

                  ),
                ),

                SizedBox(height: 5,),

                TapFadeText(
                  child: FlatButton(
                    onPressed: (){

                      return showDialog(context: context,

                        builder: (context) => Center(
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: Center(
                              child: Container(
                                child: AlertDialog(
                                  backgroundColor: Colors.blueGrey,

                                  actions: [


                                    Text('اصول بازی اینه که قبل از اینکه قارچ زخمی به ماریو نزدیک بشه باید بپری !',style: TextStyle(fontFamily: ArabicFonts.Mada,package: 'google_fonts_arabic',fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,),
                                    SizedBox(height:5 ,),
                                    Text('اگرشما هم همچین بازی  میخواهید و به جای ماریو عکس شما باشه به این شماره واتساپ یا پیام دهید... 09335825325',style: TextStyle(fontFamily: ArabicFonts.Mada,package: 'google_fonts_arabic',fontWeight: FontWeight.w400),),

                                  ],
                                ),
                                ),
                              ),
                            ),

                        ),



                      );

                    },
                    child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.black
                        ),
                        child: Text('راهنما',style: TextStyle(fontSize: 30,color: Colors.white,fontWeight: FontWeight.bold),)),

                  ),
                ),
              ],
            ),
          )
      ],
    );
  }
  void _jump(){
    if(_gameIsStart)
      _mplayer.jump();
  }

  void _gameover(){
    _gameIsStart = false;
    _obstacle = [];
    gspeed = GameSpeed;
    sp = initSp;
    score = 0;
  }

  Widget get _main => GestureDetector(
    onTap: _jump,
    child: SafeArea(
      child: Stack(
        children: [

          Column(mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                //alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [

                      Colors.green,
                      Colors.blue,


                    ],begin: Alignment.bottomCenter,end: Alignment.topCenter)
                ),
                //margin: EdgeInsets.only(top: 120),
                child: Center(
                  child: Stack(
                    children: [
                      Directionality(textDirection: TextDirection.rtl,
                        child: Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(alignment: Alignment.topCenter,
                              child: Container(
                                child: Text('ماریو',style: TextStyle(fontFamily: ArabicFonts.Reem_Kufi,package: 'google_fonts_arabic',fontWeight: FontWeight.bold,fontSize: 30,color: Colors.red[900]), ),
                              ),
                            ),
                            SizedBox(width: 10,),
                            Align(alignment: Alignment.topCenter,
                              child: Container(
                                child: Text('قشمی',style: TextStyle(fontFamily: ArabicFonts.Reem_Kufi,package: 'google_fonts_arabic',fontWeight: FontWeight.bold,fontSize: 30,color: Colors.blue[900]), ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(alignment: Alignment.topLeft,
                        child: Container(
                          margin: EdgeInsets.only(left: 10,top: 5),
                          child: Text('امتیاز : '+score.toString(),style: TextStyle(color: Colors.black87,fontSize: 20,fontWeight: FontWeight.bold,
                              fontFamily: ArabicFonts.Reem_Kufi,
                              package: 'google_fonts_arabic'
                          ),),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: mainWidth,
                height: mainHeight,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('assets/pass.jpg',),fit: BoxFit.fill,)
                ),
                child: Stack(
                  children: [
                    _mplayer.getPlayer,
                    Stack(
                      children: _obstacle.map((obs) => obs.getObstacle).toList(),

                    ),

                    Align(alignment: Alignment.bottomRight,
                      child: Container(
                        width: 100,
                        height: 120,
                        margin: EdgeInsets.only(right: 50),
                        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/tablo.png'),fit: BoxFit.fill)),

                        child: Container(
                          color: Colors.green,
                          margin: EdgeInsets.only(bottom: 60,left: 3,right: 3,top: 3),
                          padding: EdgeInsets.all(1),
                          child: Center(
                            child: Text('خدمات ایزوگام جزیره با ۱۰ سال ضمانت :\nشماره تماس : 09335825325',style: TextStyle(

                                fontFamily: ArabicFonts.Markazi_Text,
                                package: 'google_fonts_arabic',
                                color: Colors.black,
                                fontSize: 10,
                                fontWeight: FontWeight.w100


                            ),textDirection: TextDirection.rtl,),
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),




        ],
      ),
    ),
  );
}

class TapFadeText extends StatefulWidget {

  final Widget child;

  TapFadeText({
this.child
});

  @override
  _TapFadeTextState createState() => _TapFadeTextState();
}

class _TapFadeTextState extends State<TapFadeText> with SingleTickerProviderStateMixin {

  AnimationController _controller;
  Animation <double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = Tween<double>(
      begin: 1.0,
      end: 0.0,
    ).animate(_controller);
    _controller.repeat();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _animation,
    child: widget.child,
    );
  }
}
