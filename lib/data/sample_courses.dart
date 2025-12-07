// lib/data/sample_courses.dart
import '../models/course.dart';

final sampleCourses = <Course>[
  // ---------------------------------------------------------------------------
  // PYTHON DASAR
  // ---------------------------------------------------------------------------
  Course(
    id: 'python_basic',
    title: 'Python Dasar untuk Data',
    category: 'Python',
    level: 'Pemula',
    description:
    'Belajar dasar Python yang paling sering dipakai untuk analisis data '
        'dan eksplorasi data science.',
    lessons: [
      Lesson(
        id: 'py1',
        title: 'Pengenalan Python',
        content: '''
Python adalah bahasa pemrograman yang populer untuk:
- analisis data,
- machine learning,
- automasi,
- pengembangan backend.

Kenapa Python banyak dipakai di dunia data?
- Sintaks sederhana dan mudah dibaca.
- Ekosistem library sangat kaya (NumPy, Pandas, Matplotlib, dll).
- Komunitas besar dan dokumentasi melimpah.

Hal penting:
- Python menggunakan indentasi (spasi/tab) untuk menandai blok kode.
- Case sensitive: variabel "data" dan "Data" dianggap berbeda.
''',
        docsUrl: 'https://www.w3schools.com/python/',
      ),
      Lesson(
        id: 'py2',
        title: 'Menjalankan Python & Variabel',
        content: '''
Ada beberapa cara menjalankan Python:
1. Melalui interpreter (command line / terminal).
2. Melalui file .py.
3. Menggunakan notebook (Jupyter/Google Colab).

Contoh variabel:
name = "Samuel"
age = 21
is_student = True

Aturan penamaan variabel:
- tidak boleh diawali angka,
- gunakan huruf, angka, dan underscore (_),
- sebaiknya gunakan nama yang jelas: total_price, customer_name.
''',
        docsUrl: 'https://www.w3schools.com/python/python_getstarted.asp',
      ),
      Lesson(
        id: 'py3',
        title: 'Tipe Data Dasar',
        content: '''
Beberapa tipe data penting di Python:
- int    : bilangan bulat -> 10, -5, 0
- float  : bilangan desimal -> 3.14, -0.5
- str    : teks -> "Halo", 'Python'
- bool   : True atau False

Struktur data:
- list   : [1, 2, 3]
- tuple  : (1, 2, 3)
- dict   : {"nama": "Samuel", "umur": 21}

Contoh:
price = 99999.5        # float
tags = ["python", "data", "ai"]  # list
user = {"name": "Samuel", "level": "Pemula"}  # dict
''',
        docsUrl: 'https://www.w3schools.com/python/python_datatypes.asp',
      ),
      Lesson(
        id: 'py4',
        title: 'Struktur Kontrol: if, for, while',
        content: '''
Struktur kontrol mengatur alur logika program.

1. if
Digunakan untuk percabangan:
if score >= 80:
    print("Lulus")

2. for
Digunakan untuk perulangan dengan jumlah pasti:
for item in [1, 2, 3]:
    print(item)

3. while
Dipakai saat jumlah perulangan belum pasti:
count = 0
while count < 3:
    print(count)
    count += 1
''',
        docsUrl: 'https://www.w3schools.com/python/python_conditions.asp',
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // R DASAR
  // ---------------------------------------------------------------------------
  Course(
    id: 'r_basic',
    title: 'R Dasar untuk Analisis Data',
    category: 'R',
    level: 'Pemula',
    description:
    'Belajar dasar bahasa R yang sering digunakan dalam statistik dan '
        'analisis data.',
    lessons: [
      Lesson(
        id: 'r1',
        title: 'Pengenalan R & RStudio',
        content: '''
R adalah bahasa pemrograman yang kuat untuk:
- statistik,
- visualisasi data,
- analisis data eksploratif.

RStudio adalah IDE (editor) yang memudahkan:
- menulis script,
- menjalankan kode,
- melihat grafik dan data frame.

Contoh kode sederhana:
x <- 1:5
y <- c(2, 4, 6, 8, 10)
plot(x, y)
''',
        docsUrl: 'https://www.w3schools.com/r/',
      ),
      Lesson(
        id: 'r2',
        title: 'Variabel & Tipe Data di R',
        content: '''
Penugasan variabel di R biasanya menggunakan operator <- :

name <- "Samuel"
age <- 21
is_student <- TRUE

Tipe data utama:
- numeric  : angka
- character: teks
- logical  : TRUE/FALSE
- vector   : kumpulan nilai dengan tipe yang sama

Contoh vector:
scores <- c(80, 85, 90)
''',
        docsUrl: 'https://www.w3schools.com/r/r_variables.asp',
      ),
      Lesson(
        id: 'r3',
        title: 'Data Frame dan Operasi Sederhana',
        content: '''
Data frame adalah struktur data paling penting di R
untuk menyimpan data tabular (baris & kolom).

Contoh:
nama <- c("Andi", "Budi", "Citra")
umur <- c(21, 22, 20)
nilai <- c(80, 90, 85)

df <- data.frame(nama, umur, nilai)

Operasi dasar:
- head(df)      : lihat beberapa baris awal
- df(simbolDolar)nama       : ambil kolom nama
- df[df(simbolDolar)nilai > 85, ] : filter baris dengan nilai > 85
''',
        docsUrl: 'https://www.w3schools.com/r/r_data_frames.asp',
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // SQL DASAR (UMUM)
  // ---------------------------------------------------------------------------
  Course(
    id: 'sql_basic',
    title: 'SQL Dasar untuk Pemula',
    category: 'SQL',
    level: 'Pemula',
    description:
    'Belajar query dasar SQL untuk mengambil, memfilter, dan mengolah '
        'data dari database relasional.',
    lessons: [
      Lesson(
        id: 'sql1',
        title: 'Pengenalan SQL & SELECT',
        content: '''
SQL (Structured Query Language) digunakan untuk
berinteraksi dengan database relasional seperti MySQL,
PostgreSQL, dan SQL Server.

Query paling dasar adalah SELECT:

SELECT * FROM customers;

Artinya: ambil semua kolom dari tabel customers.

Tips:
- nama tabel dan kolom biasanya tanpa spasi,
- tanda ; di akhir query menandakan akhir perintah.
''',
        docsUrl: 'https://www.w3schools.com/sql/sql_select.asp',
      ),
      Lesson(
        id: 'sql2',
        title: 'WHERE, AND, OR, ORDER BY',
        content: '''
Klausul WHERE digunakan untuk memfilter baris:

SELECT * FROM customers
WHERE city = 'Medan';

Menggabungkan kondisi:
SELECT * FROM customers
WHERE city = 'Medan' AND status = 'ACTIVE';

Mengurutkan data:
SELECT * FROM customers
ORDER BY created_at DESC;

ORDER BY ASC  : dari kecil ke besar / A-Z
ORDER BY DESC : dari besar ke kecil / Z-A
''',
        docsUrl: 'https://www.w3schools.com/sql/sql_where.asp',
      ),
      Lesson(
        id: 'sql3',
        title: 'Fungsi Agregasi & GROUP BY',
        content: '''
Fungsi agregasi:

- COUNT() : menghitung jumlah baris
- SUM()   : menjumlahkan nilai
- AVG()   : rata-rata
- MIN(), MAX()

Contoh:
SELECT city, COUNT(*) AS jumlah_customer
FROM customers
GROUP BY city;

Makna:
- hitung jumlah customer per kota,
- setiap baris hasil mewakili satu kota.
''',
        docsUrl: 'https://www.w3schools.com/sql/sql_groupby.asp',
      ),
      Lesson(
        id: 'sql4',
        title: 'JOIN Dasar antar Tabel',
        content: '''
JOIN digunakan untuk menggabungkan data dari beberapa tabel.

Contoh JOIN 2 tabel:

SELECT o.id, o.order_date, c.name
FROM orders o
JOIN customers c ON o.customer_id = c.id;

Penjelasan:
- orders dan customers digabung lewat customer_id,
- alias o dan c dipakai untuk menyingkat penulisan.

Jenis JOIN umum:
- INNER JOIN : hanya baris yang cocok di kedua tabel
- LEFT JOIN  : semua baris dari tabel kiri + yang cocok dari kanan
''',
        docsUrl: 'https://www.w3schools.com/sql/sql_join.asp',
      ),
    ],
  ),

  // ---------------------------------------------------------------------------
  // AI DASAR (TEORI)
  // ---------------------------------------------------------------------------
  Course(
    id: 'ai_basic',
    title: 'Pengantar Kecerdasan Buatan (AI)',
    category: 'Artificial Intelligent',
    level: 'Pemula',
    description:
    'Belajar konsep dasar AI: definisi, sejarah singkat, jenis-jenis AI, '
        'dan bagaimana AI dipakai dalam kehidupan sehari-hari.',
    lessons: [
      Lesson(
        id: 'ai1',
        title: 'Apa itu AI? Perbedaan AI, ML, dan Deep Learning',
        content: '''
Artificial Intelligence (AI) adalah cabang ilmu komputer
yang berusaha membuat mesin dapat melakukan tugas yang
biasanya membutuhkan kecerdasan manusia.

Perbedaan singkat:
- AI  : payung besar, semua teknik yang membuat mesin "pintar".
- ML  : bagian dari AI yang belajar dari data.
- DL  : bagian dari ML yang menggunakan neural network berlapis (deep).

Contoh penggunaan AI:
- rekomendasi film,
- filter spam email,
- chatbot,
- sistem navigasi.
''',
        docsUrl:
        'https://en.wikipedia.org/wiki/Artificial_intelligence',
      ),
      Lesson(
        id: 'ai2',
        title: 'Sejarah Singkat AI',
        content: '''
Beberapa momen penting dalam sejarah AI:

1950 - Alan Turing mengusulkan "Turing Test".
1956 - Konferensi Dartmouth, istilah "Artificial Intelligence" diperkenalkan.
1980-an - Expert system (sistem pakar) banyak digunakan.
2010 ke atas - Deep learning berkembang pesat
               seiring meningkatnya data dan daya komputasi.

AI berkembang dalam gelombang:
- periode optimis,
- periode "AI winter" (pendanaan turun),
- bangkit lagi dengan pendekatan baru.
''',
        docsUrl:
        'https://en.wikipedia.org/wiki/History_of_artificial_intelligence',
      ),
      Lesson(
        id: 'ai3',
        title: 'Jenis-Jenis AI (Taksonomi)',
        content: '''
Ada beberapa cara mengelompokkan AI.

1. Berdasarkan kemampuan:
- ANI (Narrow AI) : hanya untuk 1 tugas spesifik,
  contoh: rekomendasi lagu.
- AGI (General AI): mampu melakukan berbagai tugas
  seperti manusia (masih teori).
- ASI (Superintelligence): kecerdasan melebihi manusia
  (masih spekulatif).

2. Berdasarkan pendekatan:
- Symbolic AI / rule-based: banyak aturan IF-THEN.
- Statistical / Machine Learning: belajar pola dari data.
- Hybrid: menggabungkan keduanya.

Sebagian besar sistem modern menggunakan pendekatan
statistical / machine learning.
''',
        docsUrl:
        'https://en.wikipedia.org/wiki/Artificial_intelligence#Approaches',
      ),
      Lesson(
        id: 'ai4',
        title: 'Alur Dasar Proyek AI',
        content: '''
Meskipun jenis proyek AI berbeda-beda, alur umumnya mirip:

1. Definisikan masalah
   - contoh: "klasifikasikan email spam atau bukan spam".

2. Kumpulkan data
   - ambil data historis yang relevan.

3. Persiapan data
   - bersihkan data, tangani missing value,
   - bagi data menjadi train dan test.

4. Bangun model
   - pilih algoritma machine learning / deep learning,
   - latih model menggunakan data train.

5. Evaluasi
   - cek akurasi di data test,
   - lihat metrik lain (precision, recall, dll).

6. Deploy & monitoring
   - integrasi ke aplikasi,
   - pantau performa dan update jika perlu.

Pemahaman alur ini penting sebelum mulai ngoding model.
''',
        docsUrl:
        'https://developers.google.com/machine-learning/crash-course',
      ),
    ],
  ),
];
