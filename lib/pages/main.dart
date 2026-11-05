
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/pages/artigo_page.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  runApp(const AprenderApp());
}

class AprenderApp extends StatelessWidget {
  const AprenderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Aprender+',
      theme: ThemeData(
        primaryColor: const Color(0xFF145C9E),
        scaffoldBackgroundColor: const Color(0xFFEAF2EF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF145C9E),
        ),
      ),
      
    );
  }
}
