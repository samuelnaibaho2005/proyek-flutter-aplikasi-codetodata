// lib/features/learning/course_list_page.dart
import 'package:flutter/material.dart';

import '../../data/sample_courses.dart';
import '../../models/course.dart';
import 'course_detail_page.dart';

class CourseListPage extends StatelessWidget {
  final String? filterCategory; // kalau mau filter (Python / R / SQL)

  const CourseListPage({super.key, this.filterCategory});

  @override
  Widget build(BuildContext context) {
    final List<Course> courses = filterCategory == null
        ? sampleCourses
        : sampleCourses
        .where((c) => c.category.toLowerCase() ==
        filterCategory!.toLowerCase())
        .toList();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Kursus'),
        ),
        body: ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: courses.length,
          itemBuilder: (context, index) {
            final course = courses[index];
            return _CourseCard(course: course);
          },
        ),
      ),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;

  const _CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: CircleAvatar(
          backgroundColor: colorScheme.primaryContainer,
          child: Text(
            course.category.substring(0, 1),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(course.title),
        subtitle: Text('${course.category} · ${course.level}'),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CourseDetailPage(course: course),
            ),
          );
        },
      ),
    );
  }
}
