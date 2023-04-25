import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:flutter/services.dart';

class TicTacToe extends StatelessWidget {
  const TicTacToe({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TicTacToe Game',
      home: HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool turn0 = true;
  List<String> elements = ['', '', '', '', '', '', '', '', ''];
  bool isWinner = false;
  int score0 = 0;
  int xscore = 0;
  int filled_index = 0;

  late ConfettiController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _controller = ConfettiController(duration: const Duration(seconds: 10));
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
     onWillPop: ()=> _onPop(),
       child: Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Tic Tac Toe',
              style: TextStyle(
                  fontStyle: FontStyle.italic,
                  color: Colors.yellow,
                  fontWeight: FontWeight.bold,
                  fontSize: 40.0),
            ),
          ),
          //backgroundColor: Colors.purple,
        ),
        body: Container(
          decoration: const BoxDecoration(
            //color: const Color(0xff7c94b6),
            image: DecorationImage(
              image: AssetImage('assets/images/download.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Player 0',
                            style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          Text(
                            score0.toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('Player X',
                              style: TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black)),
                          Text(
                            xscore.toString(),
                            style: const TextStyle(
                              fontSize: 30,
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: 9,
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            _tapped(index);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 2),
                            ),
                            child: Center(
                              child: Text(
                                elements[index],
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 60,
                                    fontWeight: FontWeight.w400),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: TextButton(
                    style: ButtonStyle(
                      foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.amberAccent),
                      backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.blueAccent),
                    ),
                    onPressed: _clearScoreBoard,
                    child: const Text('Clear Score Board',
                        style: TextStyle(
                            fontSize: 25,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (turn0 && elements[index] == '') {
        elements[index] = 'O';
        filled_index++;
      } else if (!turn0 && elements[index] == '') {
        elements[index] = 'X';
        filled_index++;
      }

      turn0 = !turn0;
      _checkWinner();
    });
  }

  void _checkWinner() {
    // Checking rows
    if (elements[0] == elements[1] &&
        elements[0] == elements[2] &&
        elements[0] != '') {
      _result(elements[0]);
    }
    if (elements[3] == elements[4] &&
        elements[3] == elements[5] &&
        elements[3] != '') {
      _result(elements[3]);
    }
    if (elements[6] == elements[7] &&
        elements[6] == elements[8] &&
        elements[6] != '') {
      _result(elements[6]);
    }

    // Checking Column
    if (elements[0] == elements[3] &&
        elements[0] == elements[6] &&
        elements[0] != '') {
      _result(elements[0]);
    }
    if (elements[1] == elements[4] &&
        elements[1] == elements[7] &&
        elements[1] != '') {
      _result(elements[1]);
    }
    if (elements[2] == elements[5] &&
        elements[2] == elements[8] &&
        elements[2] != '') {
      _result(elements[2]);
    }

    // Checking Diagonal
    if (elements[0] == elements[4] &&
        elements[0] == elements[8] &&
        elements[0] != '') {
      _result(elements[0]);
    }
    if (elements[2] == elements[4] &&
        elements[2] == elements[6] &&
        elements[2] != '') {
      _result(elements[2]);
    } else if (filled_index == 9) {
      _draw();
    }
  }

  void _result(String winner) {
    _controller.play();

    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return Stack(
            alignment: Alignment.center,
            children: [
              AlertDialog(
                    title: Center(child: Text("\" $winner \" is Winner!!!")),
                    actions: [
                      TextButton(
                        child: const Text("Play Again",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                        onPressed: () {
                          _clearBoard();
                          Navigator.of(context).pop();
                          _controller.stop();
                        }
                      ),
                      TextButton(
                          child: const Text("Exit",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400),),
                          onPressed: () {
                            _clearBoard();
                            Navigator.of(context).pop();
                            _controller.stop();
                            _onPop();
                          }
                      ),
                    ],
                  ),
              Positioned(
                top: MediaQuery.of(context).size.height/2-120,
                child: ConfettiWidget(confettiController: _controller,
                    shouldLoop: true,
                    emissionFrequency: 0.05,
                    blastDirectionality: BlastDirectionality.explosive,
                    gravity: 0.1,
                ),
              ),
            ],
          );
        });

    if (winner == 'O') {
      score0++;
    } else if (winner == 'X') {
      xscore++;
    }
  }

  void _draw() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Draw"),
            actions: [
              TextButton(
                child: const Text("Play Again"),
                onPressed: () {
                  _clearBoard();
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        elements[i] = '';
      }
    });

    filled_index = 0;
  }

  void _clearScoreBoard() {
    setState(() {
      score0 = 0;
      xscore = 0;
      for (int i = 0; i < 9; i++) {
        elements[i] = '';
      }
    });
    filled_index = 0;
  }
}

Future<bool> _onPop() async{
  await SystemNavigator.pop();
  return true;
}
