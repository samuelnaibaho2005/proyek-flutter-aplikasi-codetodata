// lib/models/course.dart
class Lesson {
  final String id;
  final String title;
  final String content;
  final String? docsUrl; // link ke W3Schools / dokumentasi lain

  Lesson({
    required this.id,
    required this.title,
    required this.content,
    this.docsUrl,
  });
}

class Course {
  final String id;
  final String title;
  final String category; // Python / R / SQL / AI
  final String level; // Pemula / Menengah
  final String description;
  final List<Lesson> lessons;

  Course({
    required this.id,
    required this.title,
    required this.category,
    required this.level,
    required this.description,
    required this.lessons,
  });
}
