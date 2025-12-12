# CodetoData

**CodetoData** — Aplikasi mobile Flutter untuk belajar Python, R, SQL, dan dasar AI. Cocok untuk pemula yang ingin memahami dasar-dasar pemrograman & data/AI sebelum melangkah lebih jauh.

---

## 🎯 Tujuan & Fitur Utama

 1. 🧑‍💻 **Materi Pembelajaran**  
     - Belajar Python, R, SQL, dan AI Dasar (teori) dari nol, lewat modul & sub-modul bertahap.
     - Tiap materi ada teks & penjelasan singkat.
     - Link ke dokumentasi eksternal (misalnya W3Schools / Wikipedia) via WebView.

 2. 📺 **Video Pembelajaran**  
     - Integrasi YouTube → memungkinkan pengguna menonton video tutorial langsung dari aplikasi.

 3. ❓ **Quiz & Evaluasi**  
    - Quiz interaktif per topik (pilihan ganda).
    - Sound effect untuk jawaban benar/salah.
    - Skor hasil quiz disimpan — sebagai feedback belajar.

 5. 🔐 **Autentikasi Lokal**  
    - Registrasi & login tanpa backend — data disimpan secara lokal (SharedPreferences).
    - Edit profil & ubah password tersedia.
    - Level pengguna — misalnya: Umum / Mahasiswa / Profesional.

 6. 📚 **Kursus & Organisasi Materi**  
    - Materi disusun per “course” → berisi modul (lesson).
    - Kategori course: Python, R, SQL, Artificial Intelligent.
    - Pembagian level: semua saat ini untuk level “Pemula”.

 7. 🧩 **Profil & Statistik**  
    - Tampilan profil dengan nama, email, level.
    - Statistik belajar (kursus diikuti, modul selesai, skor quiz).
    - Rencana ekspansi: badge, achievements, progress tracking.

---

## 📷 Dokumentasi Aplikasi <br>
<img src="/assets/images/dokumentasi_login.png" width="200"> <img src="/assets/images/dokumentasi_home.png" width="200"> <img src="/assets/images/dokumentasi_modul.png" width="200"> <img src="/assets/images/dokumentasi_profile.png" width="200">

---
## 📁 Struktur Proyek (Folder & File)

```

lib/
main.dart                — Entry point aplikasi
routes.dart              — Daftar rute navigasi

services/
auth_service.dart      — Logika user / session / profil / auth

models/
course.dart            — Model Course & Lesson
video_item.dart        — Model VideoItem
quiz_question.dart     — Model QuizQuestion

data/
sample_courses.dart    — Data dummy: daftar course & materi
sample_videos.dart     — Data dummy: daftar video YouTube
sample_quizzes.dart    — Data dummy: soal-soal quiz

features/
splash/                — Splash screen
splash_page.dart

auth/                  — Registrasi, login, level selection
  login_page.dart
  register_page.dart
  level_selection_page.dart

home/                  — Halaman utama (dashboard)
  home_page.dart

learning/              — Materi / course list & detail
  course_list_page.dart
  course_detail_page.dart

video/                 — Daftar & pemutar video
  video_list_page.dart

quiz/                  — Halaman quiz
  quiz_page.dart

docs/                  — WebView untuk dokumentasi eksternal
  docs_webview_page.dart

profile/               — Profil user & menu pengaturan
  profile_page.dart
```
---

## 🖥️ Environment
 - Flutter SDK : 3.35
 - Dark SDK : 3.9
 - Android minSdkVersion: 21
 - Android targetSdkVersion: 34
 - Gradle: 8.2

---

## ⛓️ Depedencies
 - provider: ^6.1.2
 - cupertino_icons: ^1.0.8
  - provider: ^6.1.2
 - shared_preferences: ^2.2.3
 - webview_flutter: ^4.8.0
 - youtube_player_flutter: ^9.0.0
 - audioplayers: ^6.0.0
 
---

## 🛠️ Dependensi / Package yang Digunakan

- [`provider`](https://pub.dev/packages/provider) — State management, terutama untuk `AuthService`.  
- [`shared_preferences`](https://pub.dev/packages/shared_preferences) — Menyimpan data user (login, profil) secara lokal.  
- [`webview_flutter`](https://pub.dev/packages/webview_flutter) — Menampilkan dokumentasi eksternal dalam app.  
- [`youtube_player_flutter`](https://pub.dev/packages/youtube_player_flutter) — Embed & mainkan video YouTube dalam app.  
- [`audioplayers`](https://pub.dev/packages/audioplayers) — Memainkan efek suara (benar/salah) di quiz.  
- `flutter` & `cupertino_icons` — Paket dasar Flutter.

---

## 🚀 Cara Menjalankan (Development)

1. Pastikan Flutter SDK sudah ter-instal.  
2. Clone repository:

   ```bash
   git clone https://github.com/samuelnaibaho2005/proyek-flutter-aplikasi-codetodata.git
   cd proyek-flutter-aplikasi-codetodata

3. Install dependensi:

   ```bash
   flutter pub get
   ```

4. Jalankan app (debug mode):

   ```bash
   flutter run
   ```

5. Jika perlu: hot reload / hot restart saat modifikasi kode.

---

## 🧩 Cara Menambah Materi / Course

* Buka `lib/data/sample_courses.dart`.
* Tambahkan entry `Course(...)` dengan `id`, `title`, `category`, `level`, `description`, dan daftar `lessons`.
* Untuk setiap `Lesson`, definisikan `id`, `title`, `content`, dan optional `docsUrl`.
* Setelah disimpan, materi akan otomatis tampil di aplikasi di kategori sesuai (lihat bagian “Mulai belajar”).

---

## 🎯 Rencana Fitur Berikutnya

* Badge / Achievements & tracking progres belajar berfungsi sepenuhnya.
* Simpan progress materi/quiz lokal (modul/lesson terakhir).
* Halaman pencarian materi / course berfungsi sepenuhnya.
* Dark / Light mode toggle.
* Simulasi database (SQLite / local storage) untuk menyimpan progress, bukan sekadar data dummy.
* UI/UX polishing: animasi transisi, layout responsif, ikon & ilustrasi.

---

## 💡 Catatan & Disclaimer

* Saat ini aplikasi **tidak memakai backend server** — semua data disimpan lokal, sehingga cocok sebagai prototype atau materi pembelajaran.
* Data user dan password disimpan di `SharedPreferences` tanpa enkripsi — bukan untuk produksi nyata.
* Materi, quiz, video bersifat statis & dummy; untuk konten “asli”, perlu pengembangan lanjutan atau backend.
