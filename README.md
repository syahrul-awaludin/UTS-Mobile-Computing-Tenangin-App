# Tenangin App 🌿

**Tenangin** adalah sebuah aplikasi *mobile* inovatif yang berfokus pada kesehatan mental dan kesejahteraan penggunanya. Aplikasi ini didesain untuk menjadi ruang aman bagi siapa saja yang ingin mencurahkan perasaannya, berbagi cerita dengan komunitas, menemukan afirmasi positif harian, serta mengakses video relaksasi.

Aplikasi ini dikembangkan sebagai pemenuhan **Ujian Akhir Semester (UAS) Mata Kuliah Mobile Computing**.

---

## 🔗 Tautan Penting
- **Desain UI/UX (Figma):** [Tenangin App Design](https://www.figma.com/design/CQIr4hUXvJDOurfzkp16KW/Tenangin-App?node-id=1-16916&t=HwNnRGFx85OZlpUd-1)
- **Repository Backend:** [Tenangin Backend](https://github.com/syahrul-awaludin/Tenangin-Backend) *(Sesuaikan link github backend jika berbeda)*

---

## ✨ Fitur Utama
- **Sistem Autentikasi**: Login dan Register untuk pengguna menggunakan integrasi API.
- **Home & Afirmasi Harian**: Tampilan beranda yang tenang dengan kutipan (afirmasi) harian yang di-generate.
- **Community Forum**: Fitur di mana pengguna dapat membagikan cerita mereka, melihat cerita orang lain, serta melakukan interaksi (Like & Comment) yang tersinkronisasi langsung dengan REST API.
- **Video Relaksasi (Learn)**: Daftar video untuk membantu pengguna menenangkan diri.
- **Notifikasi Lokal**: Fitur pemberitahuan untuk *engagement* pengguna menggunakan *Local Notification*.

---

## 🛠 Arsitektur & Teknologi

Aplikasi ini dibangun menggunakan arsitektur modern yang memisahkan antara *Client* (Frontend) dan *Server* (Backend). 

### 💻 Tech Stack
- **Frontend (Mobile)**: Flutter (Dart)
- **Backend (API)**: Node.js dengan framework Express.js
- **State Management**: Provider
- **Local Storage**: Shared Preferences
- **Deployment**: Virtual Private Server (VPS) menggunakan PM2 sebagai *process manager*.

### 🌐 Backend Server & API
Backend aplikasi ini (Tenangin Backend) berjalan secara independen di VPS pribadi. Backend dibangun menggunakan Node.js dan menyediakan kumpulan RESTful API yang dikonsumsi oleh aplikasi Flutter. 
Fitur backend mencakup:
- **Autentikasi (JWT)**: Mengamankan *endpoint* agar hanya pengguna terdaftar yang bisa mengakses data.
- **MVC Pattern**: Backend juga diatur menggunakan arsitektur berlapis (Routes -> Controllers -> Services) sehingga kode sangat *clean* dan *scalable*.
- **Database Management**: Menyimpan data pengguna, *postingan* komunitas, komentar, dan metrik interaksi (like).

### 🏗 Software Architecture Frontend (MVC)
Aplikasi memisahkan tanggung jawab (Separation of Concerns) secara tegas menggunakan **Model-View-Controller (MVC)**:
- **`models/`**: Mendefinisikan struktur objek data dari API (misal: `post_model.dart`).
- **`views/`**: Hanya berisi UI/Desain (Widget Flutter) murni tanpa logika bisnis berat.
- **`controllers/`**: Menghubungkan View dengan Service dan mengelola *state* (misal: `community_controller.dart`).
- **`services/`**: Menangani interaksi ke luar aplikasi, seperti *HTTP Request* ke REST API.

### 2. State Management (Provider)
Pengelolaan *state* dilakukan menggunakan **Provider**. 
UI secara responsif memperbarui tampilannya sendiri (melalui widget `Consumer`) ketika Controller memanggil fungsi `notifyListeners()`, menghindari re-build aplikasi yang tidak perlu.

### 3. REST API Integration
Aplikasi telah terhubung dengan backend kustom (`Tenangin Backend`). 
Fitur utama yang memanfaatkan ini adalah **Community**, di mana aplikasi mengambil (*fetch*) daftar postingan dari *database* secara dinamis, beserta kemampuan interaksi pengguna secara *real-time*.

### 4. Local Storage
Aplikasi menggunakan paket **`shared_preferences`** untuk menyimpan sesi pengguna (Status Login & *Auth Token*). Jika pengguna menutup aplikasi lalu membukanya lagi, mereka tidak perlu *login* ulang karena token sudah tersimpan di penyimpanan lokal perangkat secara aman.

### 5. Mobile Feature
Aplikasi menggunakan **Local Notification** (via `flutter_local_notifications`) sebagai fitur spesifik perangkat mobile untuk dapat memunculkan peringatan (alert) secara native.

---

## 📱 Screenshot Aplikasi

*(Screenshot aplikasi akan ditambahkan di sini)*
<!-- Tambahkan tag gambar / markdown image di bawah ini nanti -->
- Login Screen: 
- Home Screen: 
- Community Screen: 

---
*Dibuat oleh Syahrul Awaludin untuk UAS Mobile Computing 2026*
