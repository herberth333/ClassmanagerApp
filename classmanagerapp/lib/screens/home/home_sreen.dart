import 'package:classmanagerapp/screens/activities/student_activities_screen.dart';
import 'package:classmanagerapp/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _screens = [
    StudentActivitiesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_outlined),
            activeIcon: Icon(Icons.menu_book),
            label: 'Atividades',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Configuracoes',
          ),
        ],
      ),
      body: const Center(
        child: Text(
          'Bem-vindo à Tela Principal!',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),

      // Adicionando a sua Navbar customizada
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF0569FF), // O azul exato do seu Figma
        type: BottomNavigationBarType
            .fixed, // Garante que o fundo sólido seja aplicado
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        // Estilização de cores
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        // Estilização das fontes
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
        // Definição dos ícones
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.home_outlined),
            ),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.menu_book_outlined),
            ),
            label: 'Acadêmico',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.settings_outlined),
            ),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
