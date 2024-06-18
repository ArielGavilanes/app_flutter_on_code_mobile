import 'dart:typed_data';
import 'package:app_flutter_on_code_mobile/components/custom_drawer.dart';
import 'package:app_flutter_on_code_mobile/services/database_service.dart';
import 'package:flutter/material.dart';

class CursoPorCategoriaPage extends StatelessWidget {
  final String nombreCategoria;
  const CursoPorCategoriaPage({super.key, required this.nombreCategoria});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cursos de $nombreCategoria',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF191919),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: getCourseByCategorieName(nombreCategoria),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            final cursos = snapshot.data!;
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: cursos.length,
              itemBuilder: (context, index) {
                final curso = cursos[index];
                String nombreCurso = curso['nombre_curso'] ?? '';
                bool premiumCurso = curso['premium_curso'] ?? false;
                double precioCurso = curso['precio_curso']?.toDouble() ?? 0.0;
                List<dynamic> portadaCursoBytesList =
                    curso['portada_curso']['data'];
                Uint8List portadaCursoBytes =
                    Uint8List.fromList(portadaCursoBytesList.cast<int>());

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/specific',
                      arguments: curso['id_curso'].toString(),
                    );
                  },
                  child: Card(
                    color: const Color(0xFF303030),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 100,
                          child: Image.memory(
                            portadaCursoBytes,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 4.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nombreCurso,
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                'Premium: ${premiumCurso ? 'Sí' : 'No'}',
                                style: const TextStyle(color: Colors.white),
                              ),
                              const SizedBox(height: 24),
                              Text(
                                '\$$precioCurso',
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
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
