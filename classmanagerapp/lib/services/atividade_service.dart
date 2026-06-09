import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/screen_atividade_professor/atividade_professor_model.dart';

class AtividadeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _atividadesRef =>
      _db.collection('AtividadeProfessor');

  String _idObrigatorio(String id, String campo) {
    final valor = id.trim();
    if (valor.isEmpty) {
      throw ArgumentError('$campo nao pode estar vazio');
    }
    return valor;
  }

  /// Obter todas as atividades de uma disciplina de uma pessoa
  Stream<List<AtividadeProfessor>> getAtividadesDisciplina(
    String pessoaId,
    String disciplinaId,
  ) {
    final pessoa = _idObrigatorio(pessoaId, 'pessoaId');
    final disciplina = _idObrigatorio(disciplinaId, 'disciplinaId');

    return _atividadesRef
        .where('pessoaId', isEqualTo: pessoa)
        .where('disciplinaId', isEqualTo: disciplina)
        .where('tipo', isEqualTo: 'professor')
        .snapshots()
        .map((snapshot) {
          final atividades = snapshot.docs
              .map((doc) => AtividadeProfessor.fromFirestore(doc))
              .toList();
          atividades.sort((a, b) {
            final criadoA =
                a.criadoEm ?? DateTime.fromMillisecondsSinceEpoch(0);
            final criadoB =
                b.criadoEm ?? DateTime.fromMillisecondsSinceEpoch(0);
            return criadoB.compareTo(criadoA);
          });
          return atividades;
        });
  }

  /// Criar uma nova atividade
  Future<String> criarAtividade(
    String pessoaId,
    String disciplinaId,
    AtividadeProfessor atividade,
  ) async {
    try {
      final pessoa = _idObrigatorio(pessoaId, 'pessoaId');
      final disciplina = _idObrigatorio(disciplinaId, 'disciplinaId');
      final docRef = _atividadesRef.doc();

      await docRef
          .set({
            ...atividade.toFirestore(),
            'pessoaId': pessoa,
            'disciplinaId': disciplina,
            'tipo': 'professor',
            'criadoEm': FieldValue.serverTimestamp(),
          }, SetOptions(merge: true))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () =>
                throw Exception('A atividade nao foi salva no Firestore.'),
          );

      return docRef.id;
    } catch (e) {
      throw Exception('Erro ao criar atividade: $e');
    }
  }

  /// Atualizar uma atividade existente
  Future<void> atualizarAtividade(
    String pessoaId,
    String disciplinaId,
    String atividadeId,
    AtividadeProfessor atividade,
  ) async {
    try {
      final pessoa = _idObrigatorio(pessoaId, 'pessoaId');
      final disciplina = _idObrigatorio(disciplinaId, 'disciplinaId');
      await _atividadesRef.doc(atividadeId).update({
        ...atividade.toFirestore(),
        'pessoaId': pessoa,
        'disciplinaId': disciplina,
        'tipo': 'professor',
      });
    } catch (e) {
      throw Exception('Erro ao atualizar atividade: $e');
    }
  }

  /// Deletar uma atividade
  Future<void> deletarAtividade(
    String pessoaId,
    String disciplinaId,
    String atividadeId,
  ) async {
    try {
      _idObrigatorio(pessoaId, 'pessoaId');
      _idObrigatorio(disciplinaId, 'disciplinaId');
      await _atividadesRef.doc(atividadeId).delete();
    } catch (e) {
      throw Exception('Erro ao deletar atividade: $e');
    }
  }

  /// Obter uma atividade específica
  Future<AtividadeProfessor?> obterAtividade(
    String pessoaId,
    String disciplinaId,
    String atividadeId,
  ) async {
    try {
      _idObrigatorio(pessoaId, 'pessoaId');
      _idObrigatorio(disciplinaId, 'disciplinaId');
      final doc = await _atividadesRef.doc(atividadeId).get();

      if (doc.exists) {
        return AtividadeProfessor.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao obter atividade: $e');
    }
  }

  /// Obter todas as atividades de todas as disciplinas de uma pessoa
  Stream<List<AtividadeProfessor>> getTodasAsAtividades(String pessoaId) {
    final pessoa = _idObrigatorio(pessoaId, 'pessoaId');

    return _db
        .collection('AtividadeProfessor')
        .where('pessoaId', isEqualTo: pessoa)
        .where('tipo', isEqualTo: 'professor')
        .snapshots()
        .map((snapshot) {
          final atividades = snapshot.docs
              .map((doc) => AtividadeProfessor.fromFirestore(doc))
              .toList();
          atividades.sort((a, b) {
            final criadoA =
                a.criadoEm ?? DateTime.fromMillisecondsSinceEpoch(0);
            final criadoB =
                b.criadoEm ?? DateTime.fromMillisecondsSinceEpoch(0);
            return criadoB.compareTo(criadoA);
          });
          return atividades;
        });
  }

  /// Atualizar contagem de entregas de uma atividade
  Future<void> atualizarEntregas(
    String pessoaId,
    String disciplinaId,
    String atividadeId,
    int novaContagem,
  ) async {
    try {
      _idObrigatorio(pessoaId, 'pessoaId');
      _idObrigatorio(disciplinaId, 'disciplinaId');
      await _atividadesRef.doc(atividadeId).update({'entregues': novaContagem});
    } catch (e) {
      throw Exception('Erro ao atualizar entregas: $e');
    }
  }
}
