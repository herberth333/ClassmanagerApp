import 'package:cloud_firestore/cloud_firestore.dart';

class Horario {
  final String? id;
  final String dia;
  final String disciplina;
  final String sala;
  final String horario;
  final DateTime? criadoEm;

  const Horario({
    this.id,
    required this.dia,
    required this.disciplina,
    required this.sala,
    required this.horario,
    this.criadoEm,
  });

  // Converter para Map para salvar no Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'dia': dia,
      'disciplina': disciplina,
      'sala': sala,
      'horario': horario,
      'criadoEm': criadoEm ?? DateTime.now(),
    };
  }

  // Converter de DocumentSnapshot do Firestore
  factory Horario.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Horario(
      id: doc.id,
      dia: data['dia'] ?? '',
      disciplina: data['disciplina'] ?? '',
      sala: data['sala'] ?? '',
      horario: data['horario'] ?? '',
      criadoEm: data['criadoEm'] != null
          ? (data['criadoEm'] as Timestamp).toDate()
          : DateTime.now(),
    );
  }

  // Copiar com alterações
  Horario copyWith({
    String? id,
    String? dia,
    String? disciplina,
    String? sala,
    String? horario,
    DateTime? criadoEm,
  }) {
    return Horario(
      id: id ?? this.id,
      dia: dia ?? this.dia,
      disciplina: disciplina ?? this.disciplina,
      sala: sala ?? this.sala,
      horario: horario ?? this.horario,
      criadoEm: criadoEm ?? this.criadoEm,
    );
  }
}

const List<Horario> horariosMock = [
  Horario(
    id: 'horario_1',
    dia: 'Segunda',
    disciplina: 'Calculo 1',
    sala: 'Sala 22',
    horario: '18:45 as 22:15',
  ),
  Horario(
    id: 'horario_2',
    dia: 'Terca',
    disciplina: 'Redes',
    sala: 'Lab 03',
    horario: '18:45 as 20:25',
  ),
  Horario(
    id: 'horario_3',
    dia: 'Quarta',
    disciplina: 'Estatistica',
    sala: 'Sala 18',
    horario: '20:35 as 22:15',
  ),
  Horario(
    id: 'horario_4',
    dia: 'Quinta',
    disciplina: 'Programacao de Redes',
    sala: 'Lab 02',
    horario: '18:45 as 22:15',
  ),
  Horario(
    id: 'horario_5',
    dia: 'Sexta',
    disciplina: 'Direito Penal',
    sala: 'Sala 12',
    horario: '19:00 as 21:30',
  ),
];
