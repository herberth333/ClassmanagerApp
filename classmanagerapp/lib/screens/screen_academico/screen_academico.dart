import 'package:flutter/material.dart';

import '../screen_calculadora/screen_calculadora.dart';

class AcademicoScreen extends StatelessWidget {
  const AcademicoScreen({super.key});

  static const Color _blueColor = Color(0xFF0569FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _blueColor,
        elevation: 0,
        title: const Text(
          'Acadêmico',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {
              // Ação para ir ao perfil do usuário
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Botão 1: Horários
            _buildMenuButton(
              icon: Icons.history,
              label: 'Horários',
              onTap: () {
                // Navegar para tela de horários
              },
            ),
            const SizedBox(width: 30),
            // Botão 2: Calcular média
            _buildMenuButton(
              icon: Icons.calculate_outlined,
              label: 'Calcular\nmédia',
              onTap: () {
                // Abre a calculadora
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CalculadoraScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  //widgets
  Widget _buildMenuButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F8FA),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(icon, size: 32, color: Colors.black87),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
