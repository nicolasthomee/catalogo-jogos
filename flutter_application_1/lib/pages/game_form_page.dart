import 'package:flutter/material.dart';
import '../models/game_model.dart';

// Tela responsável por adicionar ou editar um jogo
class GameFormPage extends StatefulWidget {
  final Game? game; // Recebe um jogo opcional (para edição)

  const GameFormPage({super.key, this.game});

  @override
  State<GameFormPage> createState() => _GameFormPageState();
}

class _GameFormPageState extends State<GameFormPage> {
  // Controllers para capturar texto digitado
  final nameController = TextEditingController();
  final yearController = TextEditingController();

  // Variáveis para armazenar seleções dos dropdowns
  String? selectedGenre;
  String? selectedPlatform;
  String? selectedStatus;

  // Valor da nota (slider)
  double rating = 3;

  // Lista de opções de gênero
  final List<String> genres = [
    "Ação",
    "Aventura",
    "RPG",
    "Simulador",
    "Esporte",
    "Terror",
  ];

  // Lista de plataformas
  final List<String> platforms = [
    "PC",
    "PlayStation 3",
    "PlayStation 4",
    "PlayStation 5",
    "Xbox 360",
    "Xbox One",
    "Xbox Series X",
  ];

  // Lista de status do jogo
  final List<String> statusList = [
    "Jogando",
    "Zerado",
    "Quero jogar",
  ];

  @override
  void initState() {
    super.initState();

    // Se estiver editando, preenche os campos com os dados existentes
    if (widget.game != null) {
      nameController.text = widget.game!.name;
      selectedGenre = widget.game!.genre;
      selectedPlatform = widget.game!.platform;
    }
  }

  // Função responsável por salvar o jogo
  void save() {
    // Validação simples
    if (selectedGenre == null || selectedPlatform == null) return;

    // Criação do objeto Game com os dados preenchidos
    final game = Game(
      name: nameController.text,
      genre: selectedGenre!,
      platform: selectedPlatform!,
      year: yearController.text.isEmpty ? null : int.parse(yearController.text),
      status: selectedStatus,
      // Nota só é salva se o jogo não for "Quero jogar"
      rating: selectedStatus == "Quero jogar" ? null : rating,
    );

    // Retorna o objeto para a tela anterior
    Navigator.pop(context, game);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior com título dinâmico (adicionar ou editar)
      appBar: AppBar(
        title: Text(
          widget.game == null ? "Adicionar Jogo" : "Editar Jogo",
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
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Campo de nome
              TextField(
                controller: nameController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Color.fromRGBO(70, 74, 90, 1)),
                  filled: true,
                  fillColor: Color.fromRGBO(34, 37, 47, 1),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 15),

              // Campo de ano
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: "Ano de lançamento",
                  labelStyle: TextStyle(color: Color.fromRGBO(70, 74, 90, 1)),
                  filled: true,
                  fillColor: Color.fromRGBO(34, 37, 47, 1),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 15),

              // Dropdown de gênero
              DropdownButtonFormField<String>(
                value: selectedGenre,
                dropdownColor: Color.fromRGBO(34, 37, 47, 1),
                style: TextStyle(color: Colors.white),
                items: genres.map((g) {
                  return DropdownMenuItem(value: g, child: Text(g));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Gênero",
                  filled: true,
                  fillColor: Color.fromRGBO(34, 37, 47, 1),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 15),

              // Dropdown de plataforma
              DropdownButtonFormField<String>(
                value: selectedPlatform,
                dropdownColor: Color.fromRGBO(34, 37, 47, 1),
                style: TextStyle(color: Colors.white),
                items: platforms.map((p) {
                  return DropdownMenuItem(value: p, child: Text(p));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPlatform = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Plataforma",
                  filled: true,
                  fillColor: Color.fromRGBO(34, 37, 47, 1),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 15),

              // Dropdown de status
              DropdownButtonFormField<String>(
                value: selectedStatus,
                dropdownColor: Color.fromRGBO(34, 37, 47, 1),
                style: TextStyle(color: Colors.white),
                items: statusList.map((s) {
                  return DropdownMenuItem(value: s, child: Text(s));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Status",
                  filled: true,
                  fillColor: Color.fromRGBO(34, 37, 47, 1),
                  border: OutlineInputBorder(),
                ),
              ),

              SizedBox(height: 20),

              // Nota só aparece quando faz sentido (não "Quero jogar")
              if (selectedStatus != "Quero jogar")
                Column(
                  children: [
                    Text(
                      "Nota: ${rating.toInt()}",
                      style: TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: rating,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      activeColor: Color.fromRGBO(88, 101, 242, 1),
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                  ],
                ),

              SizedBox(height: 20),

              // Botão de salvar
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(88, 101, 242, 1),
                  foregroundColor: Colors.white,
                ),
                onPressed: save,
                child: Text("Salvar"),
              )
            ],
          ),
        ),
      ),
    );
  }
}