import 'dart:typed_data';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_flutter_on_code_mobile/components/cursos_creador.dart';
import 'package:app_flutter_on_code_mobile/components/cursos_estudiante.dart';
import 'package:app_flutter_on_code_mobile/components/custom_drawer.dart';
import 'package:app_flutter_on_code_mobile/services/auth_service.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late int idRol = 0; // Inicializamos idRol con un valor predeterminado

  @override
  void initState() {
    super.initState();
    obtenerIdRol(); // Llama al método para obtener el idRol al iniciar la página
  }

  Future<void> obtenerIdRol() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      idRol = prefs.getInt('id_rol') ??
          0; // Asignamos el valor obtenido de SharedPreferences, o un valor predeterminado si es nulo
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Perfil',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF191919), // Fondo oscuro para el appbar
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: getProfile(), // Asegúrate de que este método está bien definido
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
                child: Text('Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.white)));
          }
          if (!snapshot.hasData) {
            return const Center(
                child: Text('No se encontró información de perfil.',
                    style: TextStyle(color: Colors.white)));
          }

          Map<String, dynamic> profileData = snapshot.data!;
          String nombre = profileData['userData']['nombre_usuario'] ?? '';
          String apellido = profileData['userData']['apellido_usuario'] ?? '';
          String email = profileData['userData']['email_usuario'] ?? '';
          List<dynamic> profileImageBytesList =
              profileData['userData']['foto_perfil']['data'];
          List<dynamic> coverImageBytesList =
              profileData['userData']['foto_portada']['data'];
          Uint8List profileImageBytes =
              Uint8List.fromList(profileImageBytesList.cast<int>());
          Uint8List coverImageBytes =
              Uint8List.fromList(coverImageBytesList.cast<int>());

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.memory(
                      coverImageBytes,
                      width: double.infinity,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: -50,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          backgroundImage: MemoryImage(profileImageBytes),
                          radius: 55,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 60), // Espacio para la imagen de perfil
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$nombre $apellido',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Texto en blanco
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        email,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey, // Texto gris claro
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Mostrar widget de cursos según el idRol
                      idRol == 1
                          ? const CursosEstudianteWidget()
                          : idRol == 2
                              ? const CursosCreadorWidget()
                              : Container(),
                      // Aquí puedes agregar más información del usuario
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      drawer: const CustomDrawer(),
      backgroundColor:
          const Color(0xFF252525), // Fondo oscuro para toda la pantalla
    );
  }
}
