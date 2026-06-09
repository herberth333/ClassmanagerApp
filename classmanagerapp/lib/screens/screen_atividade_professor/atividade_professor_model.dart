import 'package:cloud_firestore/cloud_firestore.dart';

class AtividadeProfessor {
  final String? id;
  final String turma;
  final String titulo;
  final String prazo;
  final String descricao;
  final int entregues;
  final int totalAlunos;
  final DateTime? criadoEm;

  const AtividadeProfessor({
    this.id,
    required this.turma,
    required this.titulo,
    required this.prazo,
    required this.descricao,
    required this.entregues,
    required this.totalAlunos,
    this.criadoEm,
  });

  // Converter para Map para salvar no Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'turma': turma,
      'titulo': titulo,
      'prazo': prazo,
      'descricao': descricao,
      'entregues': entregues,
      'totalAlunos': totalAlunos,
      'criadoEm': criadoEm ?? DateTime.now(),
    };
  }

  // Converter de DocumentSnapshot do Firestore
  factory AtividadeProfessor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return AtividadeProfessor(
      id: doc.id,
      turma: data['turma'] ?? '',
      titulo: data['titulo'] ?? '',
      prazo: data['prazo'] ?? '',
      descricao: data['descricao'] ?? '',
      entregues: data['entregues'] ?? 0,
      totalAlunos: data['totalAlunos'] ?? 0,
      criadoEm: data['criadoEm'] != null
          ? (data['criadoEm'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Copiar com alterações
  AtividadeProfessor copyWith({
    String? id,
    String? turma,
    String? titulo,
    String? prazo,
    String? descricao,
    int? entregues,
    int? totalAlunos,
    DateTime? criadoEm,
  }) {
    return AtividadeProfessor(
      id: id ?? this.id,
      turma: turma ?? this.turma,
      titulo: titulo ?? this.titulo,
      prazo: prazo ?? this.prazo,
      descricao: descricao ?? this.descricao,
      entregues: entregues ?? this.entregues,
      totalAlunos: totalAlunos ?? this.totalAlunos,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }
}

const List<AtividadeProfessor> atividadesProfessorMock = [
  AtividadeProfessor(
    turma: 'Class 0001',
    titulo: 'Atividade X - Entrega Final',
    prazo: 'jan. 01, 23:00',
    descricao:
        'Mauris at hendrerit orci, non porttitor augue. Fusce fermentum mi et felis volutpat, at congue lectus placerat.',
    entregues: 24,
    totalAlunos: 32,
  ),
  AtividadeProfessor(
    turma: 'Class 0002',
    titulo: 'Lista de Limites',
    prazo: 'jan. 05, 18:45',
    descricao: 'Resolva os exercicios propostos e envie em PDF unico.',
    entregues: 18,
    totalAlunos: 30,
  ),
  AtividadeProfessor(
    turma: 'Class 0003',
    titulo: 'Trabalho de Derivadas',
    prazo: 'jan. 08, 20:30',
    descricao: 'Entrega individual com desenvolvimento completo das questoes.',
    entregues: 9,
    totalAlunos: 28,
  ),
];
