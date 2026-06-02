class AtividadeProfessor {
  final String turma;
  final String titulo;
  final String prazo;
  final String descricao;
  final int entregues;
  final int totalAlunos;

  const AtividadeProfessor({
    required this.turma,
    required this.titulo,
    required this.prazo,
    required this.descricao,
    required this.entregues,
    required this.totalAlunos,
  });
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
