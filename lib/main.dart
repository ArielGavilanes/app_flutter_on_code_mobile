import 'package:app_flutter_on_code_mobile/pages/curso_especifico_page.dart';
import 'package:app_flutter_on_code_mobile/pages/cursos_por_categoria_page.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_on_code_mobile/pages/busqueda_curso_page.dart';
import 'package:app_flutter_on_code_mobile/pages/categorias_page.dart';
import 'package:app_flutter_on_code_mobile/pages/index.dart';
import 'package:app_flutter_on_code_mobile/pages/profile_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _routes = {
    '/profile': (context) => const ProfilePage(),
    '/dashboard': (context) => const DashboardPage(),
    '/register': (context) => const RegisterPage(),
    '/login': (context) => const LoginPage(),
    '/search': (context) => const BusquedaCursoPage(),
    '/categories': (context) => const CategoriasPage(),
    '/curso_por_categoria': (context) {
      final args = ModalRoute.of(context)!.settings.arguments as String;
      return CursoPorCategoriaPage(nombreCategoria: args);
    },
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: '/login',
      onGenerateRoute: (settings) {
        if (settings.name == '/specific') {
          final args = settings.arguments as String;
          return MaterialPageRoute(
            builder: (context) => SpecificCoursePage(idCurso: args),
          );
        }
        return null;
      },
      routes: _routes,
    );
  }
}
