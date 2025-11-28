// lib/features/learning/course_detail_page.dart
import 'package:flutter/material.dart';

import '../../models/course.dart';
import '../docs/docs_webview_page.dart';
import '../quiz/quiz_page.dart';
import '../../data/sample_quizzes.dart';

class CourseDetailPage extends StatelessWidget {
  final Course course;

  const CourseDetailPage({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(course.title),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            course.category,
            style: Theme.of(context).textTheme.labelLarge,
          ),
          const SizedBox(height: 4),
          Text(
            course.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(course.description),
          const SizedBox(height: 16),
          Text(
            'Modul dalam kursus',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          ...course.lessons.map(
                (lesson) => Card(
              child: ListTile(
                title: Text(lesson.title),
                subtitle: const Text('Tap untuk membaca materi'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => _LessonDetailPage(
                        courseTitle: course.title,
                        lesson: lesson,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (course.category == 'Python')
            ElevatedButton.icon(
              onPressed: () {
                // contoh: mulai quiz python basic
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
              label: const Text('Mulai Quiz Python Dasar'),
            ),
        ],
      ),
    );
  }
}

class _LessonDetailPage extends StatelessWidget {
  final String courseTitle;
  final Lesson lesson;

  const _LessonDetailPage({
    required this.courseTitle,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    final hasDocs = lesson.docsUrl != null && lesson.docsUrl!.isNotEmpty;

    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              courseTitle,
              style: Theme.of(context).textTheme.labelLarge,
            ),
            const SizedBox(height: 4),
            Text(
              lesson.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              lesson.content,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 16),
            if (hasDocs)
              OutlinedButton.icon(
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
                label: const Text('Buka dokumentasi (W3Schools / docs)'),
              ),
          ],
        ),
      ),
    );
  }
}
