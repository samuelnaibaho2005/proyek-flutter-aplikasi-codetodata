// lib/data/sample_quizzes.dart
import '../models/quiz_question.dart';

final sampleQuizPythonBasic = <QuizQuestion>[
  QuizQuestion(
    id: 'q1',
    category: 'Python',
    question: 'Tipe data apa yang cocok untuk menyimpan nilai True/False di Python?',
    options: ['int', 'float', 'bool', 'str'],
    correctIndex: 2,
  ),
  QuizQuestion(
    id: 'q2',
    category: 'Python',
    question: 'Sintaks yang benar untuk mencetak "Hello" di Python adalah?',
    options: [
      'echo("Hello")',
      'print("Hello")',
      'printf("Hello")',
      'console.log("Hello")',
    ],
    correctIndex: 1,
  ),
];
