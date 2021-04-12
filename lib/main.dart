import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:quiz_app_flutter/quizBrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() {
  runApp(Quizzler());
}

QuizBrain quizBrain = QuizBrain();

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.grey.shade900,
          appBar: AppBar(
            title: Text('Quizzler'),
            backgroundColor: Colors.blueGrey.shade700,
          ),
          body: Padding(
            padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 5.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Widget> setIcon = [];
  int correctScore = 0;

  void addIcon(bool userSelectedAnswer){
    if(quizBrain.getAnswer() == userSelectedAnswer){
      setIcon.add(Icon(Icons.check, color: Colors.green));
      correctScore++;
    } else {
      setIcon.add(Icon(Icons.close, color: Colors.red));
    }
  }

  void checkAnswer(bool userSelectedAnswer){
    setState(() {
      addIcon(userSelectedAnswer);
      if(quizBrain.isQuizFinished()){
        Alert(context: context, title: "Quiz Finished", desc: "Your Score is $correctScore/${quizBrain.totalNumberOfQuestions()}").show();
        quizBrain.reset();
        setIcon = [];
        correctScore = 0;
      } else {
        quizBrain.nextQuestion();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Text(quizBrain.getQuestion(),
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.blue,
                fontSize: 30.0,
                fontWeight: FontWeight.w800
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            child: Text(
              'True',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              elevation: 1,
              shadowColor: Colors.white,
            ),
            onPressed: () {
                checkAnswer(true);
            },
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Expanded(
          flex: 1,
          child: ElevatedButton(
            child: Text(
              'False',
              style: TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              elevation: 1,
              shadowColor: Colors.white,
            ),
            onPressed: () {
                checkAnswer(false);
            },
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: setIcon,
        )
      ],
    );
  }
}
