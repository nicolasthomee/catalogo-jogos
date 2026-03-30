import 'package:flutter/material.dart';
import '../models/game_model.dart';
import 'games_list_page.dart';

// Tela inicial do aplicativo
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Lista de jogos que será compartilhada com a próxima tela
  List<Game> games = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // SafeArea evita que o conteúdo fique atrás da barra do sistema
      body: SafeArea(
        child: Center(
          // Centraliza todos os elementos na tela
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícone principal do app (mais moderno e maior)
              Icon(
                Icons.sports_esports,
                size: 110,
                color: Color.fromRGBO(0, 190, 255, 1),
              ),

              SizedBox(height: 20),

              // Título do aplicativo
              Text(
                "Catálogo de Jogos",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(230, 235, 240, 1),
                ),
              ),

              SizedBox(height: 30),

              // Botão para acessar a lista de jogos
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 160, 220, 1),
                  foregroundColor: Color.fromRGBO(230, 235, 240, 1),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  // Navega para a tela de lista, passando a lista de jogos
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GamesListPage(games: games),
                    ),
                  );
                },
                child: const Text("Ver Jogos"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}