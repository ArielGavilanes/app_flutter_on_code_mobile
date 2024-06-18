import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:app_flutter_on_code_mobile/components/custom_drawer.dart';
import 'package:app_flutter_on_code_mobile/services/database_service.dart'; // Ajusta según el nombre real de tu servicio

class SpecificCoursePage extends StatelessWidget {
  final String idCurso;

  const SpecificCoursePage({required this.idCurso, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF191919), // Color del appbar
        title: FutureBuilder<Map<String, dynamic>>(
          future: getCourseById(idCurso),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text(
                'Cargando...',
                style: TextStyle(color: Colors.white),
              );
            }
            if (snapshot.hasError) {
              return const Text(
                'Error',
                style: TextStyle(color: Colors.white),
              );
            }
            if (!snapshot.hasData) {
              return const Text(
                'Curso',
                style: TextStyle(color: Colors.white),
              );
            }

            Map<String, dynamic> curso = snapshot.data!;
            String nombreCurso = curso['nombre_curso'];

            return Text(
              nombreCurso,
              style: const TextStyle(color: Colors.white),
            );
          },
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getCourseById(idCurso),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (!snapshot.hasData) {
            return const Center(
              child: Text('No se encontraron datos del curso.'),
            );
          }

          Map<String, dynamic> curso = snapshot.data!;
          String nombreCurso = curso['nombre_curso'];
          String descripcionCurso = curso['descripcion_curso'];
          bool esPremium = curso['premium_curso'];
          double precioCurso = curso['precio_curso'].toDouble();

          List<int> portadaData = curso['portada_curso']['data'].cast<int>();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Portada del curso
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(
                        0xFF303030), // Color de fondo oscuro para la portada
                    image: DecorationImage(
                      image: MemoryImage(Uint8List.fromList(portadaData)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Nombre del curso
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    nombreCurso,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Texto en blanco
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Descripción del curso
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    descripcionCurso,
                    style: const TextStyle(
                        fontSize: 18, color: Colors.white), // Texto en blanco
                  ),
                ),
                const SizedBox(height: 16),
                // Precio (o Gratuito)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    esPremium
                        ? 'Precio: \$${precioCurso.toStringAsFixed(2)}'
                        : 'Gratuito',
                    style: const TextStyle(
                        fontSize: 16, color: Colors.white), // Texto en blanco
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
      drawer: const CustomDrawer(),
      backgroundColor: const Color(0xFF252525),
    );
  }
}
