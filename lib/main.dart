import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.orange, // Change the primary color
      ),
      home: WelcomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
        backgroundColor: Colors.orange, // Change the app bar color
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to the Quiz App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => QuizScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange, // Change the button color
              ),
              child: Text('Start', style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentIndex = 0;
  int _score = 0;
  bool _submitted = false;

  List<Map<String, dynamic>> questions = [
    {
      'question': 'What is the full form of eBPF?',
      'options': ['Extended Berkeley Packet Filter', 'Extra Berkeley Packet Filter', 'Extended Bucket Packet Filter', 'Extended Berkeley Packet Filler'],
      'correctIndex': 0,
    },
    {
      'question': 'Which programming language is Flutter based on?',
      'options': ['Dart', 'Java', 'Python', 'C++'],
      'correctIndex': 0,
    },
    {
      'question': 'What is the name of the most popular operating system for smartphones?',
      'options': ['Android', 'Windows', 'IOS', 'Linux'],
      'correctIndex': 0,
    },
    {
      'question': 'What is the primary benefit of using Flutter compared to native Android development?',
      'options': ['Faster development', 'Cross-platform development with a single codebase', 'More reliable apps', 'Easier integration with native features'],
      'correctIndex': 1,
    },
    {
      'question': 'How can you navigate to a different screen in a Flutter app?',
      'options': ['Using Navigator.push()', 'Using Navigator.pop()', 'Using Navigator.pushReplacement()', 'All of the above'],
      'correctIndex': 3,
    },
    {
      'question': 'What is a potential disadvantage of using Flutter for building high-performance apps?',
      'options': ['Slower development compared to native apps', 'Larger app size', 'Limited access to native features', 'Difficulty with state management'],
      'correctIndex': 1,
    },
    {
      'question': 'What is a key technique for optimizing the performance of a Flutter app?',
      'options': ['Using proper state management techniques', 'Optimizing animations and transitions', 'Using profiler tools to identify bottlenecks', 'All of the above'],
      'correctIndex': 3,
    },
    {
      'question': 'What platform is this app built on?',
      'options': ['Dart', 'Flutter', 'Android SDK', 'Swift'],
      'correctIndex': 2,
    },
  ];

  void _checkAnswer(int selectedIndex) {
    if (_currentIndex <= questions.length - 1 && !_submitted) {
      if (selectedIndex == questions[_currentIndex]['correctIndex']) {
        setState(() {
          _score++;
        });
      }
    }
  }

  void _nextQuestion() {
    setState(() {
      if (_currentIndex < questions.length - 1 && !_submitted) {
        _currentIndex++;
      } else if (_currentIndex == questions.length - 1) {
        _submitted = true;
        _submitQuiz();
      }
    });
  }

  void _previousQuestion() {
    setState(() {
      if (_currentIndex > 0 && !_submitted) {
        _currentIndex--;
      }
    });
  }

  void _submitQuiz() {
    setState(() {
      _submitted = true;
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Quiz Results'),
        content: Text('Your Score: $_score / ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              _restartQuiz();
              Navigator.pop(context);
            },
            child: Text('Restart Quiz', style: TextStyle(color: Colors.orange)),
          ),
        ],
      ),
    );
  }

  void _restartQuiz() {
    setState(() {
      _currentIndex = 0;
      _score = 0;
      _submitted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz App'),
        backgroundColor: Colors.orange,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${_currentIndex + 1}/${questions.length}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.orange,
              ),
            ),
            SizedBox(height: 16),
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Text(
                      questions[_currentIndex]['question'],
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    ...((questions[_currentIndex]['options'] as List<String>)
                        .asMap()
                        .entries
                        .map(
                          (entry) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: ElevatedButton(
                              onPressed: _submitted
                                  ? null
                                  : () {
                                      _checkAnswer(entry.key);
                                      _nextQuestion();
                                    },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white,
                                onPrimary: Colors.orange,
                                textStyle: TextStyle(fontSize: 16),
                              ),
                              child: Text(entry.value),
                            ),
                          ),
                        )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_currentIndex > 0)
                  ElevatedButton(
                    onPressed: () {
                      _previousQuestion();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    child:
                       const Text('Previous', style: TextStyle(color: Colors.white)),
                  ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? null
                      : () {
                          _submitQuiz();
                        },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  child: const Text('Submit', style: TextStyle(color: Colors.white)),
                ),
                SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _submitted
                      ? () {
                          _restartQuiz();
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  child: const Text('Restart', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_submitted)
              Center(
                child: Text(
                  'Your Score: $_score / ${questions.length}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_submitted) {
            _nextQuestion();
          }
        },
        child: Icon(Icons.navigate_next),
        backgroundColor: Colors.orange,
      ),
    );
  }
}