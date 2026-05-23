import 'package:flutter/material.dart';

class CriarAtividadeScreen extends StatefulWidget {
  final String nomeDisciplina;

  const CriarAtividadeScreen({super.key, required this.nomeDisciplina});

  @override
  State<CriarAtividadeScreen> createState() => _CriarAtividadeScreenState();
}

class _CriarAtividadeScreenState extends State<CriarAtividadeScreen> {
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  String? _nomeAnexo; // REMOVER DEPOIS (NABAL)

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0569FF), 
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 28), 
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Criar atividade',
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF0569FF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                elevation: 0,
              ),
              onPressed: () {
                if (_tituloController.text.isNotEmpty) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Atividade criada com sucesso!')),
                  );
                }
              },
              child: const Text('Criar', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Para: ${widget.nomeDisciplina}',
              style: TextStyle(color: Colors.grey.shade600, fontSize: 14, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 24),

            TextField(
              controller: _tituloController,
              style: const TextStyle(fontSize: 18),
              decoration: InputDecoration(
                labelText: 'Título da atividade',
                labelStyle: const TextStyle(color: Color(0xFF0569FF)),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF0569FF), width: 2),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey.shade400),
                ),
              ),
            ),
            const SizedBox(height: 32),

            TextField(
              controller: _descricaoController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Instruções (opcional)',
                labelStyle: const TextStyle(color: Color(0xFF0569FF)),
                alignLabelWithHint: true,
                filled: true,
                fillColor: const Color(0xFFEEEEEE),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 32),

            const Text(
              'Anexos',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87),
            ),
            const SizedBox(height: 12),

            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Color(0xFF0569FF), width: 1.5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              onPressed: () {
                setState(() {
                  _nomeAnexo = 'Plano_de_Aula_${widget.nomeDisciplina.replaceAll(' ', '_')}.pdf';
                });
              },
              icon: const Icon(Icons.attach_file, color: Color(0xFF0569FF)),
              label: const Text(
                'Adicionar anexo ou documento',
                style: TextStyle(color: Color(0xFF0569FF), fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),

            if (_nomeAnexo != null) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.picture_as_pdf, color: Colors.red),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _nomeAnexo!,
                        style: const TextStyle(fontWeight: FontWeight.w500, overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          _nomeAnexo = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}