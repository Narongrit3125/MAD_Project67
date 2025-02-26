import 'package:account/provider/drinkmenuProvider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'homeScreen.dart';
import 'package:provider/provider.dart';
void main() async {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => DrinkMenuProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SD Drink Menu',
        theme: ThemeData(
          brightness: Brightness.light,
          primarySwatch: Colors.brown,
          textTheme: GoogleFonts.promptTextTheme(),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.brown,
            foregroundColor: Colors.white,
            elevation: 4,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.brown,
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          textTheme: GoogleFonts.promptTextTheme(
            ThemeData.dark().textTheme,
          ),
        ),
        themeMode: ThemeMode.system, // ใช้ตามการตั้งค่าของระบบ
        home: const HomeScreen(), // ใช้ HomeScreen แทน SplashScreen
      ),
    );
  }
}


class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // หน่วงเวลา 2 วินาที แล้วเปลี่ยนหน้า
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });

    return Scaffold(
      backgroundColor: Colors.brown.shade700,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_cafe, size: 100, color: Colors.white),
            const SizedBox(height: 20),
            Text(
              'SD Drink Menu',
              style: GoogleFonts.prompt(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

