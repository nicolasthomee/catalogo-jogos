import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../main.dart';

// ─── Tela de Detalhes do Jogo ─────────────────────────────────────────────────
// Exibe todas as informações de um jogo em um layout limpo e hierárquico.
// Usa chips de status e estrelas para comunicação visual rápida.

class GameDetailPage extends StatelessWidget {
  final Game game;

  const GameDetailPage({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes'),
        toolbarHeight: 72,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Hero card com nome e ícone ──────────────────────────
            _buildHeroCard(),

            const SizedBox(height: 12),

            // ── Grid de atributos principais ───────────────────────
            _buildInfoGrid(),

            // ── Bloco de nota (quando disponível) ──────────────────
            if (game.rating != null) ...[
              const SizedBox(height: 12),
              _buildRatingCard(),
            ],
          ],
        ),
      ),
    );
  }

  // ── Card principal com nome e ícone do jogo ───────────────────────
  Widget _buildHeroCard() {
    return _Card(
      child: Row(
        children: [
          // Ícone com brilho
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.accentGlow,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.sports_esports_rounded,
              color: AppColors.accent,
              size: 30,
            ),
          ),

          const SizedBox(width: 16),

          // Nome e chip de status
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  game.name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                    letterSpacing: -0.3,
                    height: 1.2,
                  ),
                ),

                if (game.status != null) ...[
                  const SizedBox(height: 6),
                  _StatusChip(status: game.status!),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Grid 2x2 com gênero, plataforma, ano e status ─────────────────
  Widget _buildInfoGrid() {
    return _Card(
      child: Column(
        children: [
          // Linha 1: Gênero e Plataforma
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.label_rounded,
                  label: 'Gênero',
                  value: game.genre,
                ),
              ),
              _Divider(vertical: true),
              Expanded(
                child: _InfoTile(
                  icon: Icons.devices_rounded,
                  label: 'Plataforma',
                  value: game.platform,
                ),
              ),
            ],
          ),

          // Exibe linha do ano apenas se disponível
          if (game.year != null) ...[
            _Divider(),
            _InfoTile(
              icon: Icons.calendar_month_rounded,
              label: 'Ano de Lançamento',
              value: '${game.year}',
              full: true,
            ),
          ],
        ],
      ),
    );
  }

  // ── Card de nota com estrelas visuais ─────────────────────────────
  Widget _buildRatingCard() {
    final int stars = game.rating!.toInt();

    return _Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Avaliação',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
              letterSpacing: 0.5,
            ),
          ),

          const SizedBox(height: 10),

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
                    size: 28,
                  );
                }),
              ),

              const SizedBox(width: 12),

              // Valor numérico
              Text(
                '${stars}/5',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.star,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Widgets Auxiliares Reutilizáveis ─────────────────────────────────────────

// Card com fundo escuro padrão
class _Card extends StatelessWidget {
  final Widget child;

  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: child,
    );
  }
}

// Linha de informação com ícone, label e valor
class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String   label;
  final String   value;
  final bool     full; // Ocupa largura total (sem divisão em colunas)

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
    this.full = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: full
          ? EdgeInsets.zero
          : const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 18, color: AppColors.accent),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textSecondary,
                    letterSpacing: 0.4,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Chip colorido para exibir o status do jogo
class _StatusChip extends StatelessWidget {
  final String status;

  const _StatusChip({required this.status});

  // Mapeia status para cor correspondente
  Color get _color {
    switch (status) {
      case 'Jogando':    return const Color(0xFF34C759); // verde
      case 'Zerado':     return AppColors.accent;         // azul
      case 'Quero jogar': return AppColors.star;          // amarelo
      default:           return AppColors.textSecondary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _color.withOpacity(0.35)),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w600,
          color: _color,
        ),
      ),
    );
  }
}

// Divisória visual entre seções do card
class _Divider extends StatelessWidget {
  final bool vertical;

  const _Divider({this.vertical = false});

  @override
  Widget build(BuildContext context) {
    return vertical
        ? Container(
            width: 1,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 8),
            color: AppColors.divider,
          )
        : Container(
            height: 1,
            margin: const EdgeInsets.symmetric(vertical: 16),
            color: AppColors.divider,
          );
  }
}