import 'package:flutter/material.dart';
import '../../services/aluno_service.dart';
import '../../services/professor_service.dart';
import '../../services/monitor_service.dart';

class MembrosScreen extends StatelessWidget {
  MembrosScreen({super.key});

  final AlunoService _alunoService = AlunoService();
  final ProfessorService _professorService = ProfessorService();
  final MonitorService _monitorService = MonitorService();

  static const Color _blueColor = Color(0xFF0569FF);
  static const Color _grayColor = Color(0xFF595959);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _blueColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.home_outlined, color: Colors.white, size: 28),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Membros',
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
          _buildTabs(),
          const SizedBox(height: 30),

          // Seção: Professores
          _buildSectionTitle('Professores:'),
          StreamBuilder<List<Professor>>(
            stream: _professorService.getAllProfessores(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Erro: ${snapshot.error}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final list = snapshot.data ?? [];
              if (list.isEmpty) return const Text('Nenhum professor encontrado.');
              return Column(
                children: list.map((p) => _buildListItem(p.nome)).toList(),
              );
            },
          ),

          const SizedBox(height: 20),

          // Seção: Monitores
          _buildSectionTitle('Monitores:'),
          StreamBuilder<List<Monitor>>(
            stream: _monitorService.getAllMonitores(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Erro: ${snapshot.error}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final list = snapshot.data ?? [];
              if (list.isEmpty) return const Text('Nenhum monitor encontrado.');
              return Column(
                children: list.map((m) => _buildListItem(m.nome)).toList(),
              );
            },
          ),

          const SizedBox(height: 20),

          // Seção: Alunos
          _buildSectionTitle('Alunos:'),
          StreamBuilder<List<Aluno>>(
            stream: _alunoService.getAllAlunos(),
            builder: (context, snapshot) {
              if (snapshot.hasError) return Text('Erro: ${snapshot.error}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              final list = snapshot.data ?? [];
              if (list.isEmpty) return const Text('Nenhum aluno encontrado.');
              return Column(
                children: list.map((a) => _buildListItem(a.nome)).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

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
          Container(
            width: 34,
            height: 34,
            decoration: const BoxDecoration(
              color: Color(0xFFE0E0E0), 
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.person,
              color: Color(0xFF757575), 
              size: 22,
            ),
          ),
          const SizedBox(width: 15),
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
