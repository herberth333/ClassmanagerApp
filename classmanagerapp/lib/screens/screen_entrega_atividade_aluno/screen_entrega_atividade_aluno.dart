import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import '../screen_atividade_aluno/atividade_aluno_model.dart';
import '../../services/atividade_aluno_service.dart';

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

  final AtividadeAlunoService _service = AtividadeAlunoService();
  bool _anexando = false;
  bool _salvandoConclusao = false;

  Future<void> _adicionarTrabalho() async {
    final resultado = await FilePicker.pickFiles(
      allowMultiple: false,
      withData: true,
    );

    final arquivo = resultado?.files.single;

    if (arquivo == null) {
      return;
    }

    setState(() => _anexando = true);

    try {
      await _service.anexarTrabalho(
        atividadeId: widget.atividade.id,
        nomeArquivo: arquivo.name,
        tamanho: arquivo.size,
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao anexar arquivo: $error')));
    } finally {
      if (mounted) {
        setState(() => _anexando = false);
      }
    }
  }

  void _abrirArquivo(TrabalhoAtividadeAluno trabalho) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Arquivo registrado no Firestore. Para abrir o arquivo real, precisa ativar Firebase Storage.',
        ),
      ),
    );
  }

  Future<void> _marcarComoConcluido(bool concluidaAtual) async {
    setState(() => _salvandoConclusao = true);

    try {
      await _service.alternarConclusao(
        atividadeId: widget.atividade.id,
        concluida: !concluidaAtual,
      );
    } catch (error) {
      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao atualizar conclusao: $error')),
      );
    } finally {
      if (mounted) {
        setState(() => _salvandoConclusao = false);
      }
    }
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
      body: StreamBuilder<EntregaAtividadeAluno>(
        stream: _service.assistirEntrega(widget.atividade.id),
        builder: (context, snapshot) {
          final entrega =
              snapshot.data ?? EntregaAtividadeAluno.vazia(widget.atividade.id);

          return Column(
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
                      if (entrega.concluida) _buildConcluidoAviso(),
                    ],
                  ),
                ),
              ),
              _buildAreaTrabalhos(entrega),
            ],
          );
        },
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
    final itens = widget.atividade.orientacoes.isEmpty
        ? ['Sem orientacoes cadastradas.']
        : widget.atividade.orientacoes;

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

  Widget _buildAreaTrabalhos(EntregaAtividadeAluno entrega) {
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
            if (entrega.trabalhos.isNotEmpty) ...[
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: entrega.trabalhos.map(_buildTrabalhoChip).toList(),
              ),
            ],
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: _buildAcaoButton(
                    label: _anexando ? 'Anexando...' : 'Adicionar Trabalho',
                    icon: Icons.add,
                    color: const Color(0xFF666666),
                    onPressed: _anexando ? null : _adicionarTrabalho,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _buildAcaoButton(
                    label: _salvandoConclusao
                        ? 'Salvando...'
                        : entrega.concluida
                        ? 'Concluido'
                        : 'Marcar como concluido',
                    icon: entrega.concluida ? Icons.check : null,
                    color: _blueColor,
                    onPressed: _salvandoConclusao
                        ? null
                        : () => _marcarComoConcluido(entrega.concluida),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTrabalhoChip(TrabalhoAtividadeAluno trabalho) {
    return ActionChip(
      label: Text(trabalho.nome),
      avatar: const Icon(Icons.description_outlined, size: 18),
      backgroundColor: Colors.white,
      visualDensity: VisualDensity.compact,
      onPressed: () => _abrirArquivo(trabalho),
    );
  }

  Widget _buildAcaoButton({
    required String label,
    required Color color,
    required VoidCallback? onPressed,
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
