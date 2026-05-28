import 'package:flutter/material.dart';
import 'package:classmanagerapp/core/widgets/navbar/navbar.dart';
import 'package:classmanagerapp/core/widgets/diciplinas/diciplinas.dart';
import 'package:classmanagerapp/screens/screen_academico/screen_academico.dart';
import 'package:classmanagerapp/screens/screen_configuracoes/screen_configuracoes.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _abaAtiva = 0;

  final List<Widget> _telas = [
    const DiciplinasScreen(),
    const AcademicoScreen(),
    const ConfiguracoesScreen(),
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
