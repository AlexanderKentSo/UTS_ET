// ignore_for_file: non_constant_identifier_names

import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class Quest {
  String pic1;
  String pic2;
  String pic3;
  String pic4;
  String ans;

  Quest(this.pic1, this.pic2, this.pic3, this.pic4, this.ans);
}

class permainan extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => permainanSC();
}

class permainanSC extends State<permainan> {
  int init = 5, hitung = 60, initValue = 60; // init buat nunjukin gbr di awal
  int qNum = 1, score = 0;

  String message = "";
  Quest currentQ = Quest("", "", "", "", "");

  var questions = <Quest>[];
  var num = <Quest>[];

  late Timer t;

  void initState() {
    super.initState();
    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {});
    t.cancel();
  }

  void Start() {
    init = 5;
    hitung = initValue;
    qNum = 1;
    score = 0;
    num.clear();
    questions.clear();

    questions.add(Quest("../asset/sushi1.jpg", "../asset/sushi2.jpg",
        "../asset/sushi3.jpg", "../asset/sushi4.jpg", ""));
    questions.add(Quest("../asset/bug1.jpg", "../asset/bug2.jpg",
        "../asset/bug3.jpg", "../asset/bug4.jpg", ""));
    questions.add(Quest("../asset/cat1.jpg", "../asset/cat2.jpg",
        "../asset/cat3.jpg", "../asset/cat4.jpg", ""));
    questions.add(Quest("../asset/fruit1.jpg", "../asset/fruit2.jpg",
        "../asset/fruit3.jpg", "../asset/fruit4.jpg", ""));
    questions.add(Quest("../asset/onigiri1.jpg", "../asset/onigiri2.jpg",
        "../asset/onigiri3.jpg", "../asset/onigiri4.jpg", ""));
    questions.add(Quest("../asset/soup1.jpg", "../asset/soup2.jpg",
        "../asset/soup3.jpg", "../asset/soup4.jpg", ""));
    questions.add(Quest("../asset/uni1.jpg", "../asset/uni2.jpg",
        "../asset/uni3.jpg", "../asset/uni4.jpg", ""));
    questions.add(Quest("../asset/comp1.jpg", "../asset/comp2.jpg",
        "../asset/comp3.jpg", "../asset/comp4.jpg", ""));
    questions.add(Quest("../asset/sam1.jpg", "../asset/sam2.jpg",
        "../asset/sam3.jpg", "../asset/sam4.jpg", ""));
    questions.add(Quest("../asset/building1.jpg", "../asset/building2.jpg",
        "../asset/building3.jpg", "../asset/building4.jpg", ""));

    Continue();
  }

  void Stop() {
    setState(() {
      t.cancel();
      message = "Paused";
    });
  }

  void Continue() {
    t = Timer.periodic(Duration(milliseconds: 1000), (timer) {
      setState(() {
        if (init >= 0) {
          init--;
          message = "Remember the cards";
          int index = Random().nextInt(questions.length);
          if (num.length < 5) {
            currentQ = questions[index];
            num.add(currentQ);
            questions.removeAt(index);
          }
        } else {
          message = "Which card have you seen before ?";
          if (hitung >= 0 && qNum <= 5) {
            hitung--;
            currentQ = num[0];
          } else {
            message = "Quiz's over";
            qNum = 5;
            t.cancel();
          }
        }
      });
    });
  }

  void over() {
    setState(() {
      t.cancel();
    });
  }

  String formatTime(int hitung) {
    var hours = (hitung ~/ 3600).toString().padLeft(2, '0');
    var minutes = ((hitung % 3600) ~/ 60).toString().padLeft(2, '0');
    var seconds = (hitung % 60).toString().padLeft(2, '0');
    return "$hours:$minutes:$seconds";
  }

  void CheckAns(String ans, Quest q) {
    if (ans == q.ans) {
      score++;
    }
    qNum++;
    num.removeAt(0);
  }

  Widget question(Quest q) {
    Widget w = Column(children: [
      SizedBox(
          width: 150,
          height: 50,
          child: FloatingActionButton(onPressed: Start, child: Text("Start"))),
      SizedBox(height: 50),
      Text("illustration by irasutoya.com (copyright free)")
    ]);
    if (t.isActive) {
      if (init >= 0) {
        int pic = Random().nextInt(4);
        if (pic == 1) {
          w = SizedBox(width: 250, height: 250, child: Image.network(q.pic1));
          q.ans = q.pic1;
        } else if (pic == 2) {
          w = SizedBox(width: 250, height: 250, child: Image.network(q.pic2));
          q.ans = q.pic2;
        } else if (pic == 3) {
          w = SizedBox(width: 250, height: 250, child: Image.network(q.pic3));
          q.ans = q.pic3;
        } else {
          w = SizedBox(width: 250, height: 250, child: Image.network(q.pic4));
          q.ans = q.pic4;
        }
      } else if (init == -1) {
        w = Text("");
        init--;
      } else {
        w = Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Row(children: [
            SizedBox(
                width: 180,
                height: 180,
                child: FloatingActionButton(
                    onPressed: () => CheckAns(q.pic1, q),
                    child: Image.network(q.pic1))),
            SizedBox(width: 20),
            SizedBox(
                width: 180,
                height: 180,
                child: FloatingActionButton(
                    onPressed: () => CheckAns(q.pic2, q),
                    child: Image.network(q.pic2)))
          ]),
          SizedBox(height: 20),
          Row(children: [
            SizedBox(
                width: 180,
                height: 180,
                child: FloatingActionButton(
                    onPressed: () => CheckAns(q.pic3, q),
                    child: Image.network(q.pic3))),
            SizedBox(width: 20),
            SizedBox(
                width: 180,
                height: 180,
                child: FloatingActionButton(
                    onPressed: () => CheckAns(q.pic4, q),
                    child: Image.network(q.pic4)))
          ])
        ]);
      }
    } else if (message == "Quiz's over") {
      String title = "Sfortunato Indovinatore (Unlucky Guesser)";
      if (score == 5) {
        title = "Maestro dell'Indovinello (Master of Riddles)";
      } else if (score == 4) {
        title = "Esperto dell'Indovinello (Expert of Riddles)";
      } else if (score == 3) {
        title = "Abile Indovinatore (Skillful Guesser)";
      } else if (score == 2) {
        title = "Principiante dell'Indovinello (Riddle Beginner)";
      } else if (score == 1) {
        title = "Neofita dell'Indovinello (Riddle Novice)";
      }
      w = Column(
        children: [
          SizedBox(height: 50),
          Text("Your Score"),
          Text(style: TextStyle(fontSize: 30), score.toString()),
          Text(title),
          SizedBox(height: 30),
          SizedBox(
              width: 150,
              height: 50,
              child: FloatingActionButton(
                  onPressed: Start, child: Text("Try again")))
        ],
      );
    } else if (message == "Paused") {
      w = Column(
        children: [
          SizedBox(height: 50),
          Text("ceritanya how to play"),
          SizedBox(height: 30),
          FloatingActionButton(onPressed: Start, child: Icon(Icons.replay))
        ],
      );
    }
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text("Permainan"),
        ),
        body: Center(
            child: Padding(
                padding: EdgeInsets.all(30.0),
                child: Column(
                  children: [
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                              onPressed: (t.isActive) ? Stop : Continue,
                              icon: Icon(
                                  t.isActive ? Icons.pause : Icons.play_arrow)),
                          SizedBox(width: 270),
                          Row(children: [
                            Text(score.toString()),
                            Icon(Icons.monetization_on),
                            SizedBox(width: 20),
                            Text(qNum.toString() + "/5"),
                            SizedBox(width: 20),
                            CircularPercentIndicator(
                              radius: 15.0,
                              lineWidth: 15.0,
                              percent: (hitung / initValue),
                              backgroundColor:
                                  Color.fromARGB(149, 191, 212, 213),
                              progressColor: Color.fromARGB(255, 9, 255, 0),
                            )
                          ])
                        ]),
                    SizedBox(height: 20),
                    Text(message,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 24)),
                    Container(
                      child: question(currentQ),
                    )
                  ],
                ))));
  }
}
