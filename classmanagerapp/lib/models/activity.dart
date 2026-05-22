class Activity {
  final String id;
  final String title;
  final String description;
  final String? instructions;
  final int maxScore;
  final DateTime dueDate;
  final String disciplineId;
  final String disciplineName;
  final List<String>? attachments;
  final bool isCompleted;
  final DateTime createdAt;

  Activity({
    required this.id,
    required this.title,
    required this.description,
    this.instructions,
    required this.maxScore,
    required this.dueDate,
    required this.disciplineId,
    required this.disciplineName,
    this.attachments,
    this.isCompleted = false,
    required this.createdAt,
  });

  String get formattedDueDate {
    return 'jan. ${dueDate.day}, ${dueDate.hour}:${dueDate.minute.toString().padLeft(2, '0')}';
  }
}
