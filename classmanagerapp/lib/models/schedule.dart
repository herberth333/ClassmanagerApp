class Schedule {
  final String id;
  final String disciplineId;
  final String disciplineName;
  final String room;
  final DateTime startTime;
  final DateTime endTime;
  final String dayOfWeek;
  final String type; // Turma, Bloco, Sala, etc
  final String classCode;
  final String teacherName;

  Schedule({
    required this.id,
    required this.disciplineId,
    required this.disciplineName,
    required this.room,
    required this.startTime,
    required this.endTime,
    required this.dayOfWeek,
    required this.type,
    required this.classCode,
    required this.teacherName,
  });

  String get formattedTime {
    return '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')} - ${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
  }
}
