class AtividadeAluno {
  final String turma;
  final String titulo;
  final String prazo;
  final String descricao;

  const AtividadeAluno({
    required this.turma,
    required this.titulo,
    required this.prazo,
    required this.descricao,
  });
}

const List<AtividadeAluno> atividadesAlunoMock = [
  AtividadeAluno(
    turma: 'Class 0001',
    titulo: 'Atividade X - Entrega Final',
    prazo: 'jan. 01, 23:00',
    descricao:
        'Mauris at hendrerit orci, non porttitor augue. Fusce fermentum mi et felis volutpat, at congue lectus placerat.',
  ),
  AtividadeAluno(
    turma: 'Class 0002',
    titulo: 'Lista de Limites',
    prazo: 'jan. 05, 18:45',
    descricao: 'Resolva os exercicios propostos e envie em PDF unico.',
  ),
  AtividadeAluno(
    turma: 'Class 0003',
    titulo: 'Trabalho de Derivadas',
    prazo: 'jan. 08, 20:30',
    descricao: 'Entrega individual com desenvolvimento completo das questoes.',
  ),
  AtividadeAluno(
    turma: 'Class 0004',
    titulo: 'Resumo da Aula',
    prazo: 'jan. 12, 23:00',
    descricao: 'Envie um resumo com os principais conceitos vistos em sala.',
  ),
  AtividadeAluno(
    turma: 'Class 0005',
    titulo: 'Exercicios Complementares',
    prazo: 'jan. 16, 21:15',
    descricao: 'Atividade complementar para revisao da unidade.',
  ),
  AtividadeAluno(
    turma: 'Class 0006',
    titulo: 'Projeto Final',
    prazo: 'jan. 20, 23:59',
    descricao: 'Entrega final do projeto com arquivo e observacoes do aluno.',
  ),
];
