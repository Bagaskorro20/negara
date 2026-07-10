import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';

class AuthController extends GetxController {
  final String _loginKey = 'is_logged_in';
  final String _userKey = 'username';

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  // Cek apakah user sudah pernah login sebelumnya
  void checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool(_loginKey) ?? false;

    // Delay sedikit untuk efek splash screen
    await Future.delayed(const Duration(seconds: 1));

    if (isLoggedIn) {
      Get.offAll(() => HomeView());
    } else {
      Get.offAll(() => LoginView());
    }
  }

  // Fungsi Fake Login
  void login(String username, String password) async {
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        'Error',
        'Username dan Password tidak boleh kosong!',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    // Simpan session ke SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_loginKey, true);
    await prefs.setString(_userKey, username);

    Get.snackbar('Sukses', 'Selamat datang, $username!');
    Get.offAll(() => HomeView());
  }

  // Bonus: Fungsi Logout
  void logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Hapus semua session
    Get.offAll(() => LoginView());
  }
}
