import 'package:cloud_firestore/cloud_firestore.dart';

class Aluno {
  final String id;
  final String nome;

  Aluno({required this.id, required this.nome});

  factory Aluno.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Aluno(
      id: doc.id,
      nome: data['nome'] ?? 'Sem nome',
    );
  }
}

class AlunoService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Se você quiser buscar alunos de uma Pessoa específica:
  Stream<List<Aluno>> getAlunos(String pessoaId) {
    return _db
        .collection('Pessoa')
        .doc(pessoaId)
        .collection('Aluno')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Aluno.fromFirestore(doc)).toList());
  }

  // Se você quiser buscar TODOS os alunos de todas as pessoas (Collection Group):
  Stream<List<Aluno>> getAllAlunos() {
    return _db
        .collectionGroup('Aluno')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Aluno.fromFirestore(doc)).toList());
  }
}
