import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/game_model.dart';
import '../main.dart';

// ─── Tela de Formulário ───────────────────────────────────────────────────────
// Usada tanto para adicionar quanto para editar um jogo.
// Inclui validação de campos, feedback visual e UX fluida.

class GameFormPage extends StatefulWidget {
  final Game? game; // null = novo jogo | Game = edição

  const GameFormPage({super.key, this.game});

  @override
  State<GameFormPage> createState() => _GameFormPageState();
}

class _GameFormPageState extends State<GameFormPage> {

  // ── Chave de validação do formulário ─────────────────────────────
  final _formKey = GlobalKey<FormState>();

  // ── Controllers de texto ─────────────────────────────────────────
  late final TextEditingController _nameController;
  late final TextEditingController _yearController;

  // ── Campos selecionáveis ─────────────────────────────────────────
  String? _selectedGenre;
  String? _selectedPlatform;
  String? _selectedStatus;
  double  _rating = 3;

  // ── Opções disponíveis ───────────────────────────────────────────
  static const _genres = [
    'Ação', 'Aventura', 'RPG', 'Simulador', 'Esporte', 'Terror', 'Estratégia',
  ];

  static const _platforms = [
    'PC', 'PlayStation 3', 'PlayStation 4', 'PlayStation 5',
    'Xbox 360', 'Xbox One', 'Xbox Series X', 'Nintendo Switch',
  ];

  static const _statusList = ['Jogando', 'Zerado', 'Quero jogar'];

  // ── Determina se é edição ou criação ─────────────────────────────
  bool get _isEditing => widget.game != null;

  @override
  void initState() {
    super.initState();

    final g = widget.game;

    // Pré-preenche campos se estiver editando
    _nameController = TextEditingController(text: g?.name ?? '');
    _yearController = TextEditingController(
      text: g?.year?.toString() ?? '',
    );

    _selectedGenre    = g?.genre;
    _selectedPlatform = g?.platform;
    _selectedStatus   = g?.status;
    _rating           = g?.rating ?? 3;
  }

  @override
  void dispose() {
    // Libera controllers para evitar memory leak
    _nameController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  // ── Valida e salva o jogo ─────────────────────────────────────────
  void _save() {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedGenre == null || _selectedPlatform == null) {
      _showError('Selecione o gênero e a plataforma.');
      return;
    }

    final game = Game(
      name:     _nameController.text.trim(),
      genre:    _selectedGenre!,
      platform: _selectedPlatform!,
      year:     _yearController.text.isEmpty
                  ? null
                  : int.tryParse(_yearController.text),
      status:   _selectedStatus,
      // Nota não se aplica a jogos da lista de desejos
      rating:   _selectedStatus == 'Quero jogar' ? null : _rating,
    );

    Navigator.pop(context, game);
  }

  // ── Exibe snackbar de erro de validação ───────────────────────────
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.redAccent,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Editar Jogo' : 'Novo Jogo'),
        toolbarHeight: 72,
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Seção: Informações Básicas ──────────────────────
              _SectionLabel('Informações Básicas'),
              const SizedBox(height: 10),

              // Nome do jogo
              _buildTextField(
                controller: _nameController,
                label: 'Nome do jogo',
                icon: Icons.sports_esports_rounded,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Informe o nome do jogo'
                    : null,
              ),

              const SizedBox(height: 12),

              // Ano de lançamento
              _buildTextField(
                controller: _yearController,
                label: 'Ano de lançamento',
                icon: Icons.calendar_month_rounded,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(4),
                ],
                validator: (v) {
                  if (v == null || v.isEmpty) return null; // campo opcional
                  final year = int.tryParse(v);
                  if (year == null || year < 1970 || year > 2100) {
                    return 'Informe um ano válido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // ── Seção: Classificação ────────────────────────────
              _SectionLabel('Classificação'),
              const SizedBox(height: 10),

              // Gênero
              _buildDropdown(
                value: _selectedGenre,
                label: 'Gênero',
                icon: Icons.label_rounded,
                items: _genres,
                onChanged: (v) => setState(() => _selectedGenre = v),
              ),

              const SizedBox(height: 12),

              // Plataforma
              _buildDropdown(
                value: _selectedPlatform,
                label: 'Plataforma',
                icon: Icons.devices_rounded,
                items: _platforms,
                onChanged: (v) => setState(() => _selectedPlatform = v),
              ),

              const SizedBox(height: 20),

              // ── Seção: Progresso ────────────────────────────────
              _SectionLabel('Progresso'),
              const SizedBox(height: 10),

              // Status
              _buildDropdown(
                value: _selectedStatus,
                label: 'Status',
                icon: Icons.flag_rounded,
                items: _statusList,
                onChanged: (v) => setState(() => _selectedStatus = v),
              ),

              // ── Slider de nota (oculto para "Quero jogar") ──────
              if (_selectedStatus != null &&
                  _selectedStatus != 'Quero jogar') ...[
                const SizedBox(height: 20),
                _buildRatingSlider(),
              ],

              const SizedBox(height: 32),

              // ── Botão salvar ────────────────────────────────────
              ElevatedButton(
                onPressed: _save,
                child: Text(_isEditing ? 'Salvar Alterações' : 'Adicionar Jogo'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Campo de texto estilizado ─────────────────────────────────────
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      inputFormatters: inputFormatters,
      validator: validator,
      cursorColor: AppColors.accent,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
      ),
      decoration: _inputDecoration(label, icon),
    );
  }

  // ── Dropdown estilizado ───────────────────────────────────────────
  Widget _buildDropdown({
    required String?        value,
    required String         label,
    required IconData       icon,
    required List<String>   items,
    required ValueChanged<String?> onChanged,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      dropdownColor: AppColors.surfaceAlt,
      style: const TextStyle(
        color: AppColors.textPrimary,
        fontSize: 15,
      ),
      decoration: _inputDecoration(label, icon),
      isExpanded: true,
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  // ── Slider de avaliação com estrelas ──────────────────────────────
  Widget _buildRatingSlider() {
    final stars = _rating.toInt();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Estrelas visuais
              Row(
                children: List.generate(5, (i) {
                  return Icon(
                    i < stars
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: i < stars
                        ? AppColors.star
                        : AppColors.textSecondary.withOpacity(0.3),
                    size: 22,
                  );
                }),
              ),
              const SizedBox(width: 10),
              Text(
                '$stars / 5',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.star,
                ),
              ),
            ],
          ),

          Slider(
            value: _rating,
            min: 1,
            max: 5,
            divisions: 4,
            onChanged: (v) => setState(() => _rating = v),
          ),
        ],
      ),
    );
  }

  // ── Estilo padrão dos campos de input ─────────────────────────────
  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon, color: AppColors.textSecondary, size: 20),
      labelStyle: TextStyle(color: AppColors.textSecondary),
      floatingLabelStyle: const TextStyle(color: AppColors.accent),
      filled: true,
      fillColor: AppColors.surface,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.divider),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.accent, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }
}

// ─── Label de seção ───────────────────────────────────────────────────────────
// Cabeçalho visual para agrupar campos relacionados no formulário.
class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: AppColors.textSecondary,
        letterSpacing: 1.2,
      ),
    );
  }
}