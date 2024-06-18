import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _showPassword = false;
  final TextEditingController _nombreUsuario = TextEditingController();
  final TextEditingController _contrasenaUsuario = TextEditingController();
  String? _loginErrorMessage;
  final GlobalKey<FormState> _loginForm = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(
                image: AssetImage('assets/images/onCodeMobile.png'),
                width: 150,
              ),
              const Divider(
                height: 20,
                color: Color.fromRGBO(19, 19, 19, 1),
              ),
              Container(
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(30, 30, 30, 1),
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Form(
                  key: _loginForm,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Hola, un gusto verte de nuevo!',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                      ),
                      const Divider(
                        height: 20,
                        color: Color.fromRGBO(30, 30, 30, 1),
                      ),
                      TextFormField(
                        controller: _nombreUsuario,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          label: const Text(
                            'Usuario',
                            style: TextStyle(color: Colors.white),
                          ),
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          hintText: 'Ingresa tu usuario',
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                      ),
                      const Divider(
                        height: 20,
                        color: Color.fromRGBO(30, 30, 30, 1),
                      ),
                      TextFormField(
                        controller: _contrasenaUsuario,
                        style: const TextStyle(color: Colors.white),
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          label: const Text(
                            'Contraseña',
                            style: TextStyle(color: Colors.white),
                          ),
                          fillColor: const Color.fromARGB(255, 255, 255, 255),
                          hintText: 'Ingresa tu contraseña',
                          hintStyle: const TextStyle(color: Colors.white),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _showPassword = !_showPassword;
                              });
                            },
                            icon: Icon(
                              _showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        obscureText: !_showPassword,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Este campo es obligatorio';
                          }
                          return null;
                        },
                      ),
                      const Divider(
                        height: 20,
                        color: Color.fromRGBO(30, 30, 30, 1),
                      ),
                      if (_loginErrorMessage != null)
                        Text(_loginErrorMessage!,
                            style: const TextStyle(
                                color: Colors.red, fontSize: 18)),
                      const Divider(
                        height: 20,
                        color: Color.fromRGBO(30, 30, 30, 1),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_loginForm.currentState!.validate()) {
                            _login();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white.withOpacity(0.3)),
                          padding:
                              MaterialStateProperty.all<EdgeInsetsGeometry>(
                                  const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 24)),
                          shape: MaterialStateProperty.all<OutlinedBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              side: const BorderSide(
                                color: Colors.transparent,
                              ),
                            ),
                          ),
                          textStyle: MaterialStateProperty.all<TextStyle>(
                            TextStyle(
                              color: Colors.black.withOpacity(0.9),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        child: const Text(
                          'Iniciar sesión',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: const Text(
                          'Registrarse',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _login() async {
    const String apiUrl = 'http://10.0.2.2:3000/api/auth/login/';

    var payload = {
      'nombre_usuario': _nombreUsuario.text,
      'contrasena_usuario': _contrasenaUsuario.text
    };

    http.Response response = await http.post(Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(payload));

    if (response.statusCode == HttpStatus.ok) {
      var responseBody = jsonDecode(response.body);
      var token = responseBody['token'];
      var idRol = responseBody['id_rol'];
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);
      await prefs.setInt('id_rol', idRol);
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else {
      setState(() {
        _loginErrorMessage = 'Usuario o contraseña incorrectos';
      });
    }
  }
}
