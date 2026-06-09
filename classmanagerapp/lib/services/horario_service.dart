import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/screen_horarios/horario_model.dart';

class HorarioService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  /// Obter todos os horários de uma disciplina de uma pessoa
  Stream<List<Horario>> getHorariosDisciplina(
    String pessoaId,
    String disciplinaId,
  ) {
    return _db
        .collection('Pessoa')
        .doc(pessoaId)
        .collection('Disciplina')
        .doc(disciplinaId)
        .collection('Horarios')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Horario.fromFirestore(doc)).toList());
  }

  /// Criar um novo horário
  Future<String> criarHorario(
    String pessoaId,
    String disciplinaId,
    Horario horario,
  ) async {
    try {
      final docRef = await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Horarios')
          .add(horario.toFirestore());

      return docRef.id;
    } catch (e) {
      throw Exception('Erro ao criar horário: $e');
    }
  }

  /// Atualizar um horário existente
  Future<void> atualizarHorario(
    String pessoaId,
    String disciplinaId,
    String horarioId,
    Horario horario,
  ) async {
    try {
      await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Horarios')
          .doc(horarioId)
          .update(horario.toFirestore());
    } catch (e) {
      throw Exception('Erro ao atualizar horário: $e');
    }
  }

  /// Deletar um horário
  Future<void> deletarHorario(
    String pessoaId,
    String disciplinaId,
    String horarioId,
  ) async {
    try {
      await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Horarios')
          .doc(horarioId)
          .delete();
    } catch (e) {
      throw Exception('Erro ao deletar horário: $e');
    }
  }

  /// Obter um horário específico
  Future<Horario?> obterHorario(
    String pessoaId,
    String disciplinaId,
    String horarioId,
  ) async {
    try {
      final doc = await _db
          .collection('Pessoa')
          .doc(pessoaId)
          .collection('Disciplina')
          .doc(disciplinaId)
          .collection('Horarios')
          .doc(horarioId)
          .get();

      if (doc.exists) {
        return Horario.fromFirestore(doc);
      }
      return null;
    } catch (e) {
      throw Exception('Erro ao obter horário: $e');
    }
  }

  /// Obter todos os horários de uma pessoa
  Stream<List<Horario>> getTodosOsHorarios(String pessoaId) {
    return _db
        .collectionGroup('Horarios')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Horario.fromFirestore(doc)).toList());
  }

  /// Obter horários ordenados por dia da semana
  Stream<List<Horario>> getHorariosPorDia(
    String pessoaId,
    String disciplinaId,
    String dia,
  ) {
    return _db
        .collection('Pessoa')
        .doc(pessoaId)
        .collection('Disciplina')
        .doc(disciplinaId)
        .collection('Horarios')
        .where('dia', isEqualTo: dia)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Horario.fromFirestore(doc)).toList());
  }
}
