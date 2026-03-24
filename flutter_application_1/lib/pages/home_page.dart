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
              // Ícone principal do app
              Icon(
                Icons.videogame_asset,
                size: 80,
                color: Color.fromRGBO(114, 137, 255, 1),
              ),

              SizedBox(height: 20),

              // Título do aplicativo
              Text(
                "Catálogo de Jogos",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              SizedBox(height: 30),

              // Botão para acessar a lista de jogos
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(88, 101, 242, 1),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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