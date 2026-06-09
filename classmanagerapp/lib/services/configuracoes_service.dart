import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ConfiguracoesUsuario {
  final bool notificacoesAtivas;

  const ConfiguracoesUsuario({required this.notificacoesAtivas});

  factory ConfiguracoesUsuario.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    return ConfiguracoesUsuario(
      notificacoesAtivas: data['notificacoesAtivas'] ?? false,
    );
  }
}

class ConfiguracoesService {
  ConfiguracoesService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _db = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  String get _usuarioId => _auth.currentUser?.uid ?? 'sem-login';

  DocumentReference<Map<String, dynamic>> get _configRef =>
      _db.collection('Configuracoes').doc(_usuarioId);

  Stream<ConfiguracoesUsuario> assistirConfiguracoes() {
    return _configRef.snapshots().map((doc) {
      if (!doc.exists) {
        return const ConfiguracoesUsuario(notificacoesAtivas: false);
      }
      return ConfiguracoesUsuario.fromFirestore(doc);
    });
  }

  Future<void> atualizarNotificacoes(bool ativa) {
    return _configRef.set({
      'usuarioId': _usuarioId,
      'notificacoesAtivas': ativa,
      'atualizadoEm': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }
}
