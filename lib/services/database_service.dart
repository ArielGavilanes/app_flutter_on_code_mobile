import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<List> getCursosForProfile() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');
  int? idRol = prefs.getInt('id_rol');

  const String apiUrlCreador = 'http://10.0.2.2:3000/api/cursos/creador/';
  const String apiUrlEstudiante = 'http://10.0.2.2:3000/api/matriculas/cursos/';

  String apiUrl;
  if (idRol == 1) {
    apiUrl = apiUrlEstudiante;
  } else if (idRol == 2) {
    apiUrl = apiUrlCreador;
  } else {
    throw Exception('Rol no reconocido');
  }

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    List cursos = json.decode(response.body);
    print('Los cursos son');
    print(cursos);
    return cursos;
  } else {
    throw Exception('Error al cargar los cursos');
  }
}

Future<Map<String, dynamic>> getCourseById(String idCurso) async {
  final String apiUrl = 'http://10.0.2.2:3000/api/cursos/$idCurso';

  final response = await http.get(
    Uri.parse(apiUrl),
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> curso = jsonDecode(response.body);
    return curso;
  } else {
    throw Exception('Error al obtener el perfil: ${response.statusCode}');
  }
}

Future<List> searchCouses(String queryCurso) async {
  final String apiUrl =
      'http://10.0.2.2:3000/api/cursos/search?nombre_curso=$queryCurso';

  final response = await http.get(
    Uri.parse(apiUrl),
  );

  if (response.statusCode == 200) {
    List cursos = jsonDecode(response.body);
    return cursos;
  } else {
    throw Exception('Error al obtener el cursos: ${response.statusCode}');
  }
}

Future<List> getCategorias() async {
  const String apiUrl = 'http://10.0.2.2:3000/api/categorias';

  final response = await http.get(
    Uri.parse(apiUrl),
  );

  if (response.statusCode == 200) {
    List categorias = jsonDecode(response.body);
    print(categorias);
    return categorias;
  } else {
    throw Exception('Error al obtener las categorias: ${response.statusCode}');
  }
}

Future<List> getCourseByCategorieName(String categoria) async {
  final String apiUrl = 'http://10.0.2.2:3000/api/cursos/categoria/$categoria/';

  final response = await http.get(
    Uri.parse(apiUrl),
  );

  if (response.statusCode == 200) {
    List cursos = jsonDecode(response.body);
    print(cursos);
    return cursos;
  } else {
    throw Exception('Error al obtener los cursos por categorias: ${response.statusCode}');
  }
}
