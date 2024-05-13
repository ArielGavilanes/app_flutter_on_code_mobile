// import 'package:app_flutter_on_code_mobile/pages/dashboard_page.dart';
import 'package:app_flutter_on_code_mobile/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Material App', home: (Login()));
  }
}
