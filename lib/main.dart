import 'package:app_gerenciamento_de_tarefas/presentation/auth/welcome_screen.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/pages/login_page.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Garante que o Flutter esteja inicializado
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDC-MtrHdkjdrZUg9MG-Zl6OfjiDjJTM3w",
      authDomain: "projeto-livros-80dc9.firebaseapp.com",
      projectId: "projeto-livros-80dc9",
      storageBucket: "projeto-livros-80dc9.firebasestorage.app",
      messagingSenderId: "297220299582",
      appId: "1:297220299582:web:91d1f72b02ee78f19eea6f",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Livros',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
