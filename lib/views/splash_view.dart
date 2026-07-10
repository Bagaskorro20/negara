import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class SplashView extends StatelessWidget {
  SplashView({Key? key}) : super(key: key);

  // Inisiasi AuthController saat aplikasi dibuka
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.public, size: 80, color: Colors.blue),
            SizedBox(height: 16),
            Text(
              'Country Explorer',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
