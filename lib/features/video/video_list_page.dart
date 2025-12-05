// lib/features/video/video_list_page.dart
import 'dart:ui'; // Diperlukan untuk ImageFilter.blur
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../data/sample_videos.dart';
import '../../models/video_item.dart';

class VideoListPage extends StatelessWidget {
  const VideoListPage({super.key});

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
        title: const Text('Video Pembelajaran'),
        centerTitle: true,
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
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: sampleVideos.length,
            itemBuilder: (context, index) {
              final video = sampleVideos[index];
              return _VideoCard(video: video);
            },
          ),
        ),
      ),
    );
  }
}

class _VideoCard extends StatelessWidget {
  final VideoItem video;

  const _VideoCard({required this.video});

  @override
  Widget build(BuildContext context) {
    // --- PERUBAHAN 4: URL Thumbnail Otomatis dari YouTube ---
    // 'mqdefault.jpg' memberikan kualitas medium yang bagus
    final thumbnailUrl =
        'https://img.youtube.com/vi/${video.youtubeId}/mqdefault.jpg';
    const Color accentColor = Color(0xFFF2D593);

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        // --- PERUBAHAN 5: Desain Ulang Kartu dengan Thumbnail ---
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => VideoPlayerPage(video: video),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: accentColor.withOpacity(0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // --- Thumbnail dengan Ikon Play di atasnya ---
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: Image.network(
                          thumbnailUrl,
                          fit: BoxFit.cover,
                          // Menampilkan loading indicator saat gambar dimuat
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(
                                color: accentColor,
                              ),
                            );
                          },
                          // Menampilkan ikon error jika gagal memuat
                          errorBuilder: (context, error, stackTrace) {
                            return const Center(
                              child: Icon(
                                Icons.error_outline,
                                color: Colors.redAccent,
                              ),
                            );
                          },
                        ),
                      ),
                      // Ikon Play
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  // --- Judul dan Kategori Video ---
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          video.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          video.category,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 12,
                          ),
                        ),
                      ],
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

// --- PERUBAHAN 6: Style Ulang Halaman Pemutar Video ---
class VideoPlayerPage extends StatefulWidget {
  final VideoItem video;

  const VideoPlayerPage({super.key, required this.video});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.video.youtubeId,
      flags: const YoutubePlayerFlags(autoPlay: true, mute: false),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF283845);
    const Color secondaryColor = Color(0xFF202C39);
    const Color accentColor = Color(0xFFF2D593);

    return YoutubePlayerBuilder(
      player: YoutubePlayer(controller: _controller),
      builder: (context, player) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            title: Text(widget.video.title),
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  player,
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      widget.video.title,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}