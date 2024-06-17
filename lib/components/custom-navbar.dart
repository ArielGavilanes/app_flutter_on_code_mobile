import 'package:flutter/material.dart';

class CustomNavbar extends StatelessWidget {
  const CustomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        iconTheme: IconThemeData(color: Colors.white),
      ),
      child: Drawer(
        child: Container(
          color: Colors.black,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(
                  "Usuario",
                  style: TextStyle(color: Colors.white),
                ),
                accountEmail: Text(
                  "usuario@gmail.com",
                  style: TextStyle(color: Colors.white),
                ),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://www.example.com/images/profile.jpg"),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Inicio', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              ListTile(
                leading: Icon(Icons.book),
                title: Text('Tus Cursos', style: TextStyle(color: Colors.white)),
                onTap: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
              ),
              ExpansionTile(
                leading: Icon(Icons.category),
                title: Text('Categorías', style: TextStyle(color: Colors.white)),
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Categoría 1', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Categoría 2', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.label),
                    title: Text('Categoría 3', style: TextStyle(color: Colors.white)),
                    onTap: () {
                      Navigator.pushNamed(context, '/dashboard');
                    },
                  ),
                ],
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
                onTap: () {
                  // Implementar la funcionalidad de cierre de sesión
                  Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
