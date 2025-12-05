// lib/features/learning/course_list_page.dart
import 'package:flutter/material.dart';
// lib/features/learning/course_list_page.dart
import 'dart:ui'; // Diperlukan untuk ImageFilter.blur
import 'package:flutter/material.dart';
import '../../data/sample_courses.dart';
import '../../models/course.dart';
import 'course_detail_page.dart';

class CourseListPage extends StatelessWidget {
  final String? filterCategory; // kalau mau filter (Python / R / SQL)

  const CourseListPage({super.key, this.filterCategory});

  @override Widget build(BuildContext context) {
    // --- PERUBAHAN 1: Definisikan Warna Tema ---
    const Color primaryColor = Color(0xFF283845);
    const Color secondaryColor = Color(0xFF202C39);
    const Color accentColor = Color(
        0xFFF2D593); // Filter kursus berdasarkan kategori
    final List<Course> courses = filterCategory == null
        ? sampleCourses
        : sampleCourses
        .where((c) => c.category.toLowerCase() == filterCategory!.toLowerCase())
        .toList();

// Judul AppBar yang dinamis
    final String appBarTitle = filterCategory ?? 'Semua Kursus';

    return Scaffold(
      // --- PERUBAHAN 2: Latar Belakang Transparan & AppBar ---
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true, // Biarkan body berada di belakang AppBar
      appBar: AppBar(
        title: Text(appBarTitle),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: accentColor, // Warna untuk title dan back arrow
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
        // --- PERUBAHAN 4: Gunakan SafeArea untuk konten list ---
        child: SafeArea(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              final course = courses[index];
              return _CourseCard(course: course);
            },
          ),
        ),
      ),
    );
  }}
class _CourseCard extends StatelessWidget {
  final Course course;

  const _CourseCard({required this.course});

  @override Widget build(BuildContext context) { const Color accentColor = Color(0xFFF2D593);// --- PERUBAHAN 5: Desain Ulang Kartu dengan Gaya Glassmorphism ---
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
              MaterialPageRoute(builder: (_) => CourseDetailPage(course: course)),
            );
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: accentColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                // Leading Icon (CircleAvatar yang di-style ulang)
                CircleAvatar(
                  backgroundColor: accentColor.withOpacity(0.2),
                  child: Text(
                    course.category.substring(0, 1),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Title dan Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        course.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${course.category} · ${course.level}',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                // Trailing Icon
                const Icon(Icons.chevron_right, color: accentColor),
              ],
            ),
          ),
        ),
      ),
    ),
  );} }
