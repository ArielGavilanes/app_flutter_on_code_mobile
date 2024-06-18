import 'dart:convert';
import 'dart:typed_data'; // Necesario para manejar los datos binarios de la imagen
import 'package:flutter/material.dart';
import 'package:app_flutter_on_code_mobile/services/auth_service.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: getProfile(), // Asegúrate de que este método está bien definido
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData) {
          return const Center(
              child: Text('No se encontró información de perfil.'));
        }

        Map<String, dynamic> profileData = snapshot.data!;
        String nombre = profileData['nombre_usuario'] ?? '';
        String email = profileData['userData']['email_usuario'] ?? '';
        List<dynamic> imageBytesList =
            profileData['userData']['foto_perfil']['data'];
        Uint8List imageBytes = Uint8List.fromList(imageBytesList.cast<int>());

        return Drawer(
          child: Container(
            color: const Color(0xFF252525), // Color de fondo del Drawer
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                Container(
                  color: const Color(0xFF191919), // Color Azul Marino
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: MemoryImage(
                                imageBytes), // Mostrar la imagen desde bytes
                            radius: 30,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "@$nombre",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                email,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading:
                      const Icon(Icons.account_circle, color: Colors.white),
                  title: const Text('Perfil',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.home, color: Colors.white),
                  title: const Text('Inicio',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/dashboard');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.search, color: Colors.white),
                  title: const Text('Buscar',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/search');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.code, color: Colors.white),
                  title: const Text('Categorías',
                      style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.pushNamed(context, '/categories');
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
