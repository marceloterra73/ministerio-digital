import '../../../shared/models/content_models.dart';

/// Service para devocionais.
/// Por enquanto usa dados mock. Quando o Supabase estiver configurado,
/// troque os métodos por chamadas reais à API.
class DevocionalService {
  static final List<Map<String, dynamic>> _mockDevocionais = [
    {
      'id': '1',
      'titulo': 'A Paz que Excede o Entendimento',
      'resumo': 'Como encontrar paz mesmo em meio às tempestades da vida.',
      'conteudo_completo':
          'Filipenses 4:6-7 — "Não vos animeis com coisa alguma; antes, em tudo, sejam conhecidas, perante Deus, as vossas petições, em oração e súplica, com ações de graças. E a paz de Deus, que excede todo o entendimento, guardará os vossos corações e os vossos pensamentos, em Cristo Jesus."\n\nViver em um mundo de incertezas pode ser desanimador. Preocupações com a saúde, o trabalho, a família e o futuro nos cercam diariamente. Mas Deus nos convida a trocar as nossas preocupações por oração.\n\nA paz que Deus oferece não depende das circunstâncias. Ela não é lógica — por isso "excede todo o entendimento". É uma paz sobrenatural que guarda o coração e a mente.\n\n**Como aplicar:**\n\n1. **Identifique suas preocupações.** Anote tudo o que está pesando no seu coração.\n\n2. **Transforme em oração.** Em vez de repensar os problemas, apresente-os a Deus com gratidão.\n\n3. **Confie no resultado.** Deus ouviu. Agora escolha descansar na Sua paz.\n\n4. **Repita diariamente.** Esta não é uma receita de uma vez — é um estilo de vida.\n\n**Oração do dia:**\nSenhor, hoje eu entrego todas as minhas preocupações nas Tuas mãos. Em troca, recebo a Tua paz que excede todo o entendimento. Guarda o meu coração e a minha mente em Cristo Jesus. Amém.',
      'tema': 'paz',
      'autor': 'Ministério Digital',
      'data': '2025-01-15T00:00:00Z',
      'versiculo_chave': {
        'livro': 'Filipenses',
        'capitulo': 4,
        'versiculo': 7,
      },
      'duracao_minutos': 5,
      'ativo': true,
      'created_at': '2025-01-15T00:00:00Z',
    },
    {
      'id': '2',
      'titulo': 'Confiança nos Tempos Difíceis',
      'resumo': 'Por que podemos confiar em Deus mesmo quando não entendemos.',
      'conteudo_completo':
          'Provérbios 3:5-6 — "Confia no Senhor de todo o teu coração e não te estribes no teu próprio entendimento. Reconhece-o em todos os teus caminhos, e ele endireitará as tuas veredas."\n\nHá momentos na vida em que não entendemos o que está acontecendo. Perdas, frustrações, portas fechadas — tudo parece não fazer sentido. Mas Deus pede que confiemos Nele, mesmo quando não vemos o caminho.\n\nA confiança não é ausência de dúvida. É escolher acreditar que Deus é bom, mesmo quando as circunstâncias não parecem boas.\n\n**Como aplicar:**\n\n1. **Respire e lembre-se de quem Deus é.** Ele é-fiel, amoroso e todopoderoso.\n\n2. **Memorize Sua Palavra.** Versículos como este são âncoras para os momentos difíceis.\n\n3. **Não tente entender tudo.** Nem sempre teremos respostas agora. E está tudo bem.\n\n4. **Agradeça.** Mesmo no meio da tempestade, há coisas pelas quais ser grato.\n\n5. **Espere com esperança.** Deus está trabalhando mesmo quando não vemos.\n\n**Oração do dia:**\nSenhor, eu escolho confiar em Ti hoje. Mesmo quando não entendo os Teus caminhos, eu acredito que Tu és bom. Endireita os meus passos e me dá paz para esperar. Amém.',
      'tema': 'confianca',
      'autor': 'Ministério Digital',
      'data': '2025-01-16T00:00:00Z',
      'versiculo_chave': {
        'livro': 'Provérbios',
        'capitulo': 3,
        'versiculo': 5,
      },
      'duracao_minutos': 5,
      'ativo': true,
      'created_at': '2025-01-16T00:00:00Z',
    },
    {
      'id': '3',
      'titulo': 'O Amor que Nunca Falha',
      'resumo': 'Refletindo sobre o amor incondicional de Deus.',
      'conteudo_completo':
          '1 Coríntios 13:4-7 — "O amor é sofredor, é benigno; o amor não é invejoso; o amor não trata com leviandade, não se ensoberbece, não se porta com indecência, não busca os seus interesses, não se irrita, não suspeita mal; não se alegra com a injustiça, mas se alegra com a verdade; tudo sofre, tudo crê, tudo espera, tudo suporta."\n\nEste é o famoso "hino ao amor" da Bíblia. Mas ele não é apenas para casais — é a descrição do amor de Deus por nós.\n\nPense: Deus é sofredor com você. Deus é benigno. Deus não te trata com leviandade. Deus não se irrita com você. Deus nunca desiste de você.\n\n**Como aplicar:**\n\n1. **Leia devagar.** Substitua "amor" por "Deus" e veja como soa.\n\n2. **Receba o amor de Deus.** Muitos têm dificuldade em aceitar amor gratuito. Peça graça para receber.\n\n3. **Amo os outros como Deus te ama.** Não com perfeição, mas com intenção.\n\n4. **Ame a si mesmo.** Você é amado por Deus — isso te dá valor.\n\n**Oração do dia:**\nPai, obrigado por um amor que nunca falha. Ensina-me a receber o Teu amor e a amar os outros da mesma forma. Em nome de Jesus. Amém.',
      'tema': 'amor',
      'autor': 'Ministério Digital',
      'data': '2025-01-17T00:00:00Z',
      'versiculo_chave': {
        'livro': '1 Coríntios',
        'capitulo': 13,
        'versiculo': 4,
      },
      'duracao_minutos': 6,
      'ativo': true,
      'created_at': '2025-01-17T00:00:00Z',
    },
    {
      'id': '4',
      'titulo': 'Renovando a Fé',
      'resumo': 'Como acender novamente a chama da fé quando ela esfria.',
      'conteudo_completo':
          'Hebreus 11:1 — "Ora, a fé é a certeza daquilo que esperamos e a prova das coisas que não vemos."\n\nA fé pode esfriar. A rotina, as dificuldades, as decepções — tudo isso pode apagar a chama que um dia ardia forte. Mas Deus não nos abandona quando nossa fé enfraquece.\n\nA fé não é perfeição. É persistência. É continuar caminhando mesmo quando o caminho está escuro.\n\n**Como aplicar:**\n\n1. **Volte ao básico.** Lembre-se do dia em que você aceitou a Jesus. O que aconteceu?\n\n2. **Leia a Palavra.** Fé vem pelo ouvir (ler) a Palavra de Deus.\n\n3. **Ore mesmo sem sentir.** A oração não depende de emoções — depende de fé.\n\n4. **Converse com alguém de fé.** A comunidade fortalece.\n\n5. **Agradeça.** Gratidão reacende a fé.\n\n**Oração do dia:**\nSenhor, renova a minha fé. Accende de novo a chama que estava apagando. Eu quero te buscar com todo o meu coração. Em nome de Jesus. Amém.',
      'tema': 'fe',
      'autor': 'Ministério Digital',
      'data': '2025-01-18T00:00:00Z',
      'versiculo_chave': {
        'livro': 'Hebreus',
        'capitulo': 11,
        'versiculo': 1,
      },
      'duracao_minutos': 5,
      'ativo': true,
      'created_at': '2025-01-18T00:00:00Z',
    },
    {
      'id': '5',
      'titulo': 'Perdão: A Chave da Liberdade',
      'resumo': 'Por que perdoar é essencial para a nossa liberdade espiritual.',
      'conteudo_completo':
          'Efésios 4:31-32 — "Desapartai de vós toda amargura, e ira, e gritaria, e blasfêmias, e toda a malícia. Antes, sede bondosos para com uns aos outros, misericordiosos, perdoando-vos uns aos outros, como também Deus vos perdoou em Cristo."\n\nO perdão não é um sentimento — é uma decisão. É escolher soltar o que prende o coração.\n\nMuitas vezes, quem mais precisa perdoar sou eu mesmo. A culpa, a vergonha, os erros do passado — tudo isso pode ser colocado nos pés da cruz.\n\n**Como aplicar:**\n\n1. **Identifique quem precisa perdoar.** Inclua a si mesmo na lista.\n\n2. **Ore pela pessoa.** É difícil odiar alguém por quem você ora.\n\n3. **Solte a dor.** Perdoar não significa aceitar o errado — significa não carregar mais.\n\n4. **Repita quando necessário.** Perdoar é um processo.\n\n5. **Lembre-se de quanto Deus te perdoou.** Isso muda tudo.\n\n**Oração do dia:**\nPai, ajuda-me a perdoar. Tira do meu coração toda amargura e ressentimento. Eu escolho a liberdade que vem do perdão. Em nome de Jesus. Amém.',
      'tema': 'perdao',
      'autor': 'Ministério Digital',
      'data': '2025-01-19T00:00:00Z',
      'versiculo_chave': {
        'livro': 'Efésios',
        'capitulo': 4,
        'versiculo': 32,
      },
      'duracao_minutos': 5,
      'ativo': true,
      'created_at': '2025-01-19T00:00:00Z',
    },
    {
      'id': '6',
      'titulo': 'Propósito em Cada Dia',
      'resumo': 'Como viver com propósito mesmo nos pequenos momentos.',
      'conteudo_completo':
          'Efésios 2:10 — "Porque somos feitura de Deus, criados em Cristo Jesus para boas obras, as quais Deus preparou de antemão, para que andássemos nelas."\n\nVocê não é um acidente. Deus te criou com propósito. Cada dia é uma oportunidade de viver algo que Ele preparou para você.\n\nO propósito nem sempre é grandioso aos olhos do mundo. Às vezes, é ser um bom pai, uma boa mãe, um bom amigo, um bom funcionário. É fazer o bem onde você está.\n\n**Como aplicar:**\n\n1. **Comece o dia com Deus.** Pergunte: "Senhor, o que Tu tens para mim hoje?"\n\n2. **Procure servir.** O propósito sempre envolve os outros.\n\n3. **Não despreze o pequeno.** Grandes coisas começam em lugares pequenos.\n\n4. **Seja fiel no pouco.** Deus confia mais quando somos fiéis no pequeno.\n\n5. **Agradeça pelo dia.** Cada dia é um presente.\n\n**Oração do dia:**\nSenhor, mostra-me o Teu propósito para a minha vida hoje. Que eu seja fiel nos pequenos momentos e uma bênção onde eu estiver. Em nome de Jesus. Amém.',
      'tema': 'proposito',
      'autor': 'Ministério Digital',
      'data': '2025-01-20T00:00:00Z',
      'versiculo_chave': {
        'livro': 'Efésios',
        'capitulo': 2,
        'versiculo': 10,
      },
      'duracao_minutos': 4,
      'ativo': true,
      'created_at': '2025-01-20T00:00:00Z',
    },
  ];

  Future<List<Devocional>> getAllDevocionais() async {
    return _mockDevocionais.map((json) => Devocional.fromJson(json)).toList();
  }

  Future<List<Devocional>> getDevocionaisByTema(String tema) async {
    final filtered =
        _mockDevocionais.where((d) => d['tema'] == tema).toList();
    return filtered.map((json) => Devocional.fromJson(json)).toList();
  }

  Future<Devocional?> getDevocionalById(String id) async {
    final found = _mockDevocionais.firstWhere(
      (d) => d['id'] == id,
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return Devocional.fromJson(found);
  }

  Future<List<Devocional>> searchDevocionais(String query) async {
    final filtered = _mockDevocionais.where((d) {
      final titulo = (d['titulo'] as String).toLowerCase();
      final resumo = (d['resumo'] as String).toLowerCase();
      final conteudo = (d['conteudo_completo'] as String).toLowerCase();
      return titulo.contains(query.toLowerCase()) ||
          resumo.contains(query.toLowerCase()) ||
          conteudo.contains(query.toLowerCase());
    }).toList();
    return filtered.map((json) => Devocional.fromJson(json)).toList();
  }

  Future<Devocional?> getDevocionalByDate(String date) async {
    final found = _mockDevocionais.firstWhere(
      (d) => (d['data'] as String).startsWith(date),
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return Devocional.fromJson(found);
  }
}
