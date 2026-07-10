# Aplikasi Country Explorer 🌍

Aplikasi Flutter modern dan minimalis untuk menjelajahi direktori negara di seluruh dunia, dilengkapi dengan portal autentikasi yang aman dan antarmuka pengguna (UI) yang dinamis.

## 🚀 Fitur Utama

- **Portal Autentikasi:** Layar login yang rapi dan aman untuk membatasi akses pengguna.
- **Direktori Global:** Mengambil dan menampilkan daftar negara, lengkap dengan nama ibukota dan benderanya.
- **Pencarian Real-time:** Memfilter data negara secara instan berdasarkan nama atau ibukota.
- **Pewarnaan Dinamis (Color Hashing):** UI secara otomatis memproses huruf pada nama negara untuk menghasilkan palet warna garis yang unik namun tetap konsisten untuk setiap kartu.
- **UI Technical Minimalist:** Didesain menggunakan palet warna krem hangat (_warm cream_) dan ungu pekat (_deep plum_), berfokus pada penyajian data yang terstruktur.

## 🛠️ Tech Stack & Arsitektur

- **Framework:** Flutter
- **State Management:** GetX
- **Network / HTTP Client:** Dio
- **Arsitektur:** MVC (Model-View-Controller)

## 📁 Struktur Direktori

Proyek ini mengadopsi pendekatan arsitektur yang bersih (_clean architecture_) untuk menjaga skalabilitas kode:

```text
lib/
├── controllers/    # Logika bisnis dan state management (AuthController, HomeController)
├── models/         # Struktur data dan logika parsing JSON (CountryModel)
├── views/          # Tampilan layar UI (HomeView, LoginView)
└── database/       # Direktori yang disiapkan untuk integrasi penyimpanan lokal (misal: Isar/Hive)
```
