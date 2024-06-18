import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:app_flutter_on_code_mobile/services/database_service.dart';

class BusquedaCursoPage extends StatefulWidget {
  const BusquedaCursoPage({super.key});

  @override
  State<BusquedaCursoPage> createState() => _BusquedaCursoPageState();
}

class _BusquedaCursoPageState extends State<BusquedaCursoPage> {
  final TextEditingController _controller = TextEditingController();
  List<dynamic> _searchResults = [];

  void searchCourses(String query) async {
    try {
      List<dynamic> cursos = await searchCouses(query);
      setState(() {
        _searchResults = cursos;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error al buscar cursos: $e',
            style: const TextStyle(color: Colors.white),
          ),
          backgroundColor: const Color(0xFF191919),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Búsqueda de Cursos',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF191919),
      ),
      backgroundColor: const Color(0xFF252525),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar curso...',
                hintStyle: const TextStyle(color: Colors.white54),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search, color: Colors.white),
                  onPressed: () {
                    String query = _controller.text.trim();
                    if (query.isNotEmpty) {
                      searchCourses(query);
                    }
                  },
                ),
              ),
              onSubmitted: (value) {
                String query = _controller.text;
                if (query.isNotEmpty) {
                  searchCourses(query);
                }
              },
            ),
          ),
          Expanded(
            child: _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    if (_searchResults.isEmpty) {
      return const Center(
        child: Text(
          'No se encontraron resultados.',
          style: TextStyle(color: Colors.white),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: _searchResults.length,
        itemBuilder: (context, index) {
          Map<String, dynamic> curso = _searchResults[index];
          return Card(
            color: const Color(0xFF303030),
            elevation: 2,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: curso['portada_curso'] != null
                    ? MemoryImage(Uint8List.fromList(
                        curso['portada_curso']['data'].cast<int>()))
                    : const AssetImage('assets/images/default_course_image.png')
                        as ImageProvider,
              ),
              title: Text(
                curso['nombre_curso'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              subtitle: Text(
                curso['descripcion_curso'],
                style: const TextStyle(color: Colors.white70),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/specific',
                    arguments: curso['id_curso'].toString());
              },
            ),
          );
        },
      );
    }
  }
}
