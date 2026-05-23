import 'package:classmanagerapp/models/activity.dart';
import 'package:classmanagerapp/models/schedule.dart';

class MockBackendService {
  MockBackendService._();

  static final MockBackendService instance = MockBackendService._();

  final List<Map<String, String>> disciplines = const [
    {'id': '1', 'name': 'Calculo 1'},
    {'id': '2', 'name': 'Calculo 2'},
    {'id': '3', 'name': 'Estatística'},
    {'id': '4', 'name': 'Redes'},
    {'id': '5', 'name': 'Programação de Redes'},
    {'id': '6', 'name': 'Direito Penal'},
    {'id': '7', 'name': 'Experiencia Extencionista'},
    {'id': '8', 'name': 'Sociologia'},
    {'id': '9', 'name': 'Libras'},
  ];

  final List<Activity> activities = [
    Activity(
      id: '1',
      title: 'Atividade X - Entrega Final',
      description: 'Descrição da atividade para entrega',
      instructions: 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
      maxScore: 100,
      dueDate: DateTime(2026, 1, 1, 23, 0),
      disciplineId: '1',
      disciplineName: 'Calculo 1',
      attachments: null,
      createdAt: DateTime.now(),
    ),
    Activity(
      id: '2',
      title: 'Lista de Exercícios 1',
      description: 'Primeira lista de exercícios',
      maxScore: 50,
      dueDate: DateTime(2026, 1, 5, 18, 0),
      disciplineId: '1',
      disciplineName: 'Calculo 1',
      createdAt: DateTime.now(),
    ),
    Activity(
      id: '3',
      title: 'Trabalho em Grupo',
      description: 'Trabalho em grupo sobre integrais',
      maxScore: 80,
      dueDate: DateTime(2026, 1, 10, 20, 0),
      disciplineId: '1',
      disciplineName: 'Calculo 1',
      createdAt: DateTime.now(),
    ),
  ];

  final List<Schedule> schedules = [
    Schedule(
      id: '1',
      disciplineId: '1',
      disciplineName: 'CALCULO 1',
      room: 'ABC123',
      startTime: DateTime(2026, 1, 20, 18, 45),
      endTime: DateTime(2026, 1, 20, 19, 35),
      dayOfWeek: 'SEG',
      type: 'Turma ABC123',
      classCode: 'CALCULO 1',
      teacherName: 'Juliana Silva',
    ),
    Schedule(
      id: '2',
      disciplineId: '1',
      disciplineName: 'CALCULO 1',
      room: '22',
      startTime: DateTime(2026, 1, 20, 19, 35),
      endTime: DateTime(2026, 1, 20, 20, 25),
      dayOfWeek: 'SEG',
      type: 'Bloco A - Bloco A',
      classCode: 'CALCULO 1',
      teacherName: 'Prof. João',
    ),
    Schedule(
      id: '3',
      disciplineId: '1',
      disciplineName: 'CALCULO 1',
      room: 'Sala 17 - Sala de Aula',
      startTime: DateTime(2026, 1, 21, 19, 35),
      endTime: DateTime(2026, 1, 21, 20, 25),
      dayOfWeek: 'TER',
      type: 'Tipo de Turma: Presencial',
      classCode: 'CALCULO 1',
      teacherName: 'Juliana Silva',
    ),
    Schedule(
      id: '4',
      disciplineId: '1',
      disciplineName: 'CALCULO 1',
      room: 'Bloco A',
      startTime: DateTime(2026, 1, 22, 20, 25),
      endTime: DateTime(2026, 1, 22, 21, 15),
      dayOfWeek: 'QUA',
      type: 'Bloco A - Bloco A',
      classCode: 'CALCULO 1',
      teacherName: 'Prof. Carlos',
    ),
    Schedule(
      id: '5',
      disciplineId: '1',
      disciplineName: 'CALCULO 1',
      room: 'Sala 17',
      startTime: DateTime(2026, 1, 23, 21, 25),
      endTime: DateTime(2026, 1, 23, 22, 15),
      dayOfWeek: 'QUI',
      type: 'Tipo de Turma: Presencial',
      classCode: 'CALCULO 1',
      teacherName: 'Juliana Silva',
    ),
  ];

  List<String> getDaysOfWeek() {
    return ['DOM', 'SEG', 'TER', 'QUA', 'QUI', 'SEX', 'SAB'];
  }
}
