import 'package:app_gerenciamento_de_tarefas/presentation/auth/welcome_screen.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/pages/login_page.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/pages/register_page.dart';
import 'package:flutter/material.dart';

import 'presentation/pages/home_page.dart';

void main() {
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
      initialRoute: '/welcome', // Tela inicial
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}