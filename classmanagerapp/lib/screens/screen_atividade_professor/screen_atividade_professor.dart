import 'package:flutter/material.dart';

import '../screen_adicionar_atividade/screen_adicionar_atividade.dart';
import '../screen_horarios/screen_horarios.dart';
import 'atividade_professor_model.dart';

class AtividadeProfessorScreen extends StatefulWidget {
  final String nomeDisciplina;

  const AtividadeProfessorScreen({
    super.key,
    this.nomeDisciplina = 'Calculo 1',
  });

  @override
  State<AtividadeProfessorScreen> createState() =>
      _AtividadeProfessorScreenState();
}

class _AtividadeProfessorScreenState extends State<AtividadeProfessorScreen> {
  static const Color _blueColor = Color(0xFF0569FF);

  final List<AtividadeProfessor> _atividades = [...atividadesProfessorMock];

  int get _totalEntregas {
    return _atividades.fold(
      0,
      (total, atividade) => total + atividade.entregues,
    );
  }

  Future<void> _abrirAdicionarAtividade() async {
    final atividade = await Navigator.push<AtividadeProfessor>(
      context,
      MaterialPageRoute(
        builder: (context) =>
            AdicionarAtividadeScreen(nomeDisciplina: widget.nomeDisciplina),
      ),
    );

    if (atividade == null) {
      return;
    }

    setState(() {
      _atividades.insert(0, atividade);
    });

    if (!mounted) {
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Atividade criada com sucesso.')),
    );
  }

  void _abrirHorarios() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HorariosScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _blueColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Atividade Professor',
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
              Icons.calendar_month_outlined,
              color: Colors.white,
              size: 26,
            ),
            onPressed: _abrirHorarios,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildResumo(),
                  const SizedBox(height: 18),
                  const Text(
                    'ATIVIDADES PUBLICADAS:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'serif',
                    ),
                  ),
                  const SizedBox(height: 10),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _atividades.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return _AtividadeProfessorCard(
                        atividade: _atividades[index],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildResumo() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F8FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.nomeDisciplina,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildResumoItem(
                  label: 'Atividades',
                  value: _atividades.length.toString(),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: _buildResumoItem(
                  label: 'Entregas',
                  value: _totalEntregas.toString(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResumoItem({required String label, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              color: Colors.black54,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomAction() {
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 14),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 50,
          child: ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: _blueColor,
              elevation: 4,
              shadowColor: Colors.black.withValues(alpha: 0.25),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: _abrirAdicionarAtividade,
            icon: const Icon(Icons.add_circle_outline, color: Colors.white),
            label: const Text(
              'Adicionar Atividade',
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AtividadeProfessorCard extends StatelessWidget {
  final AtividadeProfessor atividade;

  const _AtividadeProfessorCard({required this.atividade});

  @override
  Widget build(BuildContext context) {
    final entregas = atividade.totalAlunos == 0
        ? 'Sem alunos vinculados'
        : '${atividade.entregues}/${atividade.totalAlunos} entregas';

    return Material(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(16),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.35),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    atividade.turma,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    entregas,
                    style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              '${atividade.prazo} - ${atividade.titulo}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              atividade.descricao,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.black87,
                fontSize: 12,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
