import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(30, 30, 30, 1),
                    borderRadius: BorderRadius.circular(25)),
                child: Column(
                  children: [
                    const Text(
                      'Iniciar Sesion',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    TextField(
                        decoration: InputDecoration(
                            label: const Text(
                              'Usuario',
                              style: TextStyle(color: Colors.white),
                            ),
                            fillColor: const Color.fromARGB(255, 201, 85, 85),
                            hintText: 'Ingrese su usuario',
                            hintStyle: const TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
