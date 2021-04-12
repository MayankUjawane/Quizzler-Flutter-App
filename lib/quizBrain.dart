import 'package:flutter/cupertino.dart';
import 'package:quiz_app_flutter/question.dart';

class QuizBrain {
  int _currentNumber = 0;
  List<Question> _detailsList = [
    Question(questions: 'I am a Tech guy', answers: true),
    Question(questions: 'I want to explore everything', answers: true),
    Question(questions: 'I want to become Master of all', answers: true),
    Question(questions: 'I am not intelligent', answers: false)
  ];

  int totalNumberOfQuestions(){
    return _detailsList.length;
  }

  void nextQuestion(){
    if(_currentNumber < _detailsList.length-1){
      _currentNumber++;
    }
  }

  String getQuestion() {
    return _detailsList[_currentNumber].questions;
  }

  bool getAnswer() {
    return _detailsList[_currentNumber].answers;
  }

  void reset(){
    _currentNumber = 0;
  }

  bool isQuizFinished(){
    if(_currentNumber == _detailsList.length-1){
      return true;
    } else {
      return false;
    }
  }
}