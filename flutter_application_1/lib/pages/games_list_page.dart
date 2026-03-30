import 'package:flutter/material.dart';
import '../models/game_model.dart';
import 'game_form_page.dart';
import 'game_detail_page.dart';

// Tela principal que lista todos os jogos cadastrados
class GamesListPage extends StatefulWidget {
  final List<Game> games; // Recebe a lista de jogos da tela anterior

  const GamesListPage({super.key, required this.games});

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {
  late List<Game> games;

  @override
  void initState() {
    super.initState();

    // Inicializa a lista local com os dados recebidos
    games = widget.games;
  }

  // Adiciona um novo jogo
  void addGame(Game game) {
    setState(() {
      games.add(game);
    });
  }

  // Atualiza um jogo existente
  void updateGame(int index, Game game) {
    setState(() {
      games[index] = game;
    });
  }

  // Remove um jogo
  void deleteGame(int index) {
    setState(() {
      games.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior
      appBar: AppBar(
        title: Text(
          "Jogos",
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

      // Lista dinâmica de jogos
      body: ListView.builder(
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];

          return Padding(
            padding: EdgeInsets.all(8),

            // Card de cada jogo
            child: Card(
              color: Color.fromRGBO(20, 38, 48, 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // estilo Apple
              ),

              child: ListTile(
                // Ícone do jogo
                leading: Icon(
                  Icons.sports_esports,
                  color: Color.fromRGBO(0, 190, 255, 1),
                ),

                // Nome do jogo
                title: Text(
                  game.name,
                  style: TextStyle(
                    color: Color.fromRGBO(230, 235, 240, 1),
                  ),
                ),

                // Gênero e plataforma
                subtitle: Text(
                  "${game.genre} • ${game.platform}",
                  style: TextStyle(
                    color: Color.fromRGBO(140, 160, 170, 1),
                  ),
                ),

                // Abre tela de detalhes
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GameDetailPage(game: game),
                    ),
                  );
                },

                // Botões de ação
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // BOTÃO EDITAR
                    IconButton(
                      icon: Icon(
                        Icons.edit_rounded,
                        color: Color.fromRGBO(200, 210, 220, 1),
                      ),
                      onPressed: () async {
                        final updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GameFormPage(game: game),
                          ),
                        );

                        if (updated != null) {
                          updateGame(index, updated);
                        }
                      },
                    ),

                    // BOTÃO DELETAR
                    IconButton(
                      icon: Icon(
                        Icons.delete_outline,
                        color: Color.fromRGBO(200, 210, 220, 1),
                      ),
                      onPressed: () {
                        deleteGame(index);
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),

      // Botão para adicionar novo jogo
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 190, 255, 1),
        foregroundColor: Color.fromRGBO(230, 235, 240, 1),
        child: Icon(Icons.add),

        onPressed: () async {
          final newGame = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GameFormPage(),
            ),
          );

          if (newGame != null) {
            addGame(newGame);
          }
        },
      ),
    );
  }
}