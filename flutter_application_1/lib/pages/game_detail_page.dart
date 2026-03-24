import 'package:flutter/material.dart';
import '../models/game_model.dart';

// Tela responsável por exibir os detalhes de um jogo
class GameDetailPage extends StatelessWidget {
  final Game game; // Recebe o jogo que será exibido

  const GameDetailPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior com título da tela
      appBar: AppBar(
        title: Text(
          "Detalhes do Jogo",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(88, 101, 242, 1),
        elevation: 0,
        toolbarHeight: 80,
      ),

      // Corpo da tela
      body: Padding(
        padding: const EdgeInsets.all(16),

        // Card que agrupa as informações do jogo
        child: Card(
          color: Color.fromRGBO(36, 36, 40, 1),
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),

          child: Padding(
            padding: const EdgeInsets.all(20),

            // Organização vertical das informações
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NOME DO JOGO
                Row(
                  children: [
                    Icon(
                      Icons.videogame_asset,
                      size: 30,
                      color: Color.fromRGBO(174, 174, 178, 1),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        game.name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                // Linha separadora
                Divider(
                  height: 30,
                  color: Color.fromRGBO(70, 74, 90, 1),
                ),

                // GÊNERO
                Row(
                  children: [
                    Icon(Icons.category,
                        color: Color.fromRGBO(174, 174, 178, 1)),
                    SizedBox(width: 10),
                    Text(
                      "Gênero: ${game.genre}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                // PLATAFORMA
                Row(
                  children: [
                    Icon(Icons.devices,
                        color: Color.fromRGBO(174, 174, 178, 1)),
                    SizedBox(width: 10),
                    Text(
                      "Plataforma: ${game.platform}",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),

                SizedBox(height: 15),

                // ANO (só aparece se existir)
                if (game.year != null)
                  Row(
                    children: [
                      Icon(Icons.calendar_today,
                          color: Color.fromRGBO(174, 174, 178, 1)),
                      SizedBox(width: 10),
                      Text(
                        "Ano: ${game.year}",
                        style:
                            TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),

                SizedBox(height: 15),

                // STATUS (só aparece se existir)
                if (game.status != null)
                  Row(
                    children: [
                      Icon(Icons.flag,
                          color: Color.fromRGBO(174, 174, 178, 1)),
                      SizedBox(width: 10),
                      Text(
                        "Status: ${game.status}",
                        style:
                            TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),

                SizedBox(height: 15),

                // NOTA (só aparece se existir)
                if (game.rating != null)
                  Row(
                    children: [
                      Icon(Icons.star,
                          color: Color.fromRGBO(255, 179, 64, 1)),
                      SizedBox(width: 10),
                      Text(
                        "Nota: ${game.rating}",
                        style:
                            TextStyle(fontSize: 18, color: Colors.white),
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