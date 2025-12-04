import 'package:flutter/material.dart';
import '../data/mock_data.dart';

class QuizListScreen extends StatelessWidget {
  const QuizListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Quiz Disponibles')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: mockQuizzes.length,
        itemBuilder: (context, index) {
          final quiz = mockQuizzes[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            child: ListTile(
              leading: const Icon(Icons.quiz, color: Colors.deepPurple),
              title: Text(quiz.title),
              subtitle: Text('${quiz.questions.length} questions • ${quiz.subject}'),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => QuizPlayScreen(quiz: quiz),
                    ),
                  );
                },
                child: const Text('Jouer'),
              ),
            ),
          );
        },
      ),
    );
  }
}

class QuizPlayScreen extends StatefulWidget {
  final Quiz quiz;

  const QuizPlayScreen({super.key, required this.quiz});

  @override
  State<QuizPlayScreen> createState() => _QuizPlayScreenState();
}

class _QuizPlayScreenState extends State<QuizPlayScreen> {
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedOptionIndex;
  bool isAnswered = false;

  void _answerQuestion(int index) {
    if (isAnswered) return;

    setState(() {
      selectedOptionIndex = index;
      isAnswered = true;
      if (index == widget.quiz.questions[currentQuestionIndex].correctIndex) {
        score++;
      }
    });
  }

  void _nextQuestion() {
    if (currentQuestionIndex < widget.quiz.questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
        isAnswered = false;
      });
    } else {
      _showResultDialog();
    }
  }

  void _showResultDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Terminé !'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.emoji_events, size: 60, color: Colors.amber),
            const SizedBox(height: 16),
            Text(
              'Votre score : $score / ${widget.quiz.questions.length}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Fermer dialog
              Navigator.pop(context); // Retour liste
            },
            child: const Text('Terminer'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.quiz.questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Question ${currentQuestionIndex + 1}/${widget.quiz.questions.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / widget.quiz.questions.length,
              backgroundColor: Colors.grey[200],
              color: Colors.deepPurple,
            ),
            const SizedBox(height: 32),
            Text(
              question.question,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ...List.generate(question.options.length, (index) {
              Color color = Colors.white;
              if (isAnswered) {
                if (index == question.correctIndex) {
                  color = Colors.green.shade100;
                } else if (index == selectedOptionIndex) {
                  color = Colors.red.shade100;
                }
              }

              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: InkWell(
                  onTap: () => _answerQuestion(index),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: color,
                      border: Border.all(
                        color: isAnswered && index == selectedOptionIndex
                            ? Colors.deepPurple
                            : Colors.grey.shade300,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.grey.shade200,
                          child: Text(
                            String.fromCharCode(65 + index),
                            style: const TextStyle(fontSize: 12, color: Colors.black),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            question.options[index],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        if (isAnswered && index == question.correctIndex)
                          const Icon(Icons.check_circle, color: Colors.green),
                        if (isAnswered && index == selectedOptionIndex && index != question.correctIndex)
                          const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                ),
              );
            }),
            const Spacer(),
            if (isAnswered)
              ElevatedButton(
                onPressed: _nextQuestion,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: Text(
                  currentQuestionIndex < widget.quiz.questions.length - 1
                      ? 'Question Suivante'
                      : 'Voir les Résultats',
                ),
              ),
          ],
        ),
      ),
    );
  }
}
