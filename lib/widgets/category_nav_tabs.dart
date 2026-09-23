import 'package:flutter/material.dart';
import 'package:locaobra_mobile/Categorias/acesso_e_elevacao.dart';
import 'package:locaobra_mobile/Categorias/concretagem.dart';
import 'package:locaobra_mobile/Categorias/ferramentas_eletricas.dart';

// Linha de abas de navegação por categoria, reaproveitada em todas as
// telas (inicial e páginas de categoria).
//
// A aba da categoria atual (se houver) aparece destacada em laranja;
// tocar em qualquer outra aba leva para a página correspondente.
class CategoryNavTabs extends StatelessWidget {
  // Nome da categoria exibida nesta tela, para destacar a aba certa em
  // laranja. Deixe null na tela inicial (nenhuma selecionada).
  final String? categoriaAtual;

  const CategoryNavTabs({super.key, this.categoriaAtual});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      child: Row(
        children: [
          _buildTab(
            context: context,
            title: 'Acesso e Elevação',
            builder: () => const AcessoPage(),
          ),
          const SizedBox(width: 24),
          _buildTab(
            context: context,
            title: 'Concretagem',
            builder: () => const ConcretagemPage(),
          ),
          const SizedBox(width: 24),
          _buildTab(
            context: context,
            title: 'Ferramentas Elétricas',
            builder: () => const FerramentasEletricasPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildTab({
    required BuildContext context,
    required String title,
    required Widget Function() builder,
  }) {
    final bool isSelected = title == categoriaAtual;
    return InkWell(
      onTap: () {
        if (isSelected) return; // já está nesta página, nada a fazer
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => builder()),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Text(
          title,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isSelected ? Colors.orange : Colors.black87,
          ),
        ),
      ),
    );
  }
}