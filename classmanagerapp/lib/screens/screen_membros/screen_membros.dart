import 'package:flutter/material.dart';

class MembrosScreen extends StatelessWidget {
  const MembrosScreen({super.key});

  static const Color _blueColor = Color(0xFF0569FF);
  static const Color _grayColor = Color(0xFF595959);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _blueColor,
        elevation: 0,
        // Ícone da casinha 
        leading: IconButton(
          icon: const Icon(Icons.home_outlined, color: Colors.white, size: 28),
          onPressed: () {
            // lógica de navegação para voltar à tela inicial/dashboard aqui
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Calculo 1',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          // Abas de navegação 
          _buildTabs(),
          const SizedBox(height: 30),

          // Seção: Professores/Monitores
          _buildSectionTitle('Professores/Monitores:'),
          _buildListItem('Juliana Silva'),
          _buildListItem('Caio Castro'),
          _buildListItem('Moacir Azevedo'),

          const SizedBox(height: 20),

          // Seção: Alunos
          _buildSectionTitle('Alunos:'),
          _buildListItem('Gabriel Touro'),
          _buildListItem('João Jonas'),
          _buildListItem('Daniel Lima'),
          _buildListItem('Agripino Alves'),
          _buildListItem('Kaique Hoonkok'),
          _buildListItem('Paulo Jordan'),
          _buildListItem('Angleir Reis'),
        ],
      ),
    );
  }

  // Constrói a linha com as três abas
  Widget _buildTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildTab('Mural', _grayColor),
        const SizedBox(width: 10),
        _buildTab('Atividades', _grayColor),
        const SizedBox(width: 10),
        _buildTab('Membros', _blueColor),
      ],
    );
  }

  // Constrói o botão individual da aba
  Widget _buildTab(String title, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // Constrói o título das seções
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
      ),
    );
  }

  // Constrói o card individual de cada usuário (Professor ou Aluno)
  Widget _buildListItem(String name) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F2F2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey.shade300, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Círculo com o ícone de usuário
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Color(0xFFE0E0E0), // Fundo cinza do avatar
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFF757575), // Cor do ícone
              size: 22,
            ),
          ),
          const SizedBox(width: 15),
          // Nome do usuário
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
