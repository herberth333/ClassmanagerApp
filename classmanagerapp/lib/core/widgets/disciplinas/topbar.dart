import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  final int abaSelecionada;
  final Function(int) onAbaPressionada;

  const TopBar({
    super.key,
    required this.abaSelecionada,
    required this.onAbaPressionada,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildAbaItem('Mural', 0),
        const SizedBox(width: 8),
        _buildAbaItem('Atividades', 1),
        const SizedBox(width: 8),
        _buildAbaItem('Membros', 2),
      ],
    );
  }

  Widget _buildAbaItem(String label, int index) {
    final isSelected = abaSelecionada == index;

    return Expanded(
      child: GestureDetector(
        onTap: () => onAbaPressionada(index),
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: isSelected
                ? const Color(0xFF0569FF)
                : const Color(0xFF666666),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          ),
        ),
      ),
    );
  }
}