import 'package:flutter/material.dart';

import './quiz.dart';
import './result.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final _questions = const [
    {
      'questionText':
          'Q1. What is the primary function of an operating system?',
      'answers': [
        {'text': 'Run applications', 'score': -2},
        {'text': 'Manage hardware resources', 'score': -2},
        {'text': 'Connect to the internet', 'score': 10},
        {'text': 'Create documents', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q2. What is the purpose of the kernel in an operating system?',
      'answers': [
        {'text': 'Provide a graphical user interface', 'score': -2},
        {'text': 'Manage memory and processes', 'score': -2},
        {'text': 'Execute application programs', 'score': 10},
        {'text': 'Connect to external devices', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q3. Which scheduling algorithm is used in most operating systems?',
      'answers': [
        {'text': 'First-Come, First-Served (FCFS)', 'score': -2},
        {'text': 'Shortest Job Next (SJN)', 'score': -2},
        {'text': 'Round Robin (RR)', 'score': 10},
        {'text': 'Priority Scheduling', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q4. What is the role of the File System in an operating system?',
      'answers': [
        {'text': 'Manage RAM', 'score': -2},
        {'text': 'Store and organize files on storage devices', 'score': -2},
        {'text': 'Control network traffic', 'score': 10},
        {'text': 'Execute application code', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q5. Which of the following is not a type of operating system?',
      'answers': [
        {'text': 'Windows', 'score': -2},
        {'text': 'Linux', 'score': -2},
        {'text': 'Microsoft Office', 'score': -2},
        {'text': 'macOS', 'score': 10},
      ],
    },
    {
      'questionText': ' Q6. What is the purpose of virtual memory?',
      'answers': [
        {'text': 'Increase the physical RAM size', 'score': -2},
        {'text': 'Create virtual machines', 'score': 10},
        {'text': 'Store temporary files', 'score': -2},
        {'text': 'Manage user accounts', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q7. What is the function of a device driver in an operating system?',
      'answers': [
        {'text': 'Manage user accounts', 'score': 10},
        {'text': 'Provide security features', 'score': -2},
        {
          'text':
              'Translate communication between the operating system and hardware devices',
          'score': -2
        },
        {'text': 'Run application software', 'score': -2},
      ],
    },
    {
      'questionText':
          'Q8. Is Flutter for Web and Desktop available in stable version?',
      'answers': [
        {
          'text': 'Yes',
          'score': -2,
        },
        {'text': 'No', 'score': 10},
      ],
    },
  ];

  var _questionIndex = 0;
  var _totalScore = 0;

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex = _questionIndex + 1;
    });
    // ignore: avoid_print
    print(_questionIndex);
    if (_questionIndex < _questions.length) {
      // ignore: avoid_print
      print('We have more questions!');
    } else {
      // ignore: avoid_print
      print('No more questions!');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Geeks for Geeks'),
          backgroundColor: const Color(0xFF00E676),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: _questionIndex < _questions.length
              ? Quiz(
                  answerQuestion: _answerQuestion,
                  questionIndex: _questionIndex,
                  questions: _questions,
                ) //Quiz
              : Result(_totalScore, _resetQuiz),
        ), //Padding
      ), //Scaffold
      debugShowCheckedModeBanner: false,
    ); //MaterialApp
  }
}
