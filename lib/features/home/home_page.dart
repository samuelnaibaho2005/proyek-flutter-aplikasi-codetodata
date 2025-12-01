// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import '../profile/profile_page.dart';
import '../learning/course_list_page.dart';
import '../video/video_list_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    final pages = <Widget>[
      _HomeDashboard(name: auth.name, level: auth.level),
      const CourseListPage(),              // Tab Materi
      const _QuizPlaceholderPage(),        // Tab Quiz (sementara)
      const VideoListPage(),               // Tab Video
      const ProfilePage(),                 // Tab Profil
    ];

    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.menu_book_outlined), label: 'Materi'),
          NavigationDestination(icon: Icon(Icons.quiz_outlined), label: 'Quiz'),
          NavigationDestination(icon: Icon(Icons.ondemand_video_outlined), label: 'Video'),
          NavigationDestination(icon: Icon(Icons.person_outline), label: 'Profil'),
        ],
      ),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  final String? name;
  final String? level;

  const _HomeDashboard({this.name, this.level});

  @override
  Widget build(BuildContext context) {
    final greetingName = name ?? 'Learner';

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text(
              'Halo, $greetingName 👋',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              level != null ? 'Level: $level' : 'Ayo pilih level belajar kamu',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            Text(
              'Mulai belajar',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: const [
                _CategoryCard(title: 'Python', icon: Icons.code),
                _CategoryCard(title: 'R', icon: Icons.bar_chart),
                _CategoryCard(title: 'SQL', icon: Icons.table_chart_outlined),
                _CategoryCard(
                  title: 'Artificial Intelligent',
                  icon: Icons.ac_unit_sharp,
                ),
              ],
            ),
            const SizedBox(height: 24),
            Text(
              'Progress',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: const [
                    Expanded(
                      child: Text(
                        'Fitur progress detail akan ditambahkan nanti.',
                      ),
                    ),
                    SizedBox(width: 16),
                    CircularProgressIndicator(
                      value: 0.2, // dummy
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _CategoryCard({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      width: 150,
      height: 80,
      child: Card(
        color: colorScheme.primaryContainer,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Arahkan ke daftar kursus sesuai kategori
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CourseListPage(filterCategory: title),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Icon(icon),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _QuizPlaceholderPage extends StatelessWidget {
  const _QuizPlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text(
          'Pilih kursus dulu, lalu mulai quiz dari halaman kursus.',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
