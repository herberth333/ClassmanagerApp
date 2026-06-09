import 'package:flutter/material.dart';

import 'atividade_aluno_model.dart';
import '../screen_entrega_atividade_aluno/screen_entrega_atividade_aluno.dart';
import '../../services/atividade_aluno_service.dart';

class AtividadeAlunoScreen extends StatelessWidget {
  final String nomeDisciplina;
  final String disciplinaId;

  const AtividadeAlunoScreen({
    super.key,
    this.nomeDisciplina = 'Calculo 1',
    this.disciplinaId = 'calculo1',
  });

  static const Color _blueColor = Color(0xFF0569FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _blueColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.home_outlined, color: Colors.white, size: 28),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          nomeDisciplina,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: AtividadeAlunoContent(
          nomeDisciplina: nomeDisciplina,
          disciplinaId: disciplinaId,
        ),
      ),
    );
  }
}

class AtividadeAlunoContent extends StatefulWidget {
  final String nomeDisciplina;
  final String disciplinaId;

  const AtividadeAlunoContent({
    super.key,
    required this.nomeDisciplina,
    this.disciplinaId = 'calculo1',
  });

  @override
  State<AtividadeAlunoContent> createState() => _AtividadeAlunoContentState();
}

class _AtividadeAlunoContentState extends State<AtividadeAlunoContent> {
  final AtividadeAlunoService _service = AtividadeAlunoService();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 4.0, bottom: 8.0),
          child: Text(
            'PROXIMAS ENTREGAS:',
            style: TextStyle(
              color: Colors.black,
              fontSize: 13,
              fontWeight: FontWeight.w700,
              fontFamily: 'serif',
            ),
          ),
        ),
        StreamBuilder<List<AtividadeAluno>>(
          stream: _service.assistirAtividades(widget.disciplinaId),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Erro ao carregar atividades: ${snapshot.error}');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            final atividades = snapshot.data ?? [];

            if (atividades.isEmpty) {
              return const Text('Nenhuma atividade encontrada.');
            }

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: atividades.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final atividade = atividades[index];

                return AtividadeCard(
                  atividade: atividade,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EntregaAtividadeAlunoScreen(
                          nomeDisciplina: widget.nomeDisciplina,
                          atividade: atividade,
                        ),
                      ),
                    );
                  },
                );
              },
            );
          },
        ),
      ],
    );
  }
}

class AtividadeCard extends StatelessWidget {
  final AtividadeAluno atividade;
  final VoidCallback onTap;

  const AtividadeCard({
    super.key,
    required this.atividade,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(16),
      elevation: 3,
      shadowColor: Colors.black.withValues(alpha: 0.35),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: double.infinity,
          constraints: const BoxConstraints(minHeight: 64),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                atividade.turma,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
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
            ],
          ),
        ),
      ),
    );
  }
}
