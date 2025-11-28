// lib/models/quiz_question.dart
class QuizQuestion {
  final String id;
  final String category; // Python / R / SQL / DS
  final String question;
  final List<String> options;
  final int correctIndex;

  QuizQuestion({
    required this.id,
    required this.category,
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}
