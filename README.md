# 🎮 Catálogo de Jogos

Aplicativo mobile desenvolvido em **Flutter/Dart** como atividade prática de desenvolvimento mobile, com foco em navegação entre telas, gerenciamento de estado e boas práticas de estruturação de projetos.

---

## 📱 Sobre o aplicativo

O **Catálogo de Jogos** é um app pessoal onde o usuário pode registrar e organizar os jogos que está jogando, já zerou ou pretende jogar. Para cada jogo é possível cadastrar informações como gênero, plataforma, ano de lançamento, status de progresso e nota de avaliação.

Todos os dados são mantidos em memória durante a sessão — sem dependência de banco de dados externo, mantendo o escopo adequado para o projeto acadêmico.

---

## 🚀 Funcionalidades

| Funcionalidade | Descrição |
|---|---|
| 📋 Listar jogos | Exibe todos os jogos cadastrados em cards com nome, gênero e plataforma |
| ➕ Adicionar jogo | Formulário completo com validação para cadastrar um novo jogo |
| ✏️ Editar jogo | Reabre o formulário pré-preenchido com os dados do jogo selecionado |
| 🗑️ Excluir jogo | Remove o jogo da lista com confirmação antes de deletar |
| 🔍 Ver detalhes | Tela dedicada com todas as informações do jogo, incluindo estrelas de avaliação e chip de status colorido |

---

## 🧩 Dados de cada jogo

| Campo | Tipo | Obrigatório |
|---|---|---|
| Nome | Texto | ✅ Sim |
| Gênero | Seleção (dropdown) | ✅ Sim |
| Plataforma | Seleção (dropdown) | ✅ Sim |
| Ano de lançamento | Numérico (4 dígitos) | ❌ Opcional |
| Status | Seleção (dropdown) | ❌ Opcional |
| Nota (1–5) | Slider | ❌ Apenas para jogos jogados |

> A nota é ocultada automaticamente quando o status é **"Quero jogar"**, pois não faz sentido avaliar um jogo não jogado.

---

## 🖥️ Estrutura do projeto

```
lib/
│
├── models/
│   └── game_model.dart        # Modelo de dados do jogo (Game)
│
├── pages/
│   ├── home_page.dart         # Tela inicial com apresentação do app
│   ├── games_list_page.dart   # Lista de jogos cadastrados (CRUD)
│   ├── game_form_page.dart    # Formulário de criação e edição
│   └── game_detail_page.dart  # Tela de detalhes de um jogo
│
└── main.dart                  # Ponto de entrada, tema global e AppColors
```

---

## 🗺️ Fluxo de navegação

```
HomePage
   └──▶ GamesListPage
            ├──▶ GameDetailPage   (tap no card)
            └──▶ GameFormPage     (FAB para novo / ícone lápis para editar)
                     └── retorna o Game via Navigator.pop()
```

A navegação usa `Navigator.push` com retorno de dados via `Navigator.pop(context, game)`, permitindo que a lista atualize em tempo real após adicionar ou editar um jogo sem precisar recarregar a tela.

---

## 📐 Arquitetura e decisões técnicas

### Widgets Stateful vs Stateless

O projeto aplica corretamente os dois tipos de widget conforme a necessidade de cada tela:

**Stateful** — telas que gerenciam estado mutável:
- `HomePage` — controla a animação de entrada
- `GamesListPage` — mantém e atualiza a lista de jogos
- `GameFormPage` — controla os campos do formulário, dropdowns e slider

**Stateless** — componentes sem estado próprio:
- `GameDetailPage` — apenas exibe dados recebidos por parâmetro
- `_GameCard`, `_StatusChip`, `_InfoTile`, `_SectionLabel` — widgets auxiliares de UI

### Gerenciamento de estado

O estado da lista é gerenciado localmente em `GamesListPage` via `setState`. As operações de CRUD disparam uma reconstrução do widget, atualizando a interface imediatamente:

```dart
void _addGame(Game game)         => setState(() => _games.add(game));
void _updateGame(int i, Game g)  => setState(() => _games[i] = g);
void _deleteGame(int i)          => setState(() => _games.removeAt(i));
```

### Modelo de dados

O modelo `Game` usa campos `final` para imutabilidade e oferece o método `copyWith()` para edição sem mutação direta, seguindo boas práticas de Dart:

```dart
class Game {
  final String name;
  final String genre;
  final String platform;
  final int?    year;
  final String? status;
  final double? rating;
}
```

### Validação de formulário

O formulário usa `Form` com `GlobalKey<FormState>` para validação nativa do Flutter. Campos com regras específicas:
- **Nome**: obrigatório, não pode ser vazio
- **Ano**: opcional, mas se preenchido deve ser entre 1970 e 2100
- **Gênero e Plataforma**: obrigatórios via verificação manual antes de salvar

---

## 🎨 Interface

O app usa um **tema escuro personalizado** definido globalmente em `main.dart`, com todas as cores centralizadas na classe `AppColors` para consistência visual em todas as telas.

**Paleta de cores:**

| Elemento | Cor |
|---|---|
| Fundo | `#060F18` — azul muito escuro |
| Cards | `#0D1E2D` — azul escuro |
| Destaque | `#00B4FF` — ciano |
| Texto principal | `#E8EEF4` — branco suave |
| Texto secundário | `#6B8A9E` — cinza azulado |
| Nota (estrelas) | `#FFAA3C` — âmbar |

**Destaques de UX:**
- Animação de entrada na `HomePage` (fade + slide)
- Estado vazio na lista com orientação ao usuário
- Diálogo de confirmação antes de excluir um jogo
- Chips de status com cores por categoria (verde = Jogando, azul = Zerado, âmbar = Quero jogar)
- Estrelas visuais na tela de detalhes
- Badge com contagem de jogos na AppBar

---

## 📚 Conceitos aplicados

- `StatefulWidget` e `StatelessWidget` com uso adequado por contexto
- Navegação com `Navigator.push` / `Navigator.pop` e retorno de dados tipados
- Passagem de dados entre telas via construtor
- Gerenciamento de estado com `setState`
- `ListView.builder` para renderização eficiente de listas
- `Form` + `GlobalKey` para validação de formulários
- `TextEditingController` com `dispose()` correto (sem memory leak)
- `AnimationController` com `SingleTickerProviderStateMixin`
- Widgets auxiliares reutilizáveis para composição de UI

---

## ⚙️ Tecnologias

- [Flutter](https://flutter.dev/) — framework de UI multiplataforma
- [Dart](https://dart.dev/) — linguagem de programação

---

## ▶️ Como executar

**Pré-requisitos:** Flutter SDK instalado ([guia oficial](https://docs.flutter.dev/get-started/install))

```bash
# 1. Clone o repositório
git clone https://github.com/nicolasthomee/catalogo-jogos

# 2. Acesse a pasta
cd catalogo-jogos

# 3. Instale as dependências
flutter pub get

# 4. Execute o projeto
flutter run
```

---

## 🎓 Contexto acadêmico

Projeto desenvolvido como atividade prática da disciplina de Desenvolvimento de Sistemas para WEB/Mobile IV, com objetivo de aplicar conceitos fundamentais do Flutter: estruturação de projeto, navegação entre telas, uso correto de widgets Stateful e Stateless, manipulação de estado e construção de interfaces responsivas.

---

## 👨‍💻 Autor

**Nicolas**  
Estudante de Engenharia de Software
