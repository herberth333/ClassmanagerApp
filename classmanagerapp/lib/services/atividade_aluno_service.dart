import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../screens/screen_atividade_aluno/atividade_aluno_model.dart';

class TrabalhoAtividadeAluno {
  final String nome;
  final String url;
  final String caminho;
  final int tamanho;

  const TrabalhoAtividadeAluno({
    required this.nome,
    required this.url,
    required this.caminho,
    required this.tamanho,
  });

  factory TrabalhoAtividadeAluno.fromFirestore(Object? value) {
    if (value is String) {
      return TrabalhoAtividadeAluno(
        nome: value,
        url: '',
        caminho: '',
        tamanho: 0,
      );
    }

    final data = value as Map<String, dynamic>? ?? {};
    return TrabalhoAtividadeAluno(
      nome: data['nome'] ?? 'Arquivo sem nome',
      url: data['url'] ?? '',
      caminho: data['caminho'] ?? '',
      tamanho: data['tamanho'] ?? 0,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {'nome': nome, 'url': url, 'caminho': caminho, 'tamanho': tamanho};
  }
}

class EntregaAtividadeAluno {
  final String id;
  final String atividadeId;
  final bool concluida;
  final List<TrabalhoAtividadeAluno> trabalhos;

  const EntregaAtividadeAluno({
    required this.id,
    required this.atividadeId,
    required this.concluida,
    required this.trabalhos,
  });

  factory EntregaAtividadeAluno.vazia(String atividadeId) {
    return EntregaAtividadeAluno(
      id: '',
      atividadeId: atividadeId,
      concluida: false,
      trabalhos: const [],
    );
  }

  factory EntregaAtividadeAluno.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>? ?? {};
    final trabalhos = data['trabalhos'];

    return EntregaAtividadeAluno(
      id: doc.id,
      atividadeId: data['atividadeId'] ?? '',
      concluida: data['concluida'] ?? false,
      trabalhos: trabalhos is List
          ? trabalhos
                .map((item) => TrabalhoAtividadeAluno.fromFirestore(item))
                .toList()
          : const [],
    );
  }
}

class AtividadeAlunoService {
  AtividadeAlunoService({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  }) : _db = firestore ?? FirebaseFirestore.instance,
       _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _db;
  final FirebaseAuth _auth;

  CollectionReference<Map<String, dynamic>> get _atividadesRef =>
      _db.collection('AtividadeAluno');

  CollectionReference<Map<String, dynamic>> get _entregasRef =>
      _db.collection('EntregaAtividadeAluno');

  String get _alunoId => _auth.currentUser?.uid ?? 'sem-login';

  Future<void> garantirAtividadeInicial(String disciplina) async {
    final snapshot = await _atividadesRef
        .where('disciplina', isEqualTo: disciplina)
        .where('tipo', isEqualTo: 'aluno')
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      return;
    }

    await _atividadesRef.doc('aluno_${_normalizarId(disciplina)}_inicial').set({
      'disciplina': disciplina,
      'turma': 'Class 0001',
      'titulo': 'Atividade do aluno',
      'prazo': 'jan. 01, 23:00',
      'descricao': 'Atividade inicial para testar o fluxo de entrega do aluno.',
      'orientacoes': [
        'Adicione um trabalho para criar a entrega.',
        'Marque como concluido para atualizar o status.',
      ],
      'tipo': 'aluno',
      'criadoEm': FieldValue.serverTimestamp(),
    });
  }

  Stream<List<AtividadeAluno>> assistirAtividades(String disciplina) {
    return _atividadesRef
        .where('disciplina', isEqualTo: disciplina)
        .where('tipo', isEqualTo: 'aluno')
        .snapshots()
        .map((snapshot) {
          final atividades = snapshot.docs
              .map((doc) => AtividadeAluno.fromFirestore(doc))
              .toList();
          atividades.sort((a, b) => a.prazo.compareTo(b.prazo));
          return atividades;
        });
  }

  Stream<EntregaAtividadeAluno> assistirEntrega(String atividadeId) {
    return _entregaDoc(atividadeId).snapshots().map((doc) {
      if (!doc.exists) {
        return EntregaAtividadeAluno.vazia(atividadeId);
      }
      return EntregaAtividadeAluno.fromFirestore(doc);
    });
  }

  Future<void> anexarTrabalho({
    required String atividadeId,
    required String nomeArquivo,
    required int tamanho,
  }) async {
    final trabalho = TrabalhoAtividadeAluno(
      nome: nomeArquivo,
      url: '',
      caminho: '',
      tamanho: tamanho,
    );

    return _entregaDoc(atividadeId).set({
      'atividadeId': atividadeId,
      'alunoId': _alunoId,
      'trabalhos': FieldValue.arrayUnion([trabalho.toFirestore()]),
      'concluida': false,
      'atualizadoEm': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true)).timeout(
      const Duration(seconds: 10),
      onTimeout: () => throw Exception(
        'Arquivo enviado, mas a entrega nao foi salva no Firestore.',
      ),
    );
  }

  Future<void> alternarConclusao({
    required String atividadeId,
    required bool concluida,
  }) {
    return _entregaDoc(atividadeId).set({
      'atividadeId': atividadeId,
      'alunoId': _alunoId,
      'concluida': concluida,
      'atualizadoEm': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
  }

  DocumentReference<Map<String, dynamic>> _entregaDoc(String atividadeId) {
    return _entregasRef.doc('${_alunoId}_$atividadeId');
  }

  String _normalizarId(String valor) {
    return valor
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
        .replaceAll(RegExp(r'^-+|-+$'), '');
  }

}
