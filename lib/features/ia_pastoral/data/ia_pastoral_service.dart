class ChatMessage {
  final String id;
  final String texto;
  final bool isUser;
  final DateTime timestamp;

  const ChatMessage({
    required this.id,
    required this.texto,
    required this.isUser,
    required this.timestamp,
  });
}

class IaPastoralService {
  static const Map<String, List<String>> _respostasPorTema = {
    'ansiedade': [
      'Entendo que a ansiedade pode ser algo muito difícil. A Bíblia nos diz em Filipenses 4:6-7: "Não vos animeis com coisa alguma; antes, em tudo, sejam conhecidas, perante Deus, as vossas petições, em oração e súplica, com ações de graças. E a paz de Deus, que excede todo o entendimento, guardará os vossos corações e os vossos pensamentos, em Cristo Jesus."\n\nQue tal fazer uma oração agora, entregando suas preocupações a Deus?',
      'A ansiedade muitas vezes vem do medo do desconhecido. Mas lembre-se: Deus já conhece amanhã. Ele é o mesmo ontem, hoje e sempre. Confie Nele.',
    ],
    'medo': [
      'O medo é uma emoção natural, mas Deus não nos deu espírito de medo, mas de fortaleza, amor e equilíbrio (2 Timóteo 1:7).\n\nO que está causando medo na sua vida? Vamos orar juntos?',
      'Salmos 91 é um dos melhores capítulos para ler quando temos medo. "Aquele que habita no esconderijo do Altíssimo, à sombra do Onipotente descansará." Que tal ler agora?',
    ],
    'tristeza': [
      'Sinto muito que esteja passando por isso. A Bíblia diz que "o Senhor está perto dos que têm o coração quebrantado" (Salmos 34:18).\n\nDeus está perto de você agora mesmo. Ele não abandona os Seus.',
      'A tristeza faz parte da vida, mas não precisa ser permanente. Salmo 30:5 diz: "Porque dura um momento a sua ira; mas a sua graça dura toda a vida. No entardecer haverá choro, e de manhã haverá alegria."',
    ],
    'casamento': [
      'O casamento é uma aliança sagrada. Efésios 5:25 nos diz: "Maridos, amai a vossa mulher, como também Cristo amou a igreja e a si mesmo se entregou por ela."\n\nQue tal reservar um tempo hoje para orar pelo seu cônjuge?',
      'Comunicação é a chave. Quando temos dificuldades, a oração pode restaurar o que parece perdido. "Tudo posso naquele que me fortalece" (Filipenses 4:13).',
    ],
    'perdao': [
      'Perdoar é um dos atos mais difíceis, mas também mais libertadores. Mateus 6:14 diz: "Se perdoardes aos homens as suas ofensas, também o vosso Pai celestial vos perdoará."\n\nPerdoar não significa aceitar o errado, significa não carregar mais esse peso.',
      'O perdão é um processo. Não precisa ser de uma vez. Peça a Deus força para perdoar, passo a passo.',
    ],
    'gratidao': [
      'A gratidão transforma a nossa perspectiva! 1 Tessalonicenses 5:18 diz: "Em tudo dai graças, porque esta é a vontade de Deus em Cristo Jesus para convosco."\n\nPense em 3 coisas pelas quais você é grato agora.',
      'Ser grato mesmo nas dificuldades é um ato de fé. Quando agradecemos, reconhecemos que Deus está no controle.',
    ],
    'oração': [
      'A oração é a nossa comunicação com Deus. 1 Tessalonicenses 5:17 diz: "Orai sem cessar."\n\nNão precisa de palavras perfeitas. Fale com Deus como fala com um amigo. Ele ouve.',
      'Jesus nos ensinou a orar em Mateus 6:9-13. O que mais você gostaria de pedir a Deus agora?',
    ],
    'biblia': [
      'A Palavra de Deus é viva e eficaz! Hebreus 4:12 diz: "Porque a palavra de Deus é viva, e eficaz, e mais cortante do que qualquer espada de dois gumes."\n\nQue tal ler um capítulo hoje? O Salmo 23 é um bom começo.',
      'A Bíblia tem respostas para todas as situações da vida. Que versículo você está precisando ouvir hoje?',
    ],
    'amor': [
      'Deus é amor (1 João 4:8). O amor verdadeiro vem Dele. Quando amamos, refletimos o caráter de Deus.\n\n1 Coríntios 13 descreve o amor perfeito: paciente, bondoso, não invejoso, não orgulhoso.',
      'A maior demonstração de amor foi Jesus morrer por nós na cruz. "Ninguém tem maior amor do que este: que alguém dá a sua vida pelos seus amigos" (João 15:13).',
    ],
    'familia': [
      'A família é um presente de Deus. Josué 24:15 diz: "Eu e a minha casa serviremos ao Senhor."\n\nOre pela sua família todos os dias. Deus pode tocar em cada membro.',
      'Cuidar da família é um chamado. Peça sabedoria para ser um bom pai, mãe, filho ou cônjuge.',
    ],
  };

  static const String _respostaPadrao =
      'Obrigado por compartilhar comigo. Infelizmente, não tenho uma resposta específica para isso, mas posso orar por você.\n\nSenhor, abençoa este filho(a) Teu. Que o Teu amor, a Tua paz e a Tua direção estejam sobre a vida dele(a). Em nome de Jesus. Amém.\n\nSe precisar de aconselhamento mais aprofundado, procure o pastoral da sua igreja. Estou aqui para orar com você.';

  static const String _boasVindas =
      'Olá! Sou o Assistente Pastoral da sua igreja. 🙏\n\nEstou aqui para orar com você, compartilhar versículos e oferecer uma palavra de conforto.\n\nComo posso te ajudar hoje?';

  String get boasVindas => _boasVindas;

  Future<ChatMessage> sendMessage(String texto) async {
    await Future.delayed(const Duration(seconds: 1));

    final resposta = _gerarResposta(texto);

    return ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      texto: resposta,
      isUser: false,
      timestamp: DateTime.now(),
    );
  }

  String _gerarResposta(String mensagem) {
    final mensagemLower = mensagem.toLowerCase();

    for (final entry in _respostasPorTema.entries) {
      if (mensagemLower.contains(entry.key)) {
        final respostas = entry.value;
        return respostas[DateTime.now().millisecond % respostas.length];
      }
    }

    if (mensagemLower.contains('obrigado') ||
        mensagemLower.contains('agradeço') ||
        mensagemLower.contains('graças')) {
      return 'De nada! É um prazer orar com você. "Em tudo dai graças" (1 Tessalonicenses 5:18). Volte sempre que precisar!';
    }

    if (mensagemLower.contains('bom dia') ||
        mensagemLower.contains('boa tarde') ||
        mensagemLower.contains('boa noite')) {
      return 'Que a paz do Senhor esteja com você hoje! 🙏\n\nLamentações 3:22-23 diz: "As misericórdias do Senhor são novas toda a manhã."\n\nComo posso te ajudar hoje?';
    }

    if (mensagemLower.contains('ajuda') || mensagemLower.contains('socorro')) {
      return 'Estou aqui para te ajudar! Pode me contar o que está acontecendo? Ou se preferir, posso compartilhar um versículo de conforto.\n\nDeus está com você. "Não te deixarei, nem te desampararei" (Hebreus 13:5).';
    }

    return _respostaPadrao;
  }
}
