import 'package:flutter/material.dart';

import '../screen_atividade_aluno/atividade_aluno_model.dart';

class EntregaAtividadeAlunoScreen extends StatefulWidget {
  final String nomeDisciplina;
  final AtividadeAluno atividade;

  const EntregaAtividadeAlunoScreen({
    super.key,
    required this.nomeDisciplina,
    required this.atividade,
  });

  @override
  State<EntregaAtividadeAlunoScreen> createState() =>
      _EntregaAtividadeAlunoScreenState();
}

class _EntregaAtividadeAlunoScreenState
    extends State<EntregaAtividadeAlunoScreen> {
  static const Color _blueColor = Color(0xFF0569FF);
  static const Color _lightCyan = Color(0xFFE2FCFF);

  bool _concluida = false;
  final List<String> _trabalhos = [];

  void _adicionarTrabalho() {
    setState(() {
      _trabalhos.add('Trabalho ${_trabalhos.length + 1}.pdf');
    });
  }

  void _marcarComoConcluido() {
    setState(() {
      _concluida = !_concluida;
    });
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
        title: Text(
          widget.nomeDisciplina,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 26),
                  _buildPrazo(),
                  const SizedBox(height: 16),
                  _buildDescricao(),
                  const SizedBox(height: 22),
                  _buildListaOrientacoes(),
                  const SizedBox(height: 24),
                  if (_concluida) _buildConcluidoAviso(),
                ],
              ),
            ),
          ),
          _buildAreaTrabalhos(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        widget.atividade.turma,
        style: const TextStyle(
          fontSize: 26,
          color: Colors.black,
          fontWeight: FontWeight.w700,
          fontFamily: 'serif',
        ),
      ),
    );
  }

  Widget _buildPrazo() {
    return Text(
      'PRAZO: ${widget.atividade.prazo}',
      style: const TextStyle(
        fontSize: 13,
        color: Colors.black,
        fontWeight: FontWeight.w600,
        fontFamily: 'serif',
      ),
    );
  }

  Widget _buildDescricao() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.atividade.titulo,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontFamily: 'serif',
          ),
        ),
        const SizedBox(height: 24),
        Text(
          widget.atividade.descricao,
          style: const TextStyle(
            fontSize: 13,
            color: Colors.black,
            fontWeight: FontWeight.w700,
            height: 1.6,
            fontFamily: 'serif',
          ),
        ),
      ],
    );
  }

  Widget _buildListaOrientacoes() {
    const itens = ['LOREM', 'LOREM', 'LOREM', 'LOREM'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: itens
          .map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 7.0),
              child: Text(
                '- $item',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'serif',
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  Widget _buildConcluidoAviso() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE7F6EC),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Text(
        'Atividade marcada como concluida.',
        style: TextStyle(color: Color(0xFF247A3D), fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildAreaTrabalhos() {
    return Container(
      width: double.infinity,
      color: _lightCyan,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Seus trabalhos',
              style: TextStyle(
                color: Colors.black87,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                fontFamily: 'serif',
              ),
            ),
            if (_trabalhos.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _trabalhos
                    .map(
                      (trabalho) => Chip(
                        label: Text(trabalho),
                        avatar: const Icon(
                          Icons.description_outlined,
                          size: 18,
                        ),
                        backgroundColor: Colors.white,
                        visualDensity: VisualDensity.compact,
                      ),
                    )
                    .toList(),
              ),
            ],
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: _buildAcaoButton(
                    label: 'Adicionar Trabalho',
                    icon: Icons.add,
                    color: const Color(0xFF666666),
                    onPressed: _adicionarTrabalho,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildAcaoButton(
                    label: _concluida ? 'Concluido' : 'Marcar como concluido',
                    icon: _concluida ? Icons.check : null,
                    color: _blueColor,
                    onPressed: _marcarComoConcluido,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAcaoButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
    IconData? icon,
  }) {
    return SizedBox(
      height: 42,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          elevation: 4,
          shadowColor: Colors.black.withValues(alpha: 0.35),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
        ),
        onPressed: onPressed,
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'serif',
                ),
              ),
              if (icon != null) ...[
                const SizedBox(width: 6),
                Icon(icon, color: Colors.white, size: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
