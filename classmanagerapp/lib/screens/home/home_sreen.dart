import 'package:flutter/material.dart';
import 'package:classmanagerapp/core/widgets/navbar/navbar.dart';
import 'package:classmanagerapp/core/widgets/diciplinas/diciplinas.dart'; 

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _abaAtiva = 1; 

  final List<Widget> _telas = [
    const Scaffold(body: Center(child: Text('Conteúdo do Início', style: TextStyle(fontSize: 20)))),
    const DiciplinasScreen(),
    const Scaffold(body: Center(child: Text('Conteúdo das Configurações', style: TextStyle(fontSize: 20)))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_abaAtiva], 

      bottomNavigationBar: CustomNavbar(
        currentIndex: _abaAtiva,
        onTap: (index) {
          setState(() {
            _abaAtiva = index; 
          });
        },
      ),
    );
  }
}