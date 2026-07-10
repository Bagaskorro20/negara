import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../controllers/auth_controller.dart';
import '../controllers/home_controller.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);

  final HomeController homeController = Get.put(HomeController());
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Negara'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () => authController.logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          // Bonus: Search Bar
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              onChanged: (value) => homeController.searchCountry(value),
              decoration: InputDecoration(
                hintText: 'Cari negara atau ibukota...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
              ),
            ),
          ),

          // List Negara (Reaktif menggunakan Obx)
          Expanded(
            child: Obx(() {
              if (homeController.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (homeController.errorMessage.isNotEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(homeController.errorMessage.value),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () => homeController.fetchCountries(),
                        child: const Text('Coba Lagi'),
                      ),
                    ],
                  ),
                );
              }

              if (homeController.filteredList.isEmpty) {
                return const Center(child: Text('Negara tidak ditemukan.'));
              }

              // Bonus: Pull to Refresh
              return RefreshIndicator(
                onRefresh: () => homeController.fetchCountries(),
                child: ListView.separated(
                  itemCount: homeController.filteredList.length,
                  separatorBuilder: (context, index) =>
                      const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final country = homeController.filteredList[index];
                    return ListTile(
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      // Bonus Poin 3: Tampilkan Bendera
                      leading: ClipRadius(
                        borderRadius: BorderRadius.circular(4),
                        child: CachedNetworkImage(
                          imageUrl: country.flagUrl,
                          width: 60,
                          height: 40,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            width: 60,
                            height: 40,
                            color: Colors.grey[300],
                          ),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.flag),
                        ),
                      ),
                      title: Text(
                        country.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Text('Ibukota: ${country.capital}'),
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

// Helper kecil untuk me-round corner bendera
class ClipRadius extends StatelessWidget {
  final BorderRadius borderRadius;
  final Widget child;
  const ClipRadius({Key? key, required this.borderRadius, required this.child})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(borderRadius: borderRadius, child: child);
  }
}
