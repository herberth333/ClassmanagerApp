import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/atividade_service.dart';
import '../screen_atividade_professor/atividade_professor_model.dart';

class AdicionarAtividadeScreen extends StatefulWidget {
  final String nomeDisciplina;
  final String disciplinaId;
  final String pessoaId;

  const AdicionarAtividadeScreen({
    super.key,
    required this.nomeDisciplina,
    this.disciplinaId = 'calculo1',
    String? pessoaId,
  }) : pessoaId = pessoaId ?? '';

  @override
  State<AdicionarAtividadeScreen> createState() =>
      _AdicionarAtividadeScreenState();
}

class _AdicionarAtividadeScreenState extends State<AdicionarAtividadeScreen> {
  static const Color _blueColor = Color(0xFF0569FF);

  final _formKey = GlobalKey<FormState>();
  final _turmaController = TextEditingController();
  final _tituloController = TextEditingController();
  final _prazoController = TextEditingController();
  final _descricaoController = TextEditingController();
  
  final AtividadeService _atividadeService = AtividadeService();
  bool _isLoading = false;
  late String _pessoaId;

  @override
  void initState() {
    super.initState();
    _pessoaId = widget.pessoaId.isEmpty
        ? (FirebaseAuth.instance.currentUser?.uid ?? '')
        : widget.pessoaId;
  }

  @override
  void dispose() {
    _turmaController.dispose();
    _tituloController.dispose();
    _prazoController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  Future<void> _salvarAtividade() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final atividade = AtividadeProfessor(
        turma: _turmaController.text.trim(),
        titulo: _tituloController.text.trim(),
        prazo: _prazoController.text.trim(),
        descricao: _descricaoController.text.trim(),
        entregues: 0,
        totalAlunos: 0,
      );

      await _atividadeService.criarAtividade(
        _pessoaId,
        widget.disciplinaId,
        atividade,
      );

      if (!mounted) return;

      Navigator.pop(context, atividade);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Atividade salva no Firebase!')),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao salvar: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
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
        title: const Text(
          'Adicionar Atividade',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDisciplinaHeader(),
              const SizedBox(height: 22),
              _buildLabel('Turma:'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _turmaController,
                hintText: 'Class 0001',
              ),
              const SizedBox(height: 18),
              _buildLabel('Titulo da atividade:'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _tituloController,
                hintText: 'Atividade X - Entrega Final',
              ),
              const SizedBox(height: 18),
              _buildLabel('Prazo:'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _prazoController,
                hintText: 'jan. 01, 23:00',
              ),
              const SizedBox(height: 18),
              _buildLabel('Descricao:'),
              const SizedBox(height: 8),
              _buildTextField(
                controller: _descricaoController,
                hintText: 'Digite as orientacoes da atividade',
                maxLines: 6,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _blueColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: _isLoading ? null : _salvarAtividade,
                  icon: _isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                      : const Icon(Icons.add_circle_outline),
                  label: Text(
                    _isLoading ? 'Salvando...' : 'Criar atividade',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDisciplinaHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F8FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        widget.nomeDisciplina,
        style: const TextStyle(
          color: Colors.black87,
          fontSize: 18,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Campo obrigatorio';
        }

        return null;
      },
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: _blueColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
        ),
      ),
    );
  }
}