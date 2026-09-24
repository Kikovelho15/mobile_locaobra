import 'package:flutter/material.dart';
import 'package:locaobra_mobile/screens/home_screen.dart';
import 'package:locaobra_mobile/models/produto.dart';
import 'package:locaobra_mobile/models/produto_detalhes.dart';
import 'package:locaobra_mobile/widgets/category_nav_tabs.dart';

// Corpo completo de uma página de categoria: abas de navegação,
// breadcrumb (Início > categoria), botão Filtrar e a grade de produtos.
//
// Cada página de categoria (ferramentas_eletricas.dart, concretagem.dart,
// etc.) só precisa montar o Scaffold/AppBar e passar a lista de produtos
// para este widget — evita repetir esse bloco inteiro em cada arquivo.
class CategoryListagem extends StatelessWidget {
  final String categoria;
  final List<Produto> produtos;

  const CategoryListagem({
    super.key,
    required this.categoria,
    required this.produtos,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CategoryNavTabs(categoriaAtual: categoria),
        const Divider(height: 1, color: Colors.grey),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Breadcrumb (Início > categoria) + botão Filtrar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: _buildBreadcrumb(context)),
                  _buildFiltrarButton(),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(height: 1, color: Colors.grey),
              const SizedBox(height: 16),

              // Grade de produtos: 2 colunas
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: produtos.length,
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.6,
                    ),
                itemBuilder: (context, index) {
                  return _buildProductCard(context, produtos[index]);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Trilha "Início > Categoria". "Início" é clicável e volta para a
  // HomeScreen (já com o usuário logado, se estiver logado — o AuthState
  // não é afetado por essa navegação).
  Widget _buildBreadcrumb(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const HomeScreen()),
              (route) => false,
            );
          },
          child: Text(
            'Início',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey.shade600,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
        Icon(Icons.chevron_right, size: 16, color: Colors.grey.shade600),
        Text(
          categoria,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  // Botão "Filtrar" com ícone de funil
  Widget _buildFiltrarButton() {
    return OutlinedButton.icon(
      onPressed: () {
        // Todo: abrir tela/modal de filtros
      },
      icon: const Icon(Icons.filter_list, size: 18, color: Colors.black87),
      label: const Text(
        'Filtrar',
        style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.white,
        side: BorderSide(color: Colors.grey.shade300),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      ),
    );
  }

  // Foto do card: aceita asset local ou URL da API e trata produto sem
  // foto (imagemPrincipal nulo) ou imagem que falhou ao carregar.
  Widget _buildFoto(String? path) {
    final placeholder = Container(
      color: Colors.grey.shade200,
      child: Icon(
        Icons.image_not_supported_outlined,
        color: Colors.grey.shade500,
      ),
    );

    if (path == null || path.isEmpty) return placeholder;

    if (path.startsWith('http')) {
      return Image.network(
        path,
        fit: BoxFit.cover,
        width: double.infinity,
        errorBuilder: (_, _, _) => placeholder,
      );
    }
    return Image.asset(
      path,
      fit: BoxFit.cover,
      width: double.infinity,
      errorBuilder: (_, _, _) => placeholder,
    );
  }

  // Card individual de produto. Ao tocar, abre a tela de detalhes.
  Widget _buildProductCard(BuildContext context, Produto produto) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ProdutoDetalhesPage(produto: produto),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300, width: 1),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: _buildFoto(produto.imagemPrincipal),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        produto.nome,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        produto.descricao,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey.shade600,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Divider(height: 1, color: Colors.grey),
                      const SizedBox(height: 8),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  'R\$ ${produto.precoPorDia.toStringAsFixed(2).replaceAll('.', ',')}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.orange,
                              ),
                            ),
                            TextSpan(
                              text: ' / dia',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}