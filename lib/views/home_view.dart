import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final AuthController authController = Get.find<AuthController>();

  // --- VIBRANT PALETTE (Untuk Header) ---
  final Color primaryPurple = const Color(0xFF6366F1);
  final Color darkPurple = const Color(0xFF312E81);
  final Color bgLight = const Color(0xFFF8FAFC);

  // --- FUNGSI GENERATOR WARNA UNIK ---
  // Fungsi ini akan menghasilkan warna yang unik dan konsisten berdasarkan nama negara
  Color _getDynamicColor(String text) {
    // Daftar palet warna cerah (Material/Tailwind style)
    final List<Color> colors = [
      const Color(0xFFEF4444), // Merah (Red)
      const Color(0xFFF97316), // Oranye (Orange)
      const Color(0xFFEAB308), // Kuning Emas (Amber)
      const Color(0xFF10B981), // Hijau Zamrud (Emerald)
      const Color(0xFF06B6D4), // Biru Muda (Cyan)
      const Color(0xFF3B82F6), // Biru (Blue)
      const Color(0xFF8B5CF6), // Ungu (Violet)
      const Color(0xFFEC4899), // Pink (Rose)
    ];

    // Menghitung angka unik dari huruf-huruf nama negara
    int hash = 0;
    for (int i = 0; i < text.length; i++) {
      hash = text.codeUnitAt(i) + ((hash << 5) - hash);
    }

    // Memilih warna dari daftar berdasarkan angka unik tadi
    return colors[hash.abs() % colors.length];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      body: Column(
        children: [
          // ==========================================
          // 1. CUSTOM HEADER
          // ==========================================
          Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
              left: 24,
              right: 24,
              bottom: 30,
            ),
            decoration: BoxDecoration(
              color: darkPurple,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.logout_rounded, color: Colors.white),
                    onPressed: () => authController.logout(),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Cari Negara',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 24),

                // --- SEARCH BAR ---
                Container(
                  height: 56,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: homeController.searchCountry,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Ketik nama atau ibukota...',
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      prefixIcon: const Icon(
                        Icons.search_rounded,
                        color: Colors.grey,
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primaryPurple.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.tune_rounded,
                          color: primaryPurple,
                          size: 20,
                        ),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ==========================================
          // 2. KONTEN LIST
          // ==========================================
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return Center(
                  child: CircularProgressIndicator(color: primaryPurple),
                );
              }

              if (homeController.errorMessage.isNotEmpty) {
                return Center(child: Text(homeController.errorMessage.value));
              }

              return RefreshIndicator(
                color: primaryPurple,
                onRefresh: homeController.fetchCountries,
                child: ListView.builder(
                  padding: const EdgeInsets.all(24),
                  physics: const BouncingScrollPhysics(),
                  itemCount: homeController.filteredList.length,
                  itemBuilder: (context, index) {
                    final country = homeController.filteredList[index];

                    // Eksekusi fungsi penentu warna berdasarkan nama negara!
                    final Color cardColor = _getDynamicColor(country.name);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: cardColor.withOpacity(
                              0.08,
                            ), // Shadow-nya juga menyesuaikan warna!
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          // --- GARIS PINGGIR BERUBAH WARNA ---
                          Container(
                            width: 6,
                            height: 75,
                            decoration: BoxDecoration(
                              color: cardColor,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                            ),
                          ),

                          // --- BENDERA (Latar belakangnya juga mengikuti warna) ---
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: cardColor.withOpacity(
                                  0.1,
                                ), // Efek transparan 10%
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                country.flagUrl,
                                style: const TextStyle(fontSize: 28),
                              ),
                            ),
                          ),

                          // Teks Utama
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  country.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E293B),
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.pin_drop_rounded,
                                      size: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        country.capital,
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // Tombol Panah
                          Padding(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: Colors.grey.shade300,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
