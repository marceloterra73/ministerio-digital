import '../../../shared/models/content_models.dart';

/// Service para orações.
/// Por enquanto usa dados mock. Quando o Supabase estiver configurado,
/// troque os métodos por chamadas reais à API.
class OracaoService {
  // =============================================
  // DADOS MOCK — substituir por Supabase
  // =============================================

  static final List<Map<String, dynamic>> _mockOracoes = [
    {
      'id': '1',
      'titulo': 'Oração pela Família',
      'texto': 'Senhor, Pai celestial, neste momento eu me apresento diante da Tua presença para orar pela minha família.\n\nQue o Teu amor envolva cada membro da minha casa. Guarda nossos corações, nossas mentes e nossos caminhos.\n\nDá-nos sabedoria para lidar com os desafios do dia a dia, e que a Tua paz reine em nosso lar.\n\nProtege-nos de todo mal, e que a Tua mão poderosa nos cubra em todos os momentos.\n\nEm nome de Jesus, eu creio e declaro que a minha família é abençoada e protegida. Amém.',
      'tema': 'familia',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': 'Salmos', 'capitulo': 127, 'versiculo': 1},
        {'livro': 'Josué', 'capitulo': 24, 'versiculo': 15},
      ],
      'ativo': true,
      'created_at': '2025-01-01T00:00:00Z',
    },
    {
      'id': '2',
      'titulo': 'Oração de Cura e Saúde',
      'texto': 'Deus de toda cura, Senhor dos remédios, venho clamar pelo Teu toque de saúde sobre esta pessoa.\n\nTu és o nosso médico, Tu és a nossa saúde. Nada é impossível para Ti.\n\nToca o corpo, restaura a saúde, fortalece a fé. Que cada célula, cada órgão, cada tecido seja renovado pelo Teu poder.\n\nEu creio na Tua capacidade de curar. Que a Tua vontade seja feita.\n\nEm nome de Jesus, eu declaro saúde e vida. Amém.',
      'tema': 'saude',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': 'Jeremias', 'capitulo': 30, 'versiculo': 17},
        {'livro': 'Isaías', 'capitulo': 53, 'versiculo': 5},
      ],
      'ativo': true,
      'created_at': '2025-01-02T00:00:00Z',
    },
    {
      'id': '3',
      'titulo': 'Oração contra a Ansiedade',
      'texto': 'Senhor, estou ansioso e o meu coração está apertado. Venho entregar nas Tuas mãos tudo o que me preocupa.\n\nTu disseste: "Não vos animeis, nem vos inquieteis" (Mateus 6:34). Então eu escolho confiar em Ti.\n\nToma o controle da minha mente. Afasta os pensamentos negativos. Preenche-me com a Tua paz que excede todo entendimento.\n\nEu entrego minha família, meu trabalho, minha saúde, meu futuro. Tudo nas Tuas mãos.\n\nObrigado porque és fiel. Em nome de Jesus. Amém.',
      'tema': 'ansiedade',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': 'Filipenses', 'capitulo': 4, 'versiculo': 6},
        {'livro': 'Mateus', 'capitulo': 6, 'versiculo': 34},
      ],
      'ativo': true,
      'created_at': '2025-01-03T00:00:00Z',
    },
    {
      'id': '4',
      'titulo': 'Oração pelo Casamento',
      'texto': 'Pai celestial, abençoai o nosso casamento. Que o Teu amor seja o centro da nossa união.\n\nDai-nos paciência um com o outro, sabedoria para resolver conflitos, e humildade parapedir desculpas quando necessário.\n\nQue a comunicação entre nós seja sempre honesta e respeitosa. Que o respeito e a admiração cresçam a cada dia.\n\nProtege o nosso lar de toda tentação e divisão. Que sejamos uma só carne, unidos em propósito e em fé.\n\nEm nome de Jesus, amém.',
      'tema': 'casamento',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': 'Efésios', 'capitulo': 5, 'versiculo': 25},
        {'livro': 'Eclesiastes', 'capitulo': 4, 'versiculo': 12},
      ],
      'ativo': true,
      'created_at': '2025-01-04T00:00:00Z',
    },
    {
      'id': '5',
      'titulo': 'Oração de Proteção',
      'texto': 'Senhor, Tu és o meu escudo e o meu refúgio. Venho clamar pela Tua proteção.\n\nCobre-me com as Tuas asas. Guarda meus passos, protege minha família,了我的 casa.\n\nAfasta todo mal, toda armadilha do inimigo. Que os anjos do Senhor acampem ao nosso redor.\n\nEu declaro que nenhum mal nosará, nenhuma praga chegará à nossa habitação.\n\nPois Tu és o nosso Deus protetor. Em nome de Jesus. Amém.',
      'tema': 'medo',
      'audio_url': null,
      'tempo_estimado_min': 2,
      'versiculos_relacionados': [
        {'livro': 'Salmos', 'capitulo': 91, 'versiculo': 4},
        {'livro': 'Salmos', 'capitulo': 91, 'versiculo': 10},
      ],
      'ativo': true,
      'created_at': '2025-01-05T00:00:00Z',
    },
    {
      'id': '6',
      'titulo': 'Oração de Libertação',
      'texto': 'Em nome de Jesus, eu declaro liberdade sobre a minha vida.\n\nTodo laço de pecado, toda escravidão, toda corrente que me prende — quebrada pelo poder do sangue de Jesus.\n\nSenhor, liberta minha mente dos pensamentos de escravidão. Libertas minha boca das palavras negativas. Libertas meu coração do apego ao pecado.\n\nEu não fui feito para ser escravo. Fui feito para ser livre. E a Tua Palavra diz: "Se o Filho vos libertar, verdadeiramente livres sereis."\n\nRecebo a minha libertação agora. Em nome de Jesus. Amém.',
      'tema': 'libertacao',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': 'João', 'capitulo': 8, 'versiculo': 36},
        {'livro': '2 Coríntios', 'capitulo': 3, 'versiculo': 17},
      ],
      'ativo': true,
      'created_at': '2025-01-06T00:00:00Z',
    },
    {
      'id': '7',
      'titulo': 'Oração pelo Trabalho',
      'texto': 'Senhor, eu Te agradeço pelo trabalho que tens colocado nas minhas mãos.\n\nDá-me sabedoria para executar minhas tarefas com excelência. Que eu seja um instrumento de bênção no meu ambiente de trabalho.\n\nAbre portas de oportunidade. Que as minhas habilidades sejam reconhecidas e valorizadas.\n\nSe estou sem trabalho, Senhor, abre uma porta nova. Preparation algo melhor do que eu possso imaginar.\n\nEu confio em Ti para o meu sustento e o da minha família. Em nome de Jesus. Amém.',
      'tema': 'trabalho',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': 'Colossenses', 'capitulo': 3, 'versiculo': 23},
        {'livro': 'Filipenses', 'capitulo': 4, 'versiculo': 19},
      ],
      'ativo': true,
      'created_at': '2025-01-07T00:00:00Z',
    },
    {
      'id': '8',
      'titulo': 'Oração de Gratidão',
      'texto': 'Pai, hoje eu venho apenas agradecer.\n\nObrigado pelo ar que respiro, pela água que bebo, pelo pão que como.\n\nObrigado pelo teu amor que não tem fim, pela tua graça que se renova a cada manhã.\n\nObrigado pela minha família, pelo meu trabalho, pela minha saúde.\n\nMesmo nos momentos difíceis, eu escolho agradecer, porque sei que Tu estás no controle de tudo.\n\nA Ti seja toda a glória e todo o louvor. Em nome de Jesus. Amém.',
      'tema': 'gratidao',
      'audio_url': null,
      'tempo_estimado_min': 2,
      'versiculos_relacionados': [
        {'livro': '1 Tessalonicenses', 'capitulo': 5, 'versiculo': 18},
        {'livro': 'Salmos', 'capitulo': 100, 'versiculo': 4},
      ],
      'ativo': true,
      'created_at': '2025-01-08T00:00:00Z',
    },
    {
      'id': '9',
      'titulo': 'Oração pelo Perdão',
      'texto': 'Senhor, este é um pedido difícil, mas eu preciso da Tua força para perdoar.\n\nPerdoa as pessoas que me magoaram, que me traíram, que me decepcionaram.\n\nEu não consigo perdoar com as minhas próprias forças. Preciso do Teu amor fluindo através de mim.\n\nLiberta o meu coração do ódio, da amargura, do ressentimento.\n\nAssim como Tu me perdoaste, também eu perdoo. Em nome de Jesus. Amém.',
      'tema': 'perdao',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': 'Efésios', 'capitulo': 4, 'versiculo': 32},
        {'livro': 'Colossenses', 'capitulo': 3, 'versiculo': 13},
      ],
      'ativo': true,
      'created_at': '2025-01-09T00:00:00Z',
    },
    {
      'id': '10',
      'titulo': 'Oração para os Jovens',
      'texto': 'Senhor, abençoa esta geração jovem. Que eles encontrem o Teu propósito para as suas vidas.\n\nProtege-os das armadilhas do mundo. Guarda seus corações, suas mentes, seus olhos.\n\nDá-lhes sabedoria para escolher os amigos certos, a coragem para resistir à pressão, e a fé para te seguir todos os dias da vida.\n\nQue sejam jovens de caráter, de integridade, de fé inabalável.\n\nEm nome de Jesus, amém.',
      'tema': 'jovens',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': '1 Timóteo', 'capitulo': 4, 'versiculo': 12},
        {'livro': 'Provérbios', 'capitulo': 22, 'versiculo': 6},
      ],
      'ativo': true,
      'created_at': '2025-01-10T00:00:00Z',
    },
    {
      'id': '11',
      'titulo': 'Oração pelas Crianças',
      'texto': 'Pai, abençoa estas crianças. Que elas cresçam no Teu amor e na Tua sabedoria.\n\nProtege-as de todo mal, de toda injustiça, de todo perigo.\n\nDá aos pais sabedoria para criá-las no caminho certo. Que o Teu amor seja o primeiro exemplo que elas recebam.\n\nQue sejam crianças felizes, saudáveis, criativas e cheias de fé.\n\nEm nome de Jesus, amém.',
      'tema': 'criancas',
      'audio_url': null,
      'tempo_estimado_min': 2,
      'versiculos_relacionados': [
        {'livro': 'Mateus', 'capitulo': 19, 'versiculo': 14},
        {'livro': 'Salmos', 'capitulo': 127, 'versiculo': 3},
      ],
      'ativo': true,
      'created_at': '2025-01-11T00:00:00Z',
    },
    {
      'id': '12',
      'titulo': 'Oração de Prosperidade',
      'texto': 'Senhor, eu creio que Tu queres que eu prospere e esteja em saúde, assim como a minha alma prospera.\n\nAbre as portas de finanziamento. Dá-me sabedoria para administrar os Teus recursos.\n\nQue eu não apenas tenha o suficiente para mim, mas que eu possa ser uma bênção para os outros.\n\nQue a prosperidade não se torne um ídolo, mas uma ferramenta para o Teu Reino.\n\nEm nome de Jesus. Amém.',
      'tema': 'prosperidade',
      'audio_url': null,
      'tempo_estimado_min': 3,
      'versiculos_relacionados': [
        {'livro': '3 João', 'capitulo': 1, 'versiculo': 2},
        {'livro': 'Malaquias', 'capitulo': 3, 'versiculo': 10},
      ],
      'ativo': true,
      'created_at': '2025-01-12T00:00:00Z',
    },
  ];

  // =============================================
  // MÉTODOS PÚBLICOS
  // =============================================

  Future<List<Oracao>> getAllOracoes() async {
    // TODO: Substituir por Supabase
    // final response = await supabase.from('oracoes').select();
    return _mockOracoes.map((json) => Oracao.fromJson(json)).toList();
  }

  Future<List<Oracao>> getOracoesByTema(String tema) async {
    // TODO: Substituir por Supabase
    final filtered = _mockOracoes.where((o) => o['tema'] == tema).toList();
    return filtered.map((json) => Oracao.fromJson(json)).toList();
  }

  Future<Oracao?> getOracaoById(String id) async {
    // TODO: Substituir por Supabase
    final found = _mockOracoes.firstWhere(
      (o) => o['id'] == id,
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return Oracao.fromJson(found);
  }

  Future<void> adicionarOracao(Map<String, dynamic> oracao) async {
    _mockOracoes.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'titulo': oracao['titulo'],
      'texto': oracao['texto'] ?? '',
      'tema': oracao['tema'] ?? 'outro',
      'audio_url': null,
      'tempo_estimado_min': null,
      'versiculos_relacionados': [],
      'ativo': true,
      'created_at': DateTime.now().toIso8601String(),
    });
  }

  Future<List<Oracao>> searchOracoes(String query) async {
    final filtered = _mockOracoes.where((o) {
      final titulo = (o['titulo'] as String).toLowerCase();
      final texto = (o['texto'] as String).toLowerCase();
      return titulo.contains(query.toLowerCase()) ||
          texto.contains(query.toLowerCase());
    }).toList();
    return filtered.map((json) => Oracao.fromJson(json)).toList();
  }
}
