import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  final AuthController authController = Get.find<AuthController>();
  final TextEditingController userCtrl = TextEditingController();
  final TextEditingController passCtrl = TextEditingController();

  // --- VIBRANT PALETTE ---
  final Color primaryPurple = const Color(
    0xFF6366F1,
  ); // Indigo Purple yang modern
  final Color darkPurple = const Color(0xFF312E81); // Ungu sangat pekat
  final Color accentCoral = const Color(
    0xFFF43F5E,
  ); // Aksen Coral/Pink cerah (Pecah Monoton!)
  final Color bgLight = const Color(0xFFF8FAFC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgLight,
      body: Stack(
        children: [
          // HEADER
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: MediaQuery.of(context).size.height * 0.45,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [darkPurple, primaryPurple],
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(100), // Asimetris biar gak kaku
                ),
              ),
              child: Stack(
                children: [
                  // Elemen dekoratif abstrak
                  Positioned(
                    top: -20,
                    right: -20,
                    child: CircleAvatar(
                      radius: 80,
                      backgroundColor: Colors.white.withOpacity(0.05),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    left: 30,
                    child: CircleAvatar(
                      radius: 30,
                      backgroundColor: accentCoral.withOpacity(
                        0.8,
                      ), // Letupan warna!
                    ),
                  ),
                ],
              ),
            ),
          ),

          // LOGIN
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    // Teks Header
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Mulai\nPetualanganmu.',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.w900,
                          height: 1.1,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Kotak Form (Overlapping ke background)
                    Container(
                      padding: const EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: primaryPurple.withOpacity(0.15),
                            blurRadius: 30,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildTextField(
                            controller: userCtrl,
                            hint: 'Username',
                            icon: Icons.alternate_email_rounded,
                          ),
                          const SizedBox(height: 24),
                          _buildTextField(
                            controller: passCtrl,
                            hint: 'Password',
                            icon: Icons.lock_outline_rounded,
                            isPassword: true,
                          ),
                          const SizedBox(height: 40),

                          // Tombol Login dengan efek Gradient
                          Container(
                            width: double.infinity,
                            height: 56,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              gradient: LinearGradient(
                                colors: [
                                  primaryPurple,
                                  accentCoral,
                                ], // Gradasi atraktif
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: accentCoral.withOpacity(0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.transparent,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              onPressed: () {
                                authController.login(
                                  userCtrl.text,
                                  passCtrl.text,
                                );
                              },
                              child: const Text(
                                'MASUK',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: primaryPurple),
        filled: true,
        fillColor: bgLight,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: primaryPurple, width: 2),
        ),
      ),
    );
  }
}
