// lib/features/quiz/quiz_page.dart
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import '../../models/quiz_question.dart';

class QuizPage extends StatefulWidget {
  final String title;
  final List<QuizQuestion> questions;

  const QuizPage({
    super.key,
    required this.title,
    required this.questions,
  });

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  int _score = 0;
  bool _answered = false;
  int? _selectedIndex;

  final AudioPlayer _player = AudioPlayer();

  Future<void> _playCorrectSound() async {
    await _player.play(AssetSource('sounds/correct.mp3'));
  }

  Future<void> _playWrongSound() async {
    await _player.play(AssetSource('sounds/wrong.mp3'));
  }

  void _onSelectOption(int index) {
    if (_answered) return;

    final currentQuestion = widget.questions[_currentIndex];
    setState(() {
      _selectedIndex = index;
      _answered = true;
    });

    final isCorrect = index == currentQuestion.correctIndex;
    if (isCorrect) {
      _score++;
      _playCorrectSound();
    } else {
      _playWrongSound();
    }
  }

  void _nextQuestion() {
    if (_currentIndex < widget.questions.length - 1) {
      setState(() {
        _currentIndex++;
        _answered = false;
        _selectedIndex = null;
      });
    } else {
      // selesai
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
          title: const Text('Quiz selesai'),
          content: Text(
              'Skor kamu: $_score dari ${widget.questions.length}\n\nMantap, lanjut eksplor materi lain!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // tutup dialog
                Navigator.pop(context); // kembali ke sebelum quiz
              },
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Soal ${_currentIndex + 1} dari ${widget.questions.length}',
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 12),
            Text(
              question.question,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 20),
            ...List.generate(question.options.length, (index) {
              final option = question.options[index];
              final isSelected = index == _selectedIndex;
              final isCorrect = index == question.correctIndex;

              Color? tileColor;
              if (_answered && isSelected) {
                tileColor = isCorrect ? Colors.green[100] : Colors.red[100];
              }

              return Card(
                color: tileColor,
                child: ListTile(
                  title: Text(option),
                  onTap: () => _onSelectOption(index),
                ),
              );
            }),
            const Spacer(),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: _answered ? _nextQuestion : null,
                child: Text(
                    _currentIndex == widget.questions.length - 1 ? 'Selesai' : 'Lanjut'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
