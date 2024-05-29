import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset('assets/images/animate.json'),
              const SizedBox(
                height: 150,
              ),
              Text(
                'By Adel Mostafa',
                style: TextStyle(
                  color: Colors.green.withOpacity(0.5),
                  fontSize: 17,
                  fontFamily: 'Pacifico',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
