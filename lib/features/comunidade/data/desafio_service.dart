import '../../../shared/models/content_models.dart';

class DesafioService {
  static final List<Map<String, dynamic>> _mockDesafios = [
    {
      'id': '1',
      'titulo': 'Desafio de 21 Dias de Oração',
      'descricao':
          'Dedique 21 dias para orar diariamente. Siga o plano de oração abaixo e veja a transformação na sua vida.',
      'duracao_dias': 21,
      'versiculos': [
        {'livro': '1 Tessalonicenses', 'capitulo': 5, 'versiculo': 17, 'texto': 'Orai sem cessar.'},
        {'livro': 'Filipenses', 'capitulo': 4, 'versiculo': 6, 'texto': 'Não vos animeis com coisa alguma; antes, em tudo, sejam conhecidas, perante Deus, as vossas petições, em oração e súplica, com ações de graças.'},
        {'livro': 'Jeremias', 'capitulo': 33, 'versiculo': 3, 'texto': 'Clama a mim, e responder-te-ei, e anunciar-te-ei coisas grandes e firmes, que não sabes.'},
      ],
      'ativo': true,
      'created_at': '2025-01-01T00:00:00Z',
    },
    {
      'id': '2',
      'titulo': 'Desafio da Gratidão',
      'descricao':
          'Por 7 dias, escreva 3 coisas pelas quais você é grato todos os dias. Transforme sua perspectiva!',
      'duracao_dias': 7,
      'versiculos': [
        {'livro': '1 Tessalonicenses', 'capitulo': 5, 'versiculo': 18, 'texto': 'Em tudo dai graças, porque esta é a vontade de Deus em Cristo Jesus para convosco.'},
        {'livro': 'Salmos', 'capitulo': 100, 'versiculo': 4, 'texto': 'Entrai por suas portas com louvor, em seus átrios com louvor. Dai-lhe graças, bendizei o seu nome.'},
      ],
      'ativo': true,
      'created_at': '2025-01-05T00:00:00Z',
    },
    {
      'id': '3',
      'titulo': 'Desafio de Leitura Bíblica',
      'descricao':
          'Leia um capítulo por dia do Novo Testamento. Em 26 dias você terá lido todo o NT!',
      'duracao_dias': 26,
      'versiculos': [
        {'livro': 'Salmos', 'capitulo': 119, 'versiculo': 105, 'texto': 'Lâmpada para os meus pés é tua palavra, e luz para o meu caminho.'},
        {'livro': '2 Timóteo', 'capitulo': 3, 'versiculo': 16, 'texto': 'Toda a Escritura é inspirada por Deus e útil para o ensino, para a repreensão, para a correção, para a educação na justiça.'},
      ],
      'ativo': true,
      'created_at': '2025-01-10T00:00:00Z',
    },
    {
      'id': '4',
      'titulo': 'Desafio do Amor ao Próximo',
      'descricao':
          'Por 10 dias, faça uma boa ação por dia por alguém. Pequenos atos de amor transformam o mundo.',
      'duracao_dias': 10,
      'versiculos': [
        {'livro': '1 João', 'capitulo': 3, 'versiculo': 18, 'texto': 'Nós o amamos, não em palavra somente, mas em obras e em verdade.'},
        {'livro': 'Gálatas', 'capitulo': 5, 'versiculo': 13, 'texto': 'Porque vós, irmãos, fostes chamados à liberdade; apenas que não useis a liberdade para ocasião à carne, mas servi-vos uns aos outros em amor.'},
      ],
      'ativo': true,
      'created_at': '2025-01-15T00:00:00Z',
    },
    {
      'id': '5',
      'titulo': 'Desafio do Jejum',
      'descricao':
          '3 dias de jejum com água e sucos. Consagre esse tempo em oração e busca pela presença de Deus.',
      'duracao_dias': 3,
      'versiculos': [
        {'livro': 'Isaías', 'capitulo': 58, 'versiculo': 6, 'texto': 'Não é este o jejum que eu escolhi: desatar os laços da injustiça, soltar as cargas opressoras, deixar livres os oprimidos e quebrar todo jugo?'},
        {'livro': 'Mateus', 'capitulo': 6, 'versiculo': 16, 'texto': 'E, quando jejuardes, não esteis tristes como os hipócritas.'},
      ],
      'ativo': true,
      'created_at': '2025-01-20T00:00:00Z',
    },
  ];

  Future<List<Desafio>> getAllDesafios() async {
    return _mockDesafios.map((json) => Desafio.fromJson(json)).toList();
  }

  Future<Desafio?> getDesafioById(String id) async {
    final found = _mockDesafios.firstWhere(
      (d) => d['id'] == id,
      orElse: () => {},
    );
    if (found.isEmpty) return null;
    return Desafio.fromJson(found);
  }
}
