import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerForm = GlobalKey<FormState>();
  bool _showPassword = false;
  final TextEditingController _nombreUsuario = TextEditingController();
  final TextEditingController _contrasenaUsuario = TextEditingController();
  final TextEditingController _confirmarContrasena = TextEditingController();
  final TextEditingController _emailUsuario = TextEditingController();
  final TextEditingController _nombreUsuarioReal = TextEditingController();
  final TextEditingController _apellidoUsuario = TextEditingController();
  String _idRol = 'estudiante'; // Valor predeterminado para el DropdownButton

  Future<void> _registerUser() async {
    var url = 'http://10.0.2.2:3000/api/auth/register/';

    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.fields['nombre_usuario'] = _nombreUsuario.text;
    request.fields['contrasena_usuario'] = _contrasenaUsuario.text;
    request.fields['email_usuario'] = _emailUsuario.text;
    request.fields['nombre_usuario_real'] = _nombreUsuarioReal.text;
    request.fields['apellido_usuario'] = _apellidoUsuario.text;
    request.fields['id_rol'] = '1';

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode == 201) {
      print('Usuario subido correctamente');
      Navigator.pushReplacementNamed(context, '/');
    } else {
      print('Error al crear el usuario: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(19, 19, 19, 1),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
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
                    key: _registerForm,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Regístrate',
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
                          decoration: const InputDecoration(
                            labelText: 'Usuario',
                            hintText: 'Ingresa tu usuario',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _contrasenaUsuario,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            labelText: 'Contraseña',
                            hintText: 'Ingresa tu contraseña',
                            hintStyle: const TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
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
                            labelStyle: const TextStyle(color: Colors.white),
                          ),
                          obscureText: !_showPassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: _confirmarContrasena,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            labelText: 'Confirmar Contraseña',
                            hintText: 'Confirma tu contraseña',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            if (value != _contrasenaUsuario.text) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                        ),
                        const Divider(
                          height: 20,
                          color: Color.fromRGBO(30, 30, 30, 1),
                        ),
                        TextFormField(
                          controller: _nombreUsuarioReal,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            labelText: 'Nombre',
                            hintText: 'Ingresa tu nombre',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
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
                          controller: _apellidoUsuario,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            labelText: 'Apellido',
                            hintText: 'Ingresa tu apellido',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
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
                          controller: _emailUsuario,
                          style: const TextStyle(color: Colors.white),
                          cursorColor: Colors.white,
                          decoration: const InputDecoration(
                            labelText: 'Correo Electronico',
                            hintText: 'Ingresa tu email',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            labelStyle: TextStyle(color: Colors.white),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        DropdownButtonFormField<String>(
                          value: _idRol,
                          onChanged: (String? newValue) {
                            setState(() {
                              _idRol = newValue!;
                            });
                          },
                          items: <String>['estudiante', 'creador']
                              .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                          decoration: const InputDecoration(
                            labelText: 'Tipo de Usuario',
                            labelStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                            ),
                          ),
                          dropdownColor: Colors.grey[
                              800], // Cambia el color de fondo del menú desplegable
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_registerForm.currentState!.validate()) {
                              _registerUser();
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Colors.white.withOpacity(0.3),
                            ),
                            padding:
                                MaterialStateProperty.all<EdgeInsetsGeometry>(
                              const EdgeInsets.symmetric(
                                  vertical: 12, horizontal: 24),
                            ),
                            shape: MaterialStateProperty.all<OutlinedBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0),
                                side:
                                    const BorderSide(color: Colors.transparent),
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
                            'Registrarse',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, '/');
                          },
                          child: const Text(
                            'Tienes una cuenta? Inicia sesión',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
