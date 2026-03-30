import 'package:flutter/material.dart';
import '../models/game_model.dart';

// Tela responsável por exibir os detalhes de um jogo
class GameDetailPage extends StatelessWidget {
  final Game game;

  const GameDetailPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: Text(
          "Detalhes do Jogo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(6, 18, 24, 1),
        elevation: 0,
        toolbarHeight: 80,
      ),

      // Corpo da tela
      body: Padding(
        padding: const EdgeInsets.all(16),

        // Card com informações
        child: Card(
          color: Color.fromRGBO(20, 38, 48, 1),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20), // Apple style
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOME
                Row(
                  children: [
                    Icon(
                      Icons.sports_esports,
                      size: 32,
                      color: Color.fromRGBO(0, 190, 255, 1),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        game.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromRGBO(230, 235, 240, 1),
                        ),
                      ),
                    ),
                  ],
                ),

                Divider(
                  height: 30,
                  color: Color.fromRGBO(35, 60, 72, 1),
                ),

                // GÊNERO
                Row(
                  children: [
                    Icon(
                      Icons.label_outline, // mais moderno
                      color: Color.fromRGBO(140, 160, 170, 1),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Gênero: ${game.genre}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(230, 235, 240, 1),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                // PLATAFORMA
                Row(
                  children: [
                    Icon(
                      Icons.devices_other, // mais moderno
                      color: Color.fromRGBO(140, 160, 170, 1),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "Plataforma: ${game.platform}",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color.fromRGBO(230, 235, 240, 1),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                // ANO
                if (game.year != null)
                  Row(
                    children: [
                      Icon(
                        Icons.event,
                        color: Color.fromRGBO(140, 160, 170, 1),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Ano: ${game.year}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(230, 235, 240, 1),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 15),

                // STATUS
                if (game.status != null)
                  Row(
                    children: [
                      Icon(
                        Icons.flag_outlined,
                        color: Color.fromRGBO(140, 160, 170, 1),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Status: ${game.status}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(230, 235, 240, 1),
                        ),
                      ),
                    ],
                  ),

                SizedBox(height: 15),

                // NOTA
                if (game.rating != null)
                  Row(
                    children: [
                      Icon(
                        Icons.star_rounded,
                        color: Color.fromRGBO(255, 170, 60, 1),
                      ),
                      SizedBox(width: 10),
                      Text(
                        "Nota: ${game.rating}",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(230, 235, 240, 1),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}