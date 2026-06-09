import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/screen_atividade_professor/atividade_professor_model.dart';

class AtividadeService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Obter todas as atividades de uma disciplina de uma pessoa
  Stream<List<AtividadeProfessor>> getAtividadesDisciplina(
    String pessoaId,
    String disciplinaId,
  ) {
    return _db
        .collection('Pessoa')
        .doc(pessoaId)
        .collection('Disciplina')
        .doc(disciplinaId)
        .collection('Atividades')
        .orderBy('criadoEm', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AtividadeProfessor.fromFirestore(doc))
            .toList());
  }

  /// Criar uma nova atividade
  Future<String> criarAtividade(
    String pessoaId,
    String disciplinaId,
    AtividadeProfessor atividade,
  ) async {
    try {
      final docRef = await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Atividades')
          .add(atividade.toFirestore());

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
      await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Atividades')
          .doc(atividadeId)
          .update(atividade.toFirestore());
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
      await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Atividades')
          .doc(atividadeId)
          .delete();
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
      final doc = await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Atividades')
          .doc(atividadeId)
          .get();

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
    return _db
        .collectionGroup('Atividades')
        .where('pessoaId', isEqualTo: pessoaId)
        .orderBy('criadoEm', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => AtividadeProfessor.fromFirestore(doc))
            .toList());
  }

  /// Atualizar contagem de entregas de uma atividade
  Future<void> atualizarEntregas(
    String pessoaId,
    String disciplinaId,
    String atividadeId,
    int novaContagem,
  ) async {
    try {
      await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Atividades')
          .doc(atividadeId)
          .update({'entregues': novaContagem});
    } catch (e) {
      throw Exception('Erro ao atualizar entregas: $e');
    }
  }
}
