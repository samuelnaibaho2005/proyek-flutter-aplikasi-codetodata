// lib/data/sample_courses.dart
import '../models/course.dart';

final sampleCourses = <Course>[
  Course(
    id: 'python_basic',
    title: 'Python Dasar untuk Data',
    category: 'Python',
    level: 'Pemula',
    description:
    'Belajar dasar Python yang paling sering dipakai untuk analisis data di e-commerce.',
    lessons: [
      Lesson(
        id: 'py1',
        title: 'Pengenalan Python',
        content: '''
Python adalah bahasa pemrograman yang sering digunakan untuk analisis data, machine learning, dan pengembangan backend.

Di Tokopedia, Python bisa dipakai untuk:
- membersihkan data transaksi,
- membangun model rekomendasi,
- membuat pipeline data.

Hal penting:
- Python fokus ke keterbacaan kode
- Sintaksnya sederhana (indentasi)
''',
        docsUrl: 'https://www.w3schools.com/python/',
      ),
      Lesson(
        id: 'py2',
        title: 'Tipe Data Dasar',
        content: '''
Beberapa tipe data penting:
- int: bilangan bulat
- float: bilangan desimal
- str: teks
- bool: True / False
- list, tuple, dict: struktur data yang sering dipakai

Contoh:
age = 21
price = 99999.5
name = "Tokopedia"
is_paid = True
''',
        docsUrl: 'https://www.w3schools.com/python/python_datatypes.asp',
      ),
    ],
  ),
  Course(
    id: 'sql_ecommerce',
    title: 'SQL untuk Analisis Transaksi',
    category: 'SQL',
    level: 'Pemula',
    description:
    'Belajar query dasar SQL untuk menganalisis transaksi e-commerce seperti Tokopedia.',
    lessons: [
      Lesson(
        id: 'sql1',
        title: 'Dasar SELECT & WHERE',
        content: '''
SQL digunakan untuk mengambil data dari database.

Contoh kasus:
- mencari total transaksi per pelanggan,
- mencari produk paling laku.

Contoh query:
SELECT * FROM orders
WHERE status = 'PAID';
''',
        docsUrl: 'https://www.w3schools.com/sql/',
      ),
    ],
  ),
];
