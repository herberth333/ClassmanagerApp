import 'package:cloud_firestore/cloud_firestore.dart';

class Monitor {
  final String id;
  final String nome;

  Monitor({required this.id, required this.nome});

  factory Monitor.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Monitor(
      id: doc.id,
      nome: data['nome'] ?? 'Sem nome',
    );
  }
}

class MonitorService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Monitor>> getAllMonitores() {
    return _db
        .collectionGroup('Monitor')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Monitor.fromFirestore(doc)).toList());
  }
}
