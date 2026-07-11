# Tenangin App 🌿

**Tenangin** adalah sebuah aplikasi *mobile* yang berfokus pada kesehatan mental dan kesejahteraan emosional penggunanya. Aplikasi ini didesain sebagai ruang aman (safe space) bagi pengguna untuk mendapatkan dukungan emosional, membaca afirmasi positif harian, berbagi cerita secara anonim atau publik di forum komunitas, serta menonton video edukasi dan relaksasi.

Proyek ini dikembangkan sebagai bentuk pemenuhan tugas **Ujian Akhir Semester (UAS) Mata Kuliah Mobile Computing**.

---

## 🔗 Tautan Penting
- **Desain UI/UX (Figma):** [Tenangin App Design](https://www.figma.com/design/CQIr4hUXvJDOurfzkp16KW/Tenangin-App?node-id=1-16916&t=HwNnRGFx85OZlpUd-1)
- **Repository Backend:** [Tenangin Backend API](https://github.com/syahrul-awaludin/Tenangin-Backend)

---

## 🚀 User Flow (Alur Pengguna)
1. **Onboarding / Auth**: Saat pertama kali membuka aplikasi, sistem akan mengecek *Local Storage*. Jika token sesi belum ada, pengguna diarahkan ke layar **Login** atau **Register**.
2. **Beranda (Home)**: Setelah berhasil login, pengguna akan masuk ke halaman Home yang menampilkan sapaan personal dan kartu afirmasi harian yang menenangkan.
3. **Eksplorasi (Learn)**: Pengguna dapat berpindah ke tab "Learn" untuk mencari dan menonton berbagai video relaksasi / edukasi mental.
4. **Interaksi (Community)**: Pengguna dapat masuk ke tab "Community" untuk membaca pengalaman pengguna lain (*fetch* dari API), memberikan *Like*, menulis komentar, atau membuat postingan baru.
5. **Notifikasi**: Sesekali aplikasi dapat memunculkan notifikasi lokal untuk mengingatkan pengguna beristirahat atau meditasi.

---

## ✨ Fitur Utama (Minimum Viable Product UAS)

### 1. Sistem Autentikasi (API Terintegrasi)
- **Login & Register**: Pengguna membuat akun menggunakan REST API. Keamanan dijamin melalui proses *hashing* password dan penggunaan token **JWT (JSON Web Token)** di backend.
- **Auto-Login**: Menggunakan *Shared Preferences*, token disimpan di perangkat pengguna, membebaskan pengguna dari keharusan *login* berulang setiap kali membuka aplikasi.

### 2. Community Forum (REST API)
- Mengambil (*fetch*) daftar postingan terbaru (List Data) secara *real-time* dari Backend REST API.
- Fitur interaktif: *Create Post*, *Like Post*, dan *Comment* yang tersinkronisasi langsung ke *database* di server VPS.

### 3. Learn & Meditate (Video Player)
- Kumpulan konten multimedia (*video playback*) untuk mendukung meditasi dan relaksasi visual pengguna.

### 4. Local Notification (Mobile Feature)
- Mengimplementasikan pemberitahuan (*push alert*) berbasis sistem internal perangkat (*local*) menggunakan `flutter_local_notifications` tanpa membutuhkan layanan *cloud messaging* eksternal.

---

## 🛠 Arsitektur & Struktur Direktori

Aplikasi ini menerapkan pemisahan tanggung jawab (*Separation of Concerns*) dengan menggunakan pola arsitektur **Model-View-Controller (MVC)** pada sisi *Frontend* (Flutter).

```text
lib/
 ├── controllers/        # Logika bisnis dan State Management (Provider)
 │   ├── auth_controller.dart
 │   └── community_controller.dart
 ├── models/             # Struktur data berorientasi objek (OOP) untuk mapping JSON API
 │   └── post_model.dart
 ├── services/           # Interaksi ke luar sistem (HTTP REST API & Notifikasi)
 │   ├── api_client.dart
 │   └── notification_service.dart
 ├── theme/              # Design System (Warna, Tipografi, Style Global)
 │   ├── app_colors.dart
 │   └── app_typography.dart
 ├── views/              # Halaman UI/UX (Hanya fokus pada presentasi visual)
 │   ├── auth/
 │   ├── community/
 │   └── home/
 └── widgets/            # Komponen UI kecil yang dapat digunakan ulang (Reusable)
```

---

## 💻 Tech Stack & Dependencies

**Sistem Keseluruhan:**
- **Frontend (Mobile)**: Flutter (Dart)
- **Backend (API)**: Node.js dengan framework Express.js
- **Deployment**: Virtual Private Server (VPS) menggunakan OS Ubuntu & PM2 sebagai *process manager*.

**Library & Package Utama (Flutter):**
- `provider`: Digunakan untuk *State Management*. Memisahkan logika pengelolaan *state* dari *widget tree*, serta me-*render* ulang UI secara spesifik hanya pada bagian yang berubah secara efisien.
- `http`: Mengelola proses pengambilan data (*HTTP Client*) asinkronus dengan Backend REST API.
- `shared_preferences`: Berperan sebagai **Local Storage** untuk menyimpan dan membaca data sederhana (seperti sesi `auth_token`).
- `flutter_local_notifications`: Paket esensial untuk memunculkan notifikasi perangkat keras lokal (*Native Mobile Feature*).
- `image_picker`: Memanfaatkan sensor perangkat (Kamera/Galeri lokal) untuk mengunggah gambar.
- `video_player` / `youtube_player_iframe`: Pemutar media visual pendukung fitur *Learn*.

---

## ⚙️ Cara Menjalankan Aplikasi (Local Setup)

1. Pastikan komputer Anda telah terinstal **Flutter SDK** versi terbaru.
2. *Clone* repository ini:
   ```bash
   git clone https://github.com/syahrul-awaludin/UTS-Mobile-Computing-Tenangin-App.git
   ```
3. Masuk ke dalam direktori aplikasi:
   ```bash
   cd UTS-Mobile-Computing-Tenangin-App
   ```
4. Unduh semua paket (dependencies):
   ```bash
   flutter pub get
   ```
5. Jalankan aplikasi pada *Emulator* atau *Device Fisik*:
   ```bash
   flutter run
   ```

---

## 📱 Screenshot Aplikasi

*(Screenshot aplikasi akan ditambahkan di sini)*
<!-- Tambahkan URL gambar di bawah teks berikut -->

- **Login Screen:** 

- **Register Screen:** 

- **Home Screen:** 

- **Community Screen:** 

---
*Dibuat dan dirancang oleh Syahrul Awaludin untuk UAS Mobile Computing 2026*
