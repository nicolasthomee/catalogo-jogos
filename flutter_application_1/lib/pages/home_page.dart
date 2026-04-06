import 'package:flutter/material.dart';
import '../models/game_model.dart';
import '../main.dart';
import 'games_list_page.dart';

// ─── Tela Inicial ────────────────────────────────────────────────────────────
// Ponto de entrada visual do app. Exibe branding com animação de entrada
// e botão para navegar à lista de jogos.

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  // Lista compartilhada com GamesListPage (passa por referência)
  final List<Game> _games = [];

  // Controlador da animação de entrada (fade + slide)
  late final AnimationController _animController;
  late final Animation<double>   _fadeAnim;
  late final Animation<Offset>   _slideAnim;

  @override
  void initState() {
    super.initState();

    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOut,
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.12),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animController,
      curve: Curves.easeOutCubic,
    ));

    // Inicia a animação ao abrir a tela
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ── Navega para a lista de jogos ─────────────────────────────────
  void _openGamesList() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (_, anim, __) => GamesListPage(games: _games),
        transitionsBuilder: (_, anim, __, child) => FadeTransition(
          opacity: anim,
          child: child,
        ),
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // ── Fundo decorativo com gradiente radial ─────────────────
          _buildBackground(),

          // ── Conteúdo central com animação ─────────────────────────
          SafeArea(
            child: Center(
              child: FadeTransition(
                opacity: _fadeAnim,
                child: SlideTransition(
                  position: _slideAnim,
                  child: _buildContent(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ── Gradiente radial azulado no topo da tela ─────────────────────
  Widget _buildBackground() {
    return Positioned(
      top: -100,
      left: -80,
      child: Container(
        width: 400,
        height: 400,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.accent.withOpacity(0.12),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }

  // ── Coluna central: ícone, título, subtítulo e botão ─────────────
  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Ícone com brilho radial
          _buildIconGlow(),

          const SizedBox(height: 28),

          // Título principal
          const Text(
            'Catálogo de Jogos',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
              letterSpacing: -0.5,
              height: 1.15,
            ),
          ),

          const SizedBox(height: 10),

          // Subtítulo descritivo
          Text(
            'Organize, avalie e acompanhe\nseus jogos favoritos',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textSecondary,
              height: 1.55,
            ),
          ),

          const SizedBox(height: 48),

          // Botão de entrada
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _openGamesList,
              child: const Text('Ver Jogos'),
            ),
          ),
        ],
      ),
    );
  }

  // ── Ícone com halo de brilho decorativo ──────────────────────────
  Widget _buildIconGlow() {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: AppColors.accentGlow,
            blurRadius: 50,
            spreadRadius: 8,
          ),
        ],
      ),
      child: const Icon(
        Icons.sports_esports_rounded,
        size: 64,
        color: AppColors.accent,
      ),
    );
  }
}