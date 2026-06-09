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

  Stream<List<Aluno>> getAllAlunos() {
    return _db
        .collectionGroup('Aluno')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Aluno.fromFirestore(doc)).toList());
  }
}
