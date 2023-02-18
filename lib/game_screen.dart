import 'package:flutter/material.dart';
import 'package:hangman/const/const.dart';
import 'package:hangman/game/figure_widget.dart';
import 'package:hangman/game/hidden_letters.dart';
import 'dart:math';

class HangmanGame {
  final List<String> wordList = ['apple', 'banana', 'cherry', 'orange', 'pineapple', 'grape'];
  late String word;

  HangmanGame() {
    // Select a random word from the list
    word = wordList[Random().nextInt(wordList.length)];
    // Print the chosen word (for testing purposes)

  }
}

class GameScreen extends StatefulWidget {
final String word;
  const GameScreen({Key? key,required this.word}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late String _currentWord;

@override
void initState() {
  super.initState();
  _currentWord = widget.word;
}

  var characters="abcdefghijklmnopqrstuv".toUpperCase();

  List<String> selectedChar=[];
  var tries=0;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("HangMan Game"),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,

      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
              child: Column(
                children: [
                  Expanded(
                      flex:4,
                      child: Stack(
                  children: [
                    figure(GameUI.hang, tries>=0),
                    figure(GameUI.head, tries>=1),
                    figure(GameUI.body, tries>=2),
                    figure(GameUI.leftArm, tries>=3),
                    figure(GameUI.rightArm, tries>=4),
                    figure(GameUI.leftLeg, tries>=5),
                    figure(GameUI.rightLeg, tries>=6),
                  ],
                  )
                  ),
                  Expanded(

                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _currentWord.split("").map((e) => hiddenletter(e,!selectedChar.contains(e.toUpperCase()))).toList(),
                        ),
                  )
                  )
                ],
              ),
          ),
          Expanded(
            flex: 2,
              child: Container(
                padding: const EdgeInsets.all(8.0),
                child: GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 4,
                  mainAxisSpacing: 4,
                  crossAxisCount: 7,
                  children: characters.split("").map((e) {
                    return ElevatedButton(

                        style: ElevatedButton.styleFrom(
                          primary: Colors.black54,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20), // set the border radius
                          ),
                        ),
                        onPressed:selectedChar.contains(e.toUpperCase())? null:(){
                          setState(() {
                            selectedChar.add(e.toUpperCase());
                            if(!_currentWord.split("").contains(e.toUpperCase())){
                              tries++;
                            };
                          });
                        }, child: Text(e,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    ));
                  }).toList(),
                ),
              )
          ),
        ],
      ),
    );
  }
}
