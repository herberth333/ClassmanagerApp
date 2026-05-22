import 'package:classmanagerapp/models/activity.dart';
import 'package:classmanagerapp/services/mock_backend_service.dart';

class ActivityService {
  final _backend = MockBackendService.instance;

  Future<List<Activity>> getActivitiesByDiscipline(String disciplineId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _backend.activities
        .where((activity) => activity.disciplineId == disciplineId)
        .toList();
  }

  Future<Activity?> getActivityById(String activityId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    try {
      return _backend.activities.firstWhere((activity) => activity.id == activityId);
    } catch (_) {
      return null;
    }
  }

  Future<Activity> createActivity({
    required String title,
    required String description,
    String? instructions,
    required int maxScore,
    required DateTime dueDate,
    required String disciplineId,
    required String disciplineName,
    List<String>? attachments,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final newActivity = Activity(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      instructions: instructions,
      maxScore: maxScore,
      dueDate: dueDate,
      disciplineId: disciplineId,
      disciplineName: disciplineName,
      attachments: attachments,
      createdAt: DateTime.now(),
    );

    _backend.activities.add(newActivity);
    return newActivity;
  }
}
