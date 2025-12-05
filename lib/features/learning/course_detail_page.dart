// lib/features/learning/course_detail_page.dart
import 'dart:ui'; // Diperlukan untuk ImageFilter.blur
import 'package:flutter/material.dart';

import '../../data/sample_quizzes.dart';
import '../../models/course.dart';
import '../docs/docs_webview_page.dart';
import '../quiz/quiz_page.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    // --- PERUBAHAN 1: Definisikan Warna Tema ---
    const Color primaryColor = Color(0xFF283845);
    const Color secondaryColor = Color(0xFF202C39);
    const Color accentColor = Color(0xFFF2D593);

    return Scaffold(
      // --- PERUBAHAN 2: Latar Belakang Transparan & AppBar ---
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(course.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: accentColor,
      ),
      body: Container(
        // --- PERUBAHAN 3: Latar Belakang Gradien ---
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24),
            children: [
              // --- PERUBAHAN 4: Style Teks Header ---
              Text(
                course.category,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                course.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                course.description,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'Modul dalam kursus',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // --- PERUBAHAN 5: Style Daftar Pelajaran ---
              ...course.lessons.asMap().entries.map(
                    (entry) => _LessonCard(
                  lesson: entry.value,
                  index: entry.key,
                  courseTitle: course.title,
                ),
              ),
              const SizedBox(height: 24),
              // --- PERUBAHAN 6: Style Tombol Quiz ---
              if (course.category == 'Python')
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: accentColor,
                    foregroundColor: primaryColor,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => QuizPage(
                          title: 'Quiz Python Dasar',
                          questions: sampleQuizPythonBasic,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.quiz_outlined),
                  label: const Text(
                    'Mulai Quiz Python Dasar',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget baru untuk kartu pelajaran yang di-style
class _LessonCard extends StatelessWidget {
  final Lesson lesson;
  final int index;
  final String courseTitle;

  const _LessonCard({
    required this.lesson,
    required this.index,
    required this.courseTitle,
  });

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFF2D593);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => _LessonDetailPage(
                    courseTitle: courseTitle,
                    lesson: lesson,
                  ),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withOpacity(0.3)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: accentColor.withOpacity(0.2),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: accentColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      lesson.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Icon(Icons.chevron_right, color: accentColor),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Halaman detail pelajaran yang juga di-style
class _LessonDetailPage extends StatelessWidget {
  final String courseTitle;
  final Lesson lesson;

  const _LessonDetailPage({
    required this.courseTitle,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF283845);
    const Color secondaryColor = Color(0xFF202C39);
    const Color accentColor = Color(0xFFF2D593);

    final hasDocs = lesson.docsUrl != null && lesson.docsUrl!.isNotEmpty;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(lesson.title),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: accentColor,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryColor, secondaryColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              Text(
                courseTitle,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                lesson.title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                lesson.content,
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.85),
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 32),
              if (hasDocs)
                OutlinedButton.icon(
                  style: OutlinedButton.styleFrom(
                    foregroundColor: accentColor,
                    side: BorderSide(color: accentColor, width: 2),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            DocsWebviewPage(initialUrl: lesson.docsUrl!),
                      ),
                    );
                  },
                  icon: const Icon(Icons.language),
                  label: const Text(
                    'Buka dokumentasi (W3Schools / docs)',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}