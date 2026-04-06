import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../main.dart';
import 'game_form_page.dart';
import 'game_detail_page.dart';

// ─── Tela de Lista de Jogos ───────────────────────────────────────────────────
// Exibe todos os jogos cadastrados em cards. Permite adicionar, editar
// e excluir entradas. Mostra estado vazio quando não há jogos.

class GamesListPage extends StatefulWidget {
  final List<Game> games; // Lista recebida e gerenciada localmente

  const GamesListPage({super.key, required this.games});

  @override
  State<GamesListPage> createState() => _GamesListPageState();
}

class _GamesListPageState extends State<GamesListPage> {

  // Cópia local da lista para permitir setState isolado
  late List<Game> _games;

  @override
  void initState() {
    super.initState();
    _games = widget.games;
  }

  // ── CRUD da Lista ──────────────────────────────────────────────────

  void _addGame(Game game) => setState(() => _games.add(game));

  void _updateGame(int index, Game game) =>
      setState(() => _games[index] = game);

  void _deleteGame(int index) => setState(() => _games.removeAt(index));

  // ── Abre o formulário para novo jogo ─────────────────────────────
  Future<void> _navigateToAdd() async {
    final newGame = await Navigator.push<Game>(
      context,
      MaterialPageRoute(builder: (_) => const GameFormPage()),
    );
    if (newGame != null) _addGame(newGame);
  }

  // ── Abre o formulário para editar jogo existente ──────────────────
  Future<void> _navigateToEdit(int index) async {
    final updated = await Navigator.push<Game>(
      context,
      MaterialPageRoute(
        builder: (_) => GameFormPage(game: _games[index]),
      ),
    );
    if (updated != null) _updateGame(index, updated);
  }

  // ── Abre a tela de detalhes do jogo ──────────────────────────────
  void _navigateToDetail(Game game) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => GameDetailPage(game: game)),
    );
  }

  // ── Diálogo de confirmação antes de deletar ───────────────────────
  Future<void> _confirmDelete(int index) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surfaceAlt,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        title: const Text(
          'Remover jogo?',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        content: Text(
          'Esta ação não pode ser desfeita.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(
              'Cancelar',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text(
              'Remover',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true) _deleteGame(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meus Jogos'),
        toolbarHeight: 72,
        // Badge com contagem de jogos
        actions: [
          if (_games.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.accentGlow,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.accent.withOpacity(0.4),
                    ),
                  ),
                  child: Text(
                    '${_games.length}',
                    style: const TextStyle(
                      color: AppColors.accent,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),

      // ── Corpo: lista ou estado vazio ──────────────────────────────
      body: _games.isEmpty ? _buildEmptyState() : _buildList(),

      // ── FAB para adicionar jogo ───────────────────────────────────
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAdd,
        backgroundColor: AppColors.accent,
        foregroundColor: AppColors.textPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add_rounded, size: 28),
      ),
    );
  }

  // ── Estado vazio: exibe quando não há jogos cadastrados ───────────
  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.videogame_asset_off_rounded,
              size: 64,
              color: AppColors.textSecondary.withOpacity(0.4),
            ),
            const SizedBox(height: 20),
            Text(
              'Nenhum jogo ainda',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Toque no + para adicionar\nseu primeiro jogo ao catálogo.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary.withOpacity(0.6),
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Lista animada de cards de jogo ───────────────────────────────
  Widget _buildList() {
    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
      itemCount: _games.length,
      itemBuilder: (context, index) {
        final game = _games[index];

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: _GameCard(
            game: game,
            onTap:    () => _navigateToDetail(game),
            onEdit:   () => _navigateToEdit(index),
            onDelete: () => _confirmDelete(index),
          ),
        );
      },
    );
  }
}

// ─── Card Individual de Jogo ──────────────────────────────────────────────────
// Widget isolado para melhor reusabilidade e performance (evita rebuilds
// desnecessários na lista).

class _GameCard extends StatelessWidget {
  final Game game;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _GameCard({
    required this.game,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.surface,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        splashColor: AppColors.accent.withOpacity(0.08),
        highlightColor: AppColors.accent.withOpacity(0.04),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              // ── Ícone do jogo ──────────────────────────────────────
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.accentGlow,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.sports_esports_rounded,
                  color: AppColors.accent,
                  size: 24,
                ),
              ),

              const SizedBox(width: 14),

              // ── Informações do jogo ────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      game.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                        letterSpacing: -0.1,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${game.genre} · ${game.platform}',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              // ── Nota (se houver) ───────────────────────────────────
              if (game.rating != null) ...[
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.star,
                  size: 15,
                ),
                const SizedBox(width: 3),
                Text(
                  game.formattedRating,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.star,
                  ),
                ),
                const SizedBox(width: 4),
              ],

              // ── Ações: editar e deletar ────────────────────────────
              _ActionIcon(
                icon: Icons.edit_rounded,
                onTap: onEdit,
              ),
              _ActionIcon(
                icon: Icons.delete_outline_rounded,
                onTap: onDelete,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Ícone de Ação Compacto ────────────────────────────────────────────────────
class _ActionIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon, size: 20, color: AppColors.textSecondary),
      onPressed: onTap,
      visualDensity: VisualDensity.compact,
      splashRadius: 20,
    );
  }
}