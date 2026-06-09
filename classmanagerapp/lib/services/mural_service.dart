import 'package:cloud_firestore/cloud_firestore.dart';

class Publicacao {
  final String? id;
  final String autorNome;
  final String autorId;
  final String titulo;
  final String conteudo;
  final DateTime data;
  final String disciplinaId;

  Publicacao({
    this.id,
    required this.autorNome,
    required this.autorId,
    required this.titulo,
    required this.conteudo,
    required this.data,
    required this.disciplinaId,
  });

  Map<String, dynamic> toFirestore() {
    return {
      'autorNome': autorNome,
      'autorId': autorId,
      'titulo': titulo,
      'conteudo': conteudo,
      'data': Timestamp.fromDate(data),
      'disciplinaId': disciplinaId,
    };
  }

  factory Publicacao.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Publicacao(
      id: doc.id,
      autorNome: data['autorNome'] ?? '',
      autorId: data['autorId'] ?? '',
      titulo: data['titulo'] ?? '',
      conteudo: data['conteudo'] ?? '',
      data: (data['data'] as Timestamp).toDate(),
      disciplinaId: data['disciplinaId'] ?? '',
    );
  }
}

class MuralService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference get _muralRef => _db.collection('Mural');

  Stream<List<Publicacao>> getPublicacoes(String disciplinaId) {
    return _muralRef
        .where('disciplinaId', isEqualTo: disciplinaId)
        .snapshots()
        .map((snapshot) {
      final list = snapshot.docs.map((doc) => Publicacao.fromFirestore(doc)).toList();
      list.sort((a, b) => b.data.compareTo(a.data));
      return list;
    });
  }

  Future<void> criarPublicacao(Publicacao publicacao) async {
    await _muralRef.add(publicacao.toFirestore());
  }
}
