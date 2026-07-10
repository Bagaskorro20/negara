import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/splash_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Wajib menggunakan GetMaterialApp untuk GetX
    return GetMaterialApp(
      title: 'Country App - Technical Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: SplashView(),
    );
  }
}
