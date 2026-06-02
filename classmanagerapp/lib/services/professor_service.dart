import 'package:cloud_firestore/cloud_firestore.dart';

class Professor {
  final String id;
  final String nome;

  Professor({required this.id, required this.nome});

  factory Professor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Professor(
      id: doc.id,
      nome: data['nome'] ?? 'Sem nome',
    );
  }
}

class ProfessorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Professor>> getAllProfessores() {
    return _db
        .collectionGroup('Professor')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Professor.fromFirestore(doc)).toList());
  }
}
