import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Define a aba "Acadêmico" (índice 1) como selecionada inicialmente,
  // exatamente como mostra a sua imagem do Figma.
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ClassManager - Início'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              // Lógica de logout
            },
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
