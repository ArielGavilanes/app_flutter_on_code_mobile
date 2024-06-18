import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<Map<String, dynamic>> getProfile() async {
  const String apiUrl = 'http://10.0.2.2:3000/api/auth/profile/';

  // Obtener el token del almacenamiento local
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('token');

  if (token == null) {
    throw Exception('Token no encontrado');
  }

  final response = await http.get(
    Uri.parse(apiUrl),
    headers: {
      'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    Map<String, dynamic> responseBody = jsonDecode(response.body);
    return responseBody;
  } else {
    throw Exception('Error al obtener el perfil: ${response.statusCode}');
  }
}
