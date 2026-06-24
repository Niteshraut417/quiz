import 'package:flutter/material.dart';
import 'question.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestion = 0;
  int score = 0;

  final List<Question> questions = [
    Question(
      questionText: "What is Flutter?",
      answers: ["Language", "Framework", "Database", "OS"],
      correctAnswer: 1,
    ),
    Question(
      questionText: "Who developed Dart?",
      answers: ["Google", "Microsoft", "Apple", "Meta"],
      correctAnswer: 0,
    ),
    Question(
      questionText: "2 + 2 = ?",
      answers: ["3", "4", "5", "6"],
      correctAnswer: 1,
    ),
  ];

  void answerQuestion(int selectedIndex) {
    if (selectedIndex ==
        questions[currentQuestion].correctAnswer) {
      score++;
    }

    if (currentQuestion < questions.length - 1) {
      setState(() {
        currentQuestion++;
      });
    } else {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text("Quiz Finished"),
          content: Text(
            "Your Score: $score/${questions.length}",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentQuestion = 0;
                  score = 0;
                });
              },
              child: const Text("Restart"),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz App"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              q.questionText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30),
            ...List.generate(
              q.answers.length,
              (index) => Container(
                width: double.infinity,
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () =>
                      answerQuestion(index),
                  child: Text(q.answers[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
