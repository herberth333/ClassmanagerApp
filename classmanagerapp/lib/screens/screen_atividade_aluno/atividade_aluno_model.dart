import 'package:cloud_firestore/cloud_firestore.dart';

class AtividadeAluno {
  final String id;
  final String disciplina;
  final String turma;
  final String titulo;
  final String prazo;
  final String descricao;
  final List<String> orientacoes;

  const AtividadeAluno({
    required this.id,
    required this.disciplina,
    required this.turma,
    required this.titulo,
    required this.prazo,
    required this.descricao,
    required this.orientacoes,
  });

  factory AtividadeAluno.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final orientacoes = data['orientacoes'];

    return AtividadeAluno(
      id: doc.id,
      disciplina: data['disciplina'] ?? data['disciplinaId'] ?? 'Calculo 1',
      turma: data['turma'] ?? 'Sem turma',
      titulo: data['titulo'] ?? 'Sem titulo',
      prazo: data['prazo'] ?? 'Sem prazo',
      descricao: data['descricao'] ?? '',
      orientacoes: orientacoes is List
          ? orientacoes.map((item) => item.toString()).toList()
          : const [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'disciplina': disciplina,
      'turma': turma,
      'titulo': titulo,
      'prazo': prazo,
      'descricao': descricao,
      'orientacoes': orientacoes,
      'tipo': 'aluno',
      'criadoEm': FieldValue.serverTimestamp(),
    };
  }
}
