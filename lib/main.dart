import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shop_flex_web_admin/views/screens/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: kIsWeb || Platform.isAndroid
          ? const FirebaseOptions(
              apiKey: "AIzaSyCk9ot0nE4eytaz7xTg8q9pQTm3tJzgnuk",
              appId: "1:408622842218:web:a9154104c84af76e86e513",
              messagingSenderId: "408622842218",
              projectId: "shopflex-24522",
              storageBucket: "shopflex-24522.appspot.com",
            )
          : null);
  runApp(const MyApp());
  configLoading();
}


void configLoading() {
  EasyLoading.instance
// Change background color
    ..backgroundColor = Colors.blue
    ..indicatorColor = Colors.white // Change indicator color
    ..textColor = Colors.white // Change text color
    ..maskColor = Colors.blue.withOpacity(0.5) // Change mask color
    ..userInteractions = false // Disable user interactions while loading
    ..displayDuration = const Duration(milliseconds: 2000) // Set the duration of how long it appears
    ..indicatorType = EasyLoadingIndicatorType.cubeGrid; // Customize the indicator type
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ShopFlex Web Admin Panel',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pinkAccent),
        useMaterial3: true,
      ),
      home: MainScreen(),
      builder: EasyLoading.init(),
    );
  }
}

