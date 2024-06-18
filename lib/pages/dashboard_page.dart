import 'package:app_flutter_on_code_mobile/components/custom_drawer.dart';
import 'package:flutter/material.dart';

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
      drawer: const CustomDrawer(),
    );
  }
}
