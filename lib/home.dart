import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, bool> score = {};
  Map<String, Color> choice = {
    '🍎': Colors.red,
    '🌰': Colors.brown,
    '🍇': Colors.purple,
    '🍊': Colors.orange,
    '🍏': Colors.green,
    '🌻': Colors.yellow,
    '🔵': Colors.blue,
  };
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kids App",
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: choice.keys.map((element) {
              return Draggable<String>(
                  data: element,
                  child:
                      Moveable(emoji: score[element] == true ? '✔' : element),
                  feedback: Moveable(
                    emoji: element,
                  ),
                  childWhenDragging: Moveable(emoji: '🐕'));
            }).toList(),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:choice.keys.map((element){
              return buildTarget(element);
            }).toList()..shuffle(Random(index)),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: (){
          setState(() {
            score.clear();
            index++;
          });
        },
      ),
    );
  }

  Widget buildTarget(String element) {
    return DragTarget<String>(
        builder:(context,accept,reject){
          if(score[element]==true)
            {
              return Container(
                color: Colors.white,
                child: Text("Congratulations"),
                alignment: Alignment.center,
                height: 80,
                width: 200,
              );
            }
          else{
            return Container(
              color:choice[element] ,
              height: 80,
              width: 200,
            );
          }
        },
      onWillAccept: (data)=>data==element,
        onAccept: (data){
          setState(() {
            score[element]=true;
           /* play music */
            // player.play('song.mp3');

          });
        },
        onLeave: (data)=>null,

    );
  }
}

class Moveable extends StatelessWidget {
  final String emoji;

  Moveable({this.emoji});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Material(
      color: Colors.transparent,
      child: Container(
        child: Text(
          emoji,
          style: TextStyle(fontSize: 50, color: Colors.black),
        ),
        height: 85,
        padding: EdgeInsets.all(15),
      ),
    );
    throw UnimplementedError();
  }
}
