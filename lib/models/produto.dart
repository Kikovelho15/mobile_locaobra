// Modelo de produto compartilhado por todas as páginas de categoria
// (Ferramentas Elétricas, Concretagem, Acesso e Elevação, etc).
class Produto {
  // Fotos do produto (a primeira é a foto principal/capa).
  final List<String> imagePaths;
  final String nome;
  final String descricao;
  final String categoria;
  final int quantidadeDisponivel;
  final double precoPorDia;
  final double avaliacao; // de 0 a 5
  // Especificações técnicas, em pares de rótulo/valor
  final Map<String, String> especificacoes;

  // CONSTRUTOR PRINCIPAL (era o que estava faltando)
  const Produto({
    required this.imagePaths,
    required this.nome,
    required this.descricao,
    required this.categoria,
    required this.quantidadeDisponivel,
    required this.precoPorDia,
    required this.avaliacao,
    required this.especificacoes,
  });

  // Cria o Produto a partir do JSON da API
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      // Todo: troque as chaves pelas que a sua API realmente devolve
      imagePaths: (json['imagens'] as List? ?? [])
          .map((e) => e.toString())
          .toList(),
      nome: json['nome']?.toString() ?? '',
      descricao: json['descricao']?.toString() ?? '',
      categoria: json['categoria']?.toString() ?? '',
      // tryParse aceita número ou texto ("6" ou 6) sem quebrar
      quantidadeDisponivel:
          int.tryParse('${json['quantidade_disponivel']}') ?? 0,
      precoPorDia: double.tryParse('${json['valor_diaria']}') ?? 0,
      avaliacao: double.tryParse('${json['avaliacao']}') ?? 0,
      especificacoes: (json['especificacoes'] as Map? ?? {})
          .map((k, v) => MapEntry(k.toString(), v.toString())),
    );
  }

  // Foto principal (usada nos cards da listagem).
  // Devolve null se o produto vier da API sem foto, para não dar erro.
  String? get imagemPrincipal =>
      imagePaths.isEmpty ? null : imagePaths.first;
}