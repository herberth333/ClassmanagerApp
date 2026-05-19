class StudentActivityService {
  StudentActivityService._();

  static final StudentActivityService instance = StudentActivityService._();

  final List<StudentActivity> _activities = [
    StudentActivity(
      id: 'atividade-01',
      subjectName: 'Calculo 1',
      title: 'Atividade X - Entrega Final',
      description:
          'Mauris at hendrerit orci, non porttitor augue. Fusce fermentum mi et felis volutpat, at congue lectus placerat. Sed nulla arcu, sollicitudin vitae diam quis, consequat pellentesque odio.',
      deadlineLabel: 'PRAZO: jan. 01, 23:00',
      instructions: const [
        'Resolver todos os exercicios da lista.',
        'Anexar PDF ou link do trabalho.',
        'Identificar nome completo no envio.',
        'Marcar como concluido apos revisar o material.',
      ],
      status: ActivityStatus.pending,
      attachments: const [],
    ),
    StudentActivity(
      id: 'atividade-02',
      subjectName: 'Calculo 1',
      title: 'Derivadas Aplicadas',
      description:
          'Lista complementar com questoes de derivadas e interpretacao grafica.',
      deadlineLabel: 'PRAZO: jan. 08, 22:00',
      instructions: const [
        'Enviar resolucao em PDF.',
        'Validar se todos os itens foram respondidos.',
      ],
      status: ActivityStatus.pending,
      attachments: const [],
    ),
    StudentActivity(
      id: 'atividade-03',
      subjectName: 'Calculo 1',
      title: 'Integral Definida',
      description:
          'Atividade de fixacao sobre area sob curvas com aplicacoes praticas.',
      deadlineLabel: 'PRAZO: jan. 15, 23:30',
      instructions: const [
        'Anexar arquivo final.',
        'Opcionalmente incluir link para repositorio ou drive.',
      ],
      status: ActivityStatus.delivered,
      attachments: const ['Entrega_final_integral.pdf'],
    ),
  ];

  Future<List<StudentActivity>> fetchActivities() async {
    await Future.delayed(const Duration(milliseconds: 250));
    return _activities.map((activity) => activity.copyWith()).toList();
  }

  Future<StudentActivity?> fetchActivityById(String id) async {
    await Future.delayed(const Duration(milliseconds: 180));
    for (final activity in _activities) {
      if (activity.id == id) {
        return activity.copyWith();
      }
    }
    return null;
  }

  Future<StudentActivity?> submitAttachment({
    required String activityId,
    required String attachmentName,
  }) async {
    await Future.delayed(const Duration(milliseconds: 220));
    for (var i = 0; i < _activities.length; i++) {
      if (_activities[i].id == activityId) {
        final updatedAttachments = List<String>.from(_activities[i].attachments)
          ..add(attachmentName);
        _activities[i] = _activities[i].copyWith(
          attachments: updatedAttachments,
        );
        return _activities[i].copyWith();
      }
    }
    return null;
  }

  Future<StudentActivity?> markAsDelivered(String activityId) async {
    await Future.delayed(const Duration(milliseconds: 220));
    for (var i = 0; i < _activities.length; i++) {
      if (_activities[i].id == activityId) {
        _activities[i] = _activities[i].copyWith(
          status: ActivityStatus.delivered,
        );
        return _activities[i].copyWith();
      }
    }
    return null;
  }
}

class StudentActivity {
  StudentActivity({
    required this.id,
    required this.subjectName,
    required this.title,
    required this.description,
    required this.deadlineLabel,
    required this.instructions,
    required this.status,
    required this.attachments,
  });

  final String id;
  final String subjectName;
  final String title;
  final String description;
  final String deadlineLabel;
  final List<String> instructions;
  final ActivityStatus status;
  final List<String> attachments;

  StudentActivity copyWith({
    String? id,
    String? subjectName,
    String? title,
    String? description,
    String? deadlineLabel,
    List<String>? instructions,
    ActivityStatus? status,
    List<String>? attachments,
  }) {
    return StudentActivity(
      id: id ?? this.id,
      subjectName: subjectName ?? this.subjectName,
      title: title ?? this.title,
      description: description ?? this.description,
      deadlineLabel: deadlineLabel ?? this.deadlineLabel,
      instructions: instructions ?? this.instructions,
      status: status ?? this.status,
      attachments: attachments ?? this.attachments,
    );
  }
}

enum ActivityStatus {
  pending,
  delivered,
}
