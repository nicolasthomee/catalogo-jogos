import 'package:flutter/material.dart';
import 'pages/home_page.dart';

// Função principal que inicia o aplicativo
void main() {
  runApp(const MyApp());
}

// Classe principal do app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Nome do aplicativo
      title: 'Catálogo de Jogos',

      // Tema global do app (cores e estilos)
      theme: ThemeData(
        // Cor de fundo padrão de todas as telas
        scaffoldBackgroundColor: Color.fromRGBO(24, 26, 32, 1),

        // Estilo padrão das AppBars
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(36, 38, 48, 1),
          foregroundColor: Colors.white,
        ),

        // Estilo padrão dos textos
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),

      // Tela inicial do aplicativo
      home: const HomePage(),
    );
  }
}