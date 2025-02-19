import 'package:app_gerenciamento_de_tarefas/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart'; // Importe o Firebase Core
import 'presentation/pages/home_page.dart'; // Importe a HomePage do catálogo de livros

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter esteja inicializado
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // Inicializa o Firebase
  );
  runApp(const MyApp()); // Inicia o aplicativo
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // Este widget é a raiz do aplicativo.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catálogo de Livros', // Título do aplicativo
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal), // Tema do aplicativo
        useMaterial3: true, // Usa Material 3
      ),
      home: const HomePage(), // Define a HomePage como a página inicial
    );
  }
}