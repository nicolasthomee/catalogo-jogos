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

  // Adiciona um novo jogo na lista
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

  // Remove um jogo da lista
  void deleteGame(int index) {
    setState(() {
      games.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior da tela
      appBar: AppBar(
        title: Text(
          "Jogos",
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

      // Lista dinâmica de jogos
      body: ListView.builder(
        itemCount: games.length, // quantidade de itens
        itemBuilder: (context, index) {
          final game = games[index];

          return Padding(
            padding: EdgeInsets.all(8),

            // Card que representa cada jogo
            child: Card(
              color: Color.fromRGBO(42, 45, 58, 1),

              child: ListTile(
                // Ícone do jogo
                leading: Icon(
                  Icons.sports_esports,
                  color: Color.fromRGBO(114, 137, 255, 1),
                ),

                // Nome do jogo
                title: Text(
                  game.name,
                  style: TextStyle(color: Colors.white),
                ),

                // Informações secundárias (gênero e plataforma)
                subtitle: Text(
                  "${game.genre} • ${game.platform}",
                  style: TextStyle(color: Color.fromRGBO(174, 174, 178, 1)),
                ),

                // Ao clicar, abre a tela de detalhes
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => GameDetailPage(game: game),
                    ),
                  );
                },

                // Botões de ação (editar e excluir)
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // BOTÃO EDITAR
                    IconButton(
                      icon: Icon(
                        Icons.edit,
                        color: Color.fromRGBO(255, 179, 64, 1),
                      ),
                      onPressed: () async {
                        // Abre o formulário com o jogo atual
                        final updated = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => GameFormPage(game: game),
                          ),
                        );

                        // Se houver retorno, atualiza o item
                        if (updated != null) {
                          updateGame(index, updated);
                        }
                      },
                    ),

                    // BOTÃO DELETAR
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Color.fromRGBO(255, 95, 87, 1),
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

      // Botão flutuante para adicionar novo jogo
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromRGBO(88, 101, 242, 1),
        foregroundColor: Colors.white,
        child: Icon(Icons.add),

        onPressed: () async {
          // Abre a tela de criação
          final newGame = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => GameFormPage(),
            ),
          );

          // Se retornar um jogo, adiciona na lista
          if (newGame != null) {
            addGame(newGame);
          }
        },
      ),
    );
  }
}