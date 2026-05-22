import 'package:classmanagerapp/models/schedule.dart';
import 'package:classmanagerapp/services/mock_backend_service.dart';

class ScheduleService {
  final _backend = MockBackendService.instance;

  Future<List<Schedule>> getSchedulesByDayOfWeek(String day) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _backend.schedules
        .where((schedule) => schedule.dayOfWeek == day)
        .toList()
      ..sort((a, b) => a.startTime.compareTo(b.startTime));
  }

  List<String> getDaysOfWeek() {
    return _backend.getDaysOfWeek();
  }
}
