// ─── Modelo de Dados: Jogo ───────────────────────────────────────────────────
// Representa um jogo no catálogo com seus atributos obrigatórios e opcionais.

class Game {
  // ── Campos obrigatórios ──────────────────────────────────────────
  final String name;
  final String genre;
  final String platform;

  // ── Campos opcionais ─────────────────────────────────────────────
  final int?    year;     // Ano de lançamento
  final String? status;  // Status de progresso do jogador
  final double? rating;  // Nota de 1 a 5 (nulo se "Quero jogar")

  const Game({
    required this.name,
    required this.genre,
    required this.platform,
    this.year,
    this.status,
    this.rating,
  });

  // ── Cria uma cópia do jogo com campos alterados ──────────────────
  // Útil para edição imutável sem necessidade de mutação direta.
  Game copyWith({
    String? name,
    String? genre,
    String? platform,
    int?    year,
    String? status,
    double? rating,
  }) {
    return Game(
      name:     name     ?? this.name,
      genre:    genre    ?? this.genre,
      platform: platform ?? this.platform,
      year:     year     ?? this.year,
      status:   status   ?? this.status,
      rating:   rating   ?? this.rating,
    );
  }

  // ── Verifica se o jogo ainda não foi jogado ──────────────────────
  bool get isWishlist => status == 'Quero jogar';

  // ── Retorna nota formatada como string ───────────────────────────
  String get formattedRating =>
      rating != null ? rating!.toStringAsFixed(0) : '—';

  @override
  String toString() => 'Game($name, $genre, $platform)';
}