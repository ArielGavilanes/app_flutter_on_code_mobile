import 'package:app_flutter_on_code_mobile/services/database_service.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';

class CursosCreadorWidget extends StatelessWidget {
  const CursosCreadorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List>(
      future: getCursosForProfile(), // Llama al método del servicio
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
              child: Text('Error: ${snapshot.error}',
                  style: const TextStyle(color: Colors.white)));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
              child: Text('No se encontraron cursos para este perfil.',
                  style: TextStyle(color: Colors.white)));
        }

        List cursos = snapshot.data!;
        return ListView.builder(
          shrinkWrap: true,
          itemCount: cursos.length,
          itemBuilder: (context, index) {
            var curso = cursos[index];
            return ListTile(
              title: Text(curso['nombre_curso'],
                  style: const TextStyle(color: Colors.white)),
              subtitle: Text(curso['descripcion_curso'],
                  style: const TextStyle(color: Colors.white)),
              leading: CircleAvatar(
                backgroundImage: MemoryImage(Uint8List.fromList(
                    curso['portada_curso']['data'].cast<int>())),
              ),
            );
          },
        );
      },
    );
  }
}
