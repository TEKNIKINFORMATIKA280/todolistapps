# 📚 To-Do Mahasiswa - Glassmorphism Edition

Aplikasi manajemen tugas (To-Do List) modern yang dirancang khusus untuk mahasiswa. Dibangun menggunakan **Flutter** dengan konsep desain **Glassmorphism** dan sistem penyimpanan lokal **SQLite**.

## ✨ Fitur Utama

Aplikasi ini mencakup 5 menu utama yang dapat diakses melalui Bottom Navigation Bar:

1.  **🏠 Home (Beranda)**
    *   Manajemen CRUD lengkap (Tambah, Lihat, Edit, Hapus).
    *   Fitur pencarian tugas secara real-time.
    *   Sistem pengurutan (Terbaru, Nama A-Z, Status Selesai).
    *   Fitur *Swipe to Delete* (Geser untuk hapus).
2.  **📅 Deadline**
    *   Daftar tugas yang diurutkan berdasarkan tanggal terdekat.
    *   Visualisasi sisa waktu pengerjaan.
3.  **✅ Selesai**
    *   Arsip tugas yang telah diselesaikan.
    *   Fitur untuk membatalkan status selesai.
4.  **📊 Statistik**
    *   Dashboard ringkasan tugas.
    *   Grafik progres penyelesaian (Circular Progress).
    *   Data total tugas, tugas selesai, dan tugas pending.
5.  **⚙️ Pengaturan**
    *   Informasi aplikasi dan profil sederhana.
    *   Opsi reset data aplikasi.

## 🎨 Keunggulan UI/UX

*   **Animated Rounded Search Bar**: Bar pencarian yang berubah bentuk secara dinamis (semakin bulat) dan berganti warna saat difokuskan.
*   **Premium Animated Navbar**: Menggunakan `SalomonBottomBar` dengan efek sliding, scaling icon, dan glassmorphism yang sangat halus.
*   **Smooth Page Transitions**: Perpindahan antar halaman menggunakan efek *Fade* yang sinkron dengan gerakan navbar.
*   **Glassmorphism Design**: Tampilan transparan yang elegan dengan efek blur.
*   **Smart Color Tagging**: Penandaan warna otomatis berdasarkan mata kuliah.
*   **Rich Animations**: Menggunakan Hero animations, Fade, Slide, dan Bounce untuk pengalaman pengguna yang halus.
*   **Responsive Layout**: Nyaman digunakan di berbagai ukuran layar smartphone.

## 🛠️ Tech Stack

Daftar package utama yang digunakan:
*   `sqflite` & `path`: Manajemen Database SQLite.
*   `glassmorphism`: Implementasi UI Glassmorphism.
*   `flutter_animate` & `animate_do`: Library animasi.
*   `cupertino_icons`: Set ikon pendukung.

## 📂 Struktur Proyek

```text
lib/
├── animations/     # Logika transisi dan animasi kustom
├── database/       # Konfigurasi SQLite (DatabaseHelper)
├── models/         # Model data (Task)
├── pages/          # Halaman utama aplikasi (Home, Stats, dll)
├── services/       # Logika bisnis (TaskService)
├── theme/          # Konfigurasi tema gelap & glass
└── widgets/        # Komponen UI reusable (TaskTile, GlassCard, dll)
```

## 🚀 Cara Menjalankan

1.  Pastikan Anda telah menginstal [Flutter SDK](https://docs.flutter.dev/get-started/install).
2.  Clone repository ini.
3.  Jalankan perintah berikut di terminal:
    ```bash
    flutter pub get
    flutter run
    ```

---
Dibuat dengan ❤️ untuk produktivitas Mahasiswa oleh **Rafael Paulus Sitompul**.

📧 **Hubungi tim Developer:** 
*   **Gmail:** [rafaelsitompoel@gmail.com](mailto:rafaelsitompoel@gmail.com)
*   **WhatsApp:** [+62 895-0978-9282](https://wa.me/6289509789282)
