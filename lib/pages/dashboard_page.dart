import 'package:flutter/material.dart';
import '../components/custom-navbar.dart'; 

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // toolbarHeight: 75,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.1),
        title: const Text(
          'Dashboard',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Image(image: AssetImage('assets/images/onCodeMobile.png')),
            ),
          )
        ],
      ),
      drawer: const CustomNavbar(), // Aquí se agrega el CustomNavbar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.white,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 0.1),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded, color: Colors.white),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, color: Colors.white),
            label: 'Perfil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school_rounded, color: Colors.white),
            label: 'Tus cursos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded, color: Colors.white),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.white),
              label: 'Configuracion'),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
