import 'package:flutter/material.dart';
import 'dart:math';
import '../data/mock_data.dart';

class FlashcardsScreen extends StatefulWidget {
  const FlashcardsScreen({super.key});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  int currentIndex = 0;
  bool isFlipped = false;

  void _nextCard() {
    setState(() {
      isFlipped = false;
      currentIndex = (currentIndex + 1) % mockFlashcards.length;
    });
  }

  void _flipCard() {
    setState(() {
      isFlipped = !isFlipped;
    });
  }

  @override
  Widget build(BuildContext context) {
    final flashcard = mockFlashcards[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcards'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shuffle),
            onPressed: () {
              // Mélanger (simulation simple)
              setState(() {
                currentIndex = Random().nextInt(mockFlashcards.length);
                isFlipped = false;
              });
            },
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Carte ${currentIndex + 1} / ${mockFlashcards.length}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          GestureDetector(
            onTap: _flipCard,
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (Widget child, Animation<double> animation) {
                final rotateAnim = Tween(begin: pi, end: 0.0).animate(animation);
                return AnimatedBuilder(
                  animation: rotateAnim,
                  child: child,
                  builder: (context, child) {
                    final isUnder = (ValueKey(isFlipped) != child!.key);
                    var tilt = ((animation.value - 0.5).abs() - 0.5) * 0.003;
                    tilt *= isUnder ? -1.0 : 1.0;
                    final value = isUnder ? min(rotateAnim.value, pi / 2) : rotateAnim.value;
                    return Transform(
                      transform: Matrix4.rotationY(value)..setEntry(3, 0, tilt),
                      alignment: Alignment.center,
                      child: child,
                    );
                  },
                );
              },
              child: isFlipped
                  ? _buildCardSide(flashcard.answer, Colors.green.shade100, true)
                  : _buildCardSide(flashcard.question, Colors.blue.shade100, false),
            ),
          ),
          const SizedBox(height: 40),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                onPressed: _flipCard,
                icon: const Icon(Icons.rotate_right),
                label: const Text('Retourner'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _nextCard,
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Suivante'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardSide(String text, Color color, bool isBack) {
    return Container(
      key: ValueKey(isBack),
      width: 300,
      height: 400,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            isBack ? 'RÉPONSE' : 'QUESTION',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
