// lib/features/home/home_page.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:ui'; // Diperlukan untuk ImageFilter.blur

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

  // --- DEFINISI WARNA TEMA ---
  static const Color primaryColor = Color(0xFF283845);
  static const Color secondaryColor = Color(0xFF202C39);
  static const Color accentColor = Color(0xFFF2D593);

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthService>();

    final pages = <Widget>[
      _HomeDashboard(name: auth.name, level: auth.level),
      const CourseListPage(),
      const _QuizPlaceholderPage(),
      const VideoListPage(),
      const ProfilePage(),
    ];

    return Scaffold(
      body: pages[_currentIndex],
      // --- PERUBAHAN 1: Styling NavigationBar ---
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: primaryColor,
          indicatorColor: accentColor.withOpacity(0.2),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: accentColor);
            }
            return TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.7));
          }),
          iconTheme: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const IconThemeData(color: accentColor);
            }
            return IconThemeData(color: Colors.white.withOpacity(0.7));
          }),
        ),
        child: NavigationBar(
          selectedIndex: _currentIndex,
          onDestinationSelected: (index) {
            setState(() => _currentIndex = index);
          },
          destinations: const [
            NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.menu_book_outlined), selectedIcon: Icon(Icons.menu_book), label: 'Materi'),
            NavigationDestination(icon: Icon(Icons.quiz_outlined), selectedIcon: Icon(Icons.quiz), label: 'Quiz'),
            NavigationDestination(icon: Icon(Icons.ondemand_video_outlined), selectedIcon: Icon(Icons.ondemand_video), label: 'Video'),
            NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
          ],
        ),
      ),
    );
  }
}

class _HomeDashboard extends StatelessWidget {
  final String? name;
  final String? level;

  const _HomeDashboard({this.name, this.level});

  // --- DEFINISI WARNA TEMA (digunakan di dalam widget ini) ---
  static const Color primaryColor = Color(0xFF283845);
  static const Color secondaryColor = Color(0xFF202C39);
  static const Color accentColor = Color(0xFFF2D593);
  static const Color ijoColor = Color(0xFF00C8A0);

  @override
  Widget build(BuildContext context) {
    final greetingName = name ?? 'Learner';

    return Scaffold(
      body: Stack(
        children: [
          // --- PERUBAHAN 2: Latar Belakang Gradien (Lapisan Bawah) ---
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // --- PERUBAHAN 3: Konten Utama (Lapisan Atas) ---
          Column(
            children: [
              // --- Header Melengkung ---
              SizedBox(
                height: 200,
                child: Stack(
                  children: [
                    // Bentuk melengkung di latar belakang header
                    ClipPath(
                      clipper: _HeaderClipper(),
                      child: Container(
                        color: Color(0xFF26A69A),
                      ),
                    ),
                    // Konten di dalam header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Halo, $greetingName 👋',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              level != null ? '$level' : 'Ayo pilih level belajar kamu',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Colors.white
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // --- Konten yang Bisa di-scroll ---
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    // Image.asset('assets/images/logo.png', height: 100),
                    Text(
                      'Mulai belajar',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // --- PERUBAHAN 4: Daftar Kategori Horizontal ---
                    SizedBox(
                      height: 100, // Tinggi area scroll horizontal
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          _CategoryCard(title: 'Python', icon: Icons.code),
                          SizedBox(width: 12),
                          _CategoryCard(title: 'R', icon: Icons.bar_chart),
                          SizedBox(width: 12),
                          _CategoryCard(title: 'SQL', icon: Icons.table_chart_outlined),
                          SizedBox(width: 12),
                          _CategoryCard(title: 'Artificial Intelligent', icon: Icons.ac_unit_sharp),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    Text(
                      'Progress Belajar',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    // --- PERUBAHAN 5: Kartu Progress dengan Gaya Baru ---
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: accentColor.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Expanded(
                            child: Text(
                              'Fitur progress detail akan ditambahkan nanti.',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                          const SizedBox(width: 16),
                          CircularProgressIndicator(
                            value: 0.4, // dummy
                            valueColor: const AlwaysStoppedAnimation<Color>(ijoColor),
                            backgroundColor: accentColor.withOpacity(0.2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// --- PERUBAHAN 6: Custom Clipper untuk Bentuk Melengkung ---
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.8);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.8,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}


class _CategoryCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const _CategoryCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFF2D593);

    return SizedBox(
      width: 150,
      height: 100,
      // --- PERUBAHAN 7: Kartu Kategori dengan Gaya Baru (Glassmorphism) ---
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => CourseListPage(filterCategory: title),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withOpacity(0.3)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon, color: accentColor, size: 28),
                  const Spacer(),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
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
    // Sesuaikan dengan tema
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF283845), Color(0xFF202C39)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Text(
          'Pilih kursus dulu, lalu mulai quiz dari halaman kursus.',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
    );
  }
}