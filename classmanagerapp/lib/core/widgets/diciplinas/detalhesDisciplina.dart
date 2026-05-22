import 'package:flutter/material.dart';
import 'package:classmanagerapp/screens/home/activity_screen.dart';

class DetalhesDisciplina extends StatefulWidget {
  final String nomeDisciplina;
  final String disciplineId;

  const DetalhesDisciplina({
    super.key,
    required this.nomeDisciplina,
    this.disciplineId = '1',
  });

  @override
  State<DetalhesDisciplina> createState() => _DetalhesDisciplinaState();
}

class _DetalhesDisciplinaState extends State<DetalhesDisciplina> {
  int _abaAtiva = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0569FF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.home_outlined, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.nomeDisciplina,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Abas
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: Row(
                  children: [
                    _buildAbaItem('Mural', index: 0),
                    const SizedBox(width: 8),
                    _buildAbaItem('Atividades', index: 1),
                    const SizedBox(width: 8),
                    _buildAbaItem('Membros', index: 2),
                  ],
                ),
              ),
              // Conteúdo das abas
              Expanded(
                child: _buildTabContent(),
              ),
            ],
          ),
          // Botão flutuante
          if (_abaAtiva == 0)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: const Color(0xFF0569FF),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: InkWell(
                  onTap: () {},
                  borderRadius: BorderRadius.circular(12),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Nova publicação ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Icon(Icons.add_circle_outline, color: Colors.white, size: 22),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    if (_abaAtiva == 1) {
      return ActivityScreen(
        disciplineId: widget.disciplineId,
        disciplineName: widget.nomeDisciplina,
      );
    } else if (_abaAtiva == 2) {
      return _buildMembrosTab();
    } else {
      return _buildMuralTab();
    }
  }

  Widget _buildMuralTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 0, bottom: 90.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Text(
              'Sala 22  →  18:45 ás 22:15',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.account_circle, size: 40, color: Colors.grey),
                    const SizedBox(width: 8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Juliana Silva',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        Text(
                          '12:43 - 29/03/2026',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Text(
                  'SEMANA DE PESQUISA CLASSMANEGER',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                  style: TextStyle(fontSize: 14, height: 1.4),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 4.0,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade400),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.account_circle_outlined, color: Colors.grey),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(vertical: 6),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.send_outlined, color: Colors.grey, size: 20),
                        onPressed: () {},
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMembrosTab() {
    final professores = ['Juliana Silva', 'Calo Castro', 'Moacir Azevedo'];
    final alunos = [
      'Gabriel Touro',
      'João Jonas',
      'Daniel Lima',
      'Agrípino Alves',
      'Kacque Hornok',
      'Paulo Jordan',
      'Anglair Reis',
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Professores/Monitores:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...professores.map(
            (professor) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 32,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    professor,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Alunos:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 12),
          ...alunos.map(
            (aluno) => Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEEEE),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.account_circle,
                    size: 32,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    aluno,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAbaItem(String label, {required int index}) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _abaAtiva = index;
          });
        },
        child: Container(
          height: 45,
          decoration: BoxDecoration(
            color: _abaAtiva == index
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