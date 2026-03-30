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
        scaffoldBackgroundColor: Color.fromRGBO(6, 18, 24, 1),

        // Estilo padrão das AppBars
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(8, 22, 30, 1),
          foregroundColor: Color.fromRGBO(230, 235, 240, 1),
        ),

        // Estilo padrão dos textos
        textTheme: const TextTheme(
          bodyMedium: TextStyle(color: Color.fromRGBO(230, 235, 240, 1)),
        ),
      ),

      // Tela inicial do aplicativo
      home: const HomePage(),
    );
  }
}