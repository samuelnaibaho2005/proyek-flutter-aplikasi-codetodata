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
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          backgroundColor: primaryColor,
          indicatorColor: accentColor.withOpacity(0.2),
          labelTextStyle: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.selected)) {
              return const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: accentColor,
              );
            }
            return TextStyle(
              fontSize: 12,
              color: Colors.white.withOpacity(0.7),
            );
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
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              selectedIcon: Icon(Icons.home),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.menu_book_outlined),
              selectedIcon: Icon(Icons.menu_book),
              label: 'Materi',
            ),
            NavigationDestination(
              icon: Icon(Icons.quiz_outlined),
              selectedIcon: Icon(Icons.quiz),
              label: 'Quiz',
            ),
            NavigationDestination(
              icon: Icon(Icons.ondemand_video_outlined),
              selectedIcon: Icon(Icons.ondemand_video),
              label: 'Video',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Profil',
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// DASHBOARD HOME
// -----------------------------------------------------------------------------
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
          // Latar Belakang Gradien (lapisan bawah)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, secondaryColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),

          // Konten utama
          Column(
            children: [
              // -----------------------------------------------------------------
              // HEADER MELENGKUNG + SEARCH BAR
              // -----------------------------------------------------------------
              SizedBox(
                height: 230,
                child: Stack(
                  children: [
                    // Bentuk melengkung di latar belakang header
                    ClipPath(
                      clipper: _HeaderClipper(),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFF00C8A0), // hijau terang
                              Color(0xFF26A69A), // teal
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                    // Konten di dalam header
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: SafeArea(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              'Halo, $greetingName 👋',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall
                                  ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              level != null
                                  ? '$level'
                                  : 'Ayo pilih level belajar kamu',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                            const SizedBox(height: 16),
                            // SEARCH BAR
                            _HomeSearchBar(),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // -----------------------------------------------------------------
              // KONTEN SCROLLABLE
              // -----------------------------------------------------------------
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    const SizedBox(height: 8),

                    // BANNER PROMOSI
                    const _PromoBanner(),
                    const SizedBox(height: 24),

                    // CARD LANJUTKAN BELAJAR
                    const _ContinueLearningCard(),
                    const SizedBox(height: 32),

                    // MULAI BELAJAR (KATEGORI)
                    Text(
                      'Mulai belajar',
                      style:
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 100,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          _CategoryCard(title: 'Python', icon: Icons.code),
                          SizedBox(width: 12),
                          _CategoryCard(
                              title: 'R', icon: Icons.bar_chart_outlined),
                          SizedBox(width: 12),
                          _CategoryCard(
                              title: 'SQL',
                              icon: Icons.table_chart_outlined),
                          SizedBox(width: 12),
                          _CategoryCard(
                              title: 'Artificial Intelligent',
                              icon: Icons.auto_awesome),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // PROGRESS BELAJAR
                    Text(
                      'Progress Belajar',
                      style:
                      Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: accentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: accentColor.withOpacity(0.3),
                        ),
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
                            valueColor: const AlwaysStoppedAnimation<Color>(
                                ijoColor),
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

// -----------------------------------------------------------------------------
// CUSTOM CLIPPER HEADER
// -----------------------------------------------------------------------------
class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height * 0.75,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// -----------------------------------------------------------------------------
// SEARCH BAR
// -----------------------------------------------------------------------------
class _HomeSearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: Colors.white.withOpacity(1),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              decoration: InputDecoration(
                hintText: 'Cari kursus atau materi...',
                hintStyle: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                ),
                border: InputBorder.none,
              ),
              // NOTE: untuk sekarang belum ada fungsi filter,
              // nanti bisa dihubungkan ke halaman pencarian.
              onSubmitted: (value) {
                if (value.trim().isEmpty) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Pencarian "$value" akan ditambahkan nanti.',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BANNER PROMO
// -----------------------------------------------------------------------------
class _PromoBanner extends StatelessWidget {
  const _PromoBanner();

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFF2D593);
    const Color ijoColor = Color(0xFF00C8A0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [ijoColor, Color(0xFF26A69A)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department_outlined,
            color: Colors.white,
            size: 32,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Baru! Artificial Intelligent untuk Pemula',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Belajar dasar AI from scratch',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: accentColor,
              foregroundColor: Colors.black87,
              padding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: () {
              // Untuk sekarang arahkan ke daftar kursus umum.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CourseListPage(),
                ),
              );
            },
            child: const Text(
              'Mulai',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CONTINUE LEARNING CARD
// -----------------------------------------------------------------------------
class _ContinueLearningCard extends StatelessWidget {
  const _ContinueLearningCard();

  @override
  Widget build(BuildContext context) {
    const Color accentColor = Color(0xFFF2D593);

    // Saat ini masih dummy. Nanti bisa dihubungkan dengan progress asli
    // (misal disimpan di SharedPreferences).
    const String courseTitle = 'Python Dasar untuk Data';
    const String lessonTitle = 'Modul 2 • Tipe Data';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withOpacity(0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: accentColor.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              color: accentColor,
            ),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Lanjutkan belajar',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  courseTitle,
                  style: TextStyle(color: Colors.white70, fontSize: 12),
                ),
                Text(
                  lessonTitle,
                  style: TextStyle(color: Colors.white54, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          TextButton(
            onPressed: () {
              // Untuk saat ini, arahkan ke daftar kursus.
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const CourseListPage(),
                ),
              );
            },
            child: const Text(
              'Lanjutkan',
              style: TextStyle(color: accentColor),
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// KARTU KATEGORI (GLASSMORPHISM)
// -----------------------------------------------------------------------------
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
                color: Colors.white.withOpacity(0.08),
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

// -----------------------------------------------------------------------------
// QUIZ PLACEHOLDER PAGE
// -----------------------------------------------------------------------------
class _QuizPlaceholderPage extends StatelessWidget {
  const _QuizPlaceholderPage();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF283845), Color(0xFF202C39)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: const Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            'Pilih kursus dulu, lalu mulai quiz dari halaman kursus.',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white70, fontSize: 16),
          ),
        ),
      ),
    );
  }
}
