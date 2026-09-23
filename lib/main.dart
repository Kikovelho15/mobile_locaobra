import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:locaobra_mobile/Categorias/catalogo_page.dart';
import 'package:locaobra_mobile/screens/welcome_screen.dart';

// Definição do GoRouter com as rotas
final GoRouter _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', builder: (context, state) => const WelcomeScreen()),
    GoRoute(
      path: '/catalogo/:categoria',
      builder: (context, state) {
        final categoriaSlug = state.pathParameters['categoria'] ?? '';
        return CatalogoPagina(categoriaSlug: categoriaSlug);
      },
    ),
  ],
);

void main() {
  runApp(const LocaObraApp());
}

// Widget raiz do aplicativo: configura o MaterialApp.router com as rotas
// definidas acima. Não confundir com HomeScreenPage — essa classe aqui é
// só o "ponto de partida" do app, não uma tela em si.
class LocaObraApp extends StatelessWidget {
  const LocaObraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}