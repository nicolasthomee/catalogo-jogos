import 'package:flutter/material.dart';
import '../models/game_model.dart';

// Tela responsável por adicionar ou editar um jogo
class GameFormPage extends StatefulWidget {
  final Game? game;

  const GameFormPage({super.key, this.game});

  @override
  State<GameFormPage> createState() => _GameFormPageState();
}

class _GameFormPageState extends State<GameFormPage> {
  final nameController = TextEditingController();
  final yearController = TextEditingController();

  String? selectedGenre;
  String? selectedPlatform;
  String? selectedStatus;

  double rating = 3;

  final List<String> genres = [
    "Ação",
    "Aventura",
    "RPG",
    "Simulador",
    "Esporte",
    "Terror",
  ];

  final List<String> platforms = [
    "PC",
    "PlayStation 3",
    "PlayStation 4",
    "PlayStation 5",
    "Xbox 360",
    "Xbox One",
    "Xbox Series X",
  ];

  final List<String> statusList = [
    "Jogando",
    "Zerado",
    "Quero jogar",
  ];

  @override
  void initState() {
    super.initState();

    if (widget.game != null) {
      nameController.text = widget.game!.name;
      selectedGenre = widget.game!.genre;
      selectedPlatform = widget.game!.platform;
    }
  }

  void save() {
    if (selectedGenre == null || selectedPlatform == null) return;

    final game = Game(
      name: nameController.text,
      genre: selectedGenre!,
      platform: selectedPlatform!,
      year: yearController.text.isEmpty ? null : int.parse(yearController.text),
      status: selectedStatus,
      rating: selectedStatus == "Quero jogar" ? null : rating,
    );

    Navigator.pop(context, game);
  }

  // Estilo padrão dos inputs (remove totalmente o roxo)
  InputDecoration inputStyle(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(
        color: Color.fromRGBO(140, 160, 170, 1),
      ),
      floatingLabelStyle: TextStyle(
        color: Color.fromRGBO(0, 190, 255, 1),
      ),
      filled: true,
      fillColor: Color.fromRGBO(12, 30, 40, 1),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Color.fromRGBO(50, 75, 90, 1),
        ),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(
          color: Color.fromRGBO(0, 190, 255, 1),
          width: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.game == null ? "Adicionar Jogo" : "Editar Jogo",
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

      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // NOME
              TextField(
                controller: nameController,
                cursorColor: Color.fromRGBO(0, 190, 255, 1),
                style: TextStyle(color: Color.fromRGBO(230, 235, 240, 1)),
                decoration: inputStyle("Nome"),
              ),

              SizedBox(height: 15),

              // ANO
              TextField(
                controller: yearController,
                keyboardType: TextInputType.number,
                cursorColor: Color.fromRGBO(0, 190, 255, 1),
                style: TextStyle(color: Color.fromRGBO(230, 235, 240, 1)),
                decoration: inputStyle("Ano de lançamento"),
              ),

              SizedBox(height: 15),

              // GENERO
              DropdownButtonFormField<String>(
                value: selectedGenre,
                dropdownColor: Color.fromRGBO(12, 30, 40, 1),
                style: TextStyle(color: Color.fromRGBO(230, 235, 240, 1)),
                items: genres.map((g) {
                  return DropdownMenuItem(value: g, child: Text(g));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedGenre = value;
                  });
                },
                decoration: inputStyle("Gênero"),
              ),

              SizedBox(height: 15),

              // PLATAFORMA
              DropdownButtonFormField<String>(
                value: selectedPlatform,
                dropdownColor: Color.fromRGBO(12, 30, 40, 1),
                style: TextStyle(color: Color.fromRGBO(230, 235, 240, 1)),
                items: platforms.map((p) {
                  return DropdownMenuItem(value: p, child: Text(p));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedPlatform = value;
                  });
                },
                decoration: inputStyle("Plataforma"),
              ),

              SizedBox(height: 15),

              // STATUS
              DropdownButtonFormField<String>(
                value: selectedStatus,
                dropdownColor: Color.fromRGBO(12, 30, 40, 1),
                style: TextStyle(color: Color.fromRGBO(230, 235, 240, 1)),
                items: statusList.map((s) {
                  return DropdownMenuItem(value: s, child: Text(s));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedStatus = value;
                  });
                },
                decoration: inputStyle("Status"),
              ),

              SizedBox(height: 20),

              // NOTA
              if (selectedStatus != "Quero jogar")
                Column(
                  children: [
                    Text(
                      "Nota: ${rating.toInt()}",
                      style: TextStyle(
                        color: Color.fromRGBO(230, 235, 240, 1),
                      ),
                    ),
                    Slider(
                      value: rating,
                      min: 1,
                      max: 5,
                      divisions: 4,
                      activeColor: Color.fromRGBO(0, 190, 255, 1),
                      onChanged: (value) {
                        setState(() {
                          rating = value;
                        });
                      },
                    ),
                  ],
                ),

              SizedBox(height: 20),

              // BOTÃO SALVAR
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromRGBO(0, 160, 220, 1),
                  foregroundColor: Color.fromRGBO(230, 235, 240, 1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
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