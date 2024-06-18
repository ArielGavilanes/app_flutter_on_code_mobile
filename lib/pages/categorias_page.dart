import 'package:app_flutter_on_code_mobile/components/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:app_flutter_on_code_mobile/services/database_service.dart';

class CategoriasPage extends StatefulWidget {
  const CategoriasPage({super.key});

  @override
  State<CategoriasPage> createState() => _CategoriasPageState();
}

class _CategoriasPageState extends State<CategoriasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categorías', style: TextStyle(color: Colors.white)),
        backgroundColor:
            const Color(0xFF191919), // Fondo del AppBar en color oscuro
      ),
      body: FutureBuilder(
        future: getCategorias(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error al cargar las categorías: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white)),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No se encontraron categorías.',
                  style: TextStyle(color: Colors.white)),
            );
          } else {
            // Aquí se construye la lista de categorías
            List<dynamic> categorias = snapshot.data!;
            return ListView.builder(
              itemCount: categorias.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> categoria = categorias[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/curso_por_categoria',
                        arguments: categoria['nombre_categoria']);
                  },
                  child: Card(
                    elevation: 2,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    color: const Color(0xFF252525), // Color de fondo del Card
                    child: ListTile(
                      leading: const Icon(Icons.category,
                          color: Colors.white), // Icono de categoría en blanco
                      title: Text(
                        categoria['nombre_categoria'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      trailing: const Icon(Icons.keyboard_arrow_right,
                          color: Colors
                              .white), // Icono de flecha hacia la derecha en blanco
                      onTap: () {
                        Navigator.pushNamed(context, '/curso_por_categoria',
                            arguments: categoria['nombre_categoria']);
                      },
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFF252525),
    );
  }
}
