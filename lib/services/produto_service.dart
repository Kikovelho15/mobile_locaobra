import 'package:locaobra_mobile/models/produto.dart';
// import 'package:locaobra_mobile/services/api_client.dart';

class ProdutoService {
  /// Busca os produtos de uma categoria (ex: 'ferramentas-eletricas').
  static Future<List<Produto>> listarPorCategoria(String slug) async {
    // -----------------------------------------------------------------
    // TEMPORÁRIO: dados de mentira, para a tela funcionar agora.
    // Quando a API estiver pronta, APAGUE este bloco e use o de baixo.
    // -----------------------------------------------------------------
    await Future.delayed(const Duration(milliseconds: 600));
    return const [
      Produto(
        imagePaths: [
          'assets/imagens/furadeira.jpg',
          'assets/imagens/furadeira_2.jpg',
          'assets/imagens/furadeira_3.jpg',
        ],
        nome: 'Furadeira de Impacto 500W',
        descricao:
            'Ideal para perfurar concreto, alvenaria e madeira em obras de '
            'pequeno e médio porte. Motor de 500W com sistema de impacto, '
            'entrega potência suficiente para o dia a dia do canteiro sem '
            'pesar na mão do profissional.',
        categoria: 'Ferramentas Elétricas',
        quantidadeDisponivel: 6,
        precoPorDia: 15.00,
        avaliacao: 5.0,
        especificacoes: {
          'Potência': '500W',
          'Voltagem': 'Bivolt (127V / 220V)',
          'Mandril': '13mm',
          'Peso': '1.8kg',
        },
      ),
    ];

    // -----------------------------------------------------------------
    // API REAL (descomente e ajuste ao seu ApiClient):
    //
    // final data = await ApiClient.get('/produtos?categoria=$slug');
    // final lista = (data is Map ? data['data'] : data) as List;
    // return lista
    //     .map((e) => Produto.fromJson(e as Map<String, dynamic>))
    //     .toList();
    // -----------------------------------------------------------------
  }
}