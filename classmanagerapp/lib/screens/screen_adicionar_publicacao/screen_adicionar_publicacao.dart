import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/mural_service.dart';

class AdicionarPublicacaoScreen extends StatefulWidget {
  final String disciplinaId;

  const AdicionarPublicacaoScreen({super.key, required this.disciplinaId});

  @override
  State<AdicionarPublicacaoScreen> createState() => _AdicionarPublicacaoScreenState();
}

class _AdicionarPublicacaoScreenState extends State<AdicionarPublicacaoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _conteudoController = TextEditingController();
  final _muralService = MuralService();
  bool _isLoading = false;

  @override
  void dispose() {
    _tituloController.dispose();
    _conteudoController.dispose();
    super.dispose();
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final user = FirebaseAuth.instance.currentUser;
      final publicacao = Publicacao(
        autorNome: user?.displayName ?? 'Usuário',
        autorId: user?.uid ?? '',
        titulo: _tituloController.text,
        conteudo: _conteudoController.text,
        data: DateTime.now(),
        disciplinaId: widget.disciplinaId,
      );

      await _muralService.criarPublicacao(publicacao);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao salvar: $e')),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Nova Publicação',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF0569FF),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'O que você deseja compartilhar?',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Título Field
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextFormField(
                    controller: _tituloController,
                    decoration: const InputDecoration(
                      hintText: 'Título da publicação',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: InputBorder.none,
                    ),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    validator: (value) => value == null || value.isEmpty ? 'Obrigatório' : null,
                  ),
                ),
                const SizedBox(height: 16),

                // Conteúdo Field
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F2F2),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: TextFormField(
                    controller: _conteudoController,
                    decoration: const InputDecoration(
                      hintText: 'Escreva aqui o conteúdo...',
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      border: InputBorder.none,
                    ),
                    maxLines: 8,
                    validator: (value) => value == null || value.isEmpty ? 'Obrigatório' : null,
                  ),
                ),
                const SizedBox(height: 30),

                // Botão Publicar
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _salvar,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0569FF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white) 
                        : const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Publicar agora',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 8),
                              Icon(Icons.send, color: Colors.white, size: 20),
                            ],
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
