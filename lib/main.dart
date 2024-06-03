import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'features/splash/presentation/views/splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(
    apiKey: 'AIzaSyCIaJyc5M8ET0qKFUSyYn1-4w-XJjLWkL8',
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Splash(),
    );
  }
}
