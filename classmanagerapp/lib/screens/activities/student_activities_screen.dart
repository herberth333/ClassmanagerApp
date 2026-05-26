import 'package:classmanagerapp/screens/activities/student_activity_submission_screen.dart';
import 'package:classmanagerapp/services/student_activity/student_activity_service.dart';
import 'package:flutter/material.dart';

class StudentActivitiesScreen extends StatefulWidget {
  const StudentActivitiesScreen({super.key});

  @override
  State<StudentActivitiesScreen> createState() => _StudentActivitiesScreenState();
}

class _StudentActivitiesScreenState extends State<StudentActivitiesScreen> {
  static const activeTabColor = Color(0xFF1565F8);
  static const inactiveTabColor = Color(0xFF5A5A5A);
  static const cardColor = Color(0xFFF3F3F3);

  late Future<List<StudentActivity>> _activities;

  @override
  void initState() {
    super.initState();
    _reload();
  }

  void _reload() {
    _activities = StudentActivityService.instance.fetchActivities();
  }

  Future<void> _openActivity(StudentActivity activity) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => StudentActivitySubmissionScreen(activityId: activity.id),
      ),
    );

    setState(_reload);
  }

  Future<void> _refresh() async {
    setState(_reload);
    await _activities;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home_outlined),
        title: const Text('Calculo 1'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _SubjectTabChip(
                  label: 'Mural',
                  color: inactiveTabColor,
                ),
                SizedBox(width: 8),
                _SubjectTabChip(
                  label: 'Atividades',
                  color: activeTabColor,
                ),
                SizedBox(width: 8),
                _SubjectTabChip(
                  label: 'Membros',
                  color: inactiveTabColor,
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Expanded(
            child: FutureBuilder<List<StudentActivity>>(
              future: _activities,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }

                final items = snapshot.data ?? [];

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.separated(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    itemCount: items.length + 1,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return const Text(
                          'PROXIMAS ENTREGAS:',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        );
                      }

                      final activity = items[index - 1];
                      return _ActivityCard(
                        activity: activity,
                        onTap: () => _openActivity(activity),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _SubjectTabChip extends StatelessWidget {
  const _SubjectTabChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(
              color: Color(0x33000000),
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ActivityCard extends StatelessWidget {
  const _ActivityCard({
    required this.activity,
    required this.onTap,
  });

  final StudentActivity activity;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final delivered = activity.status == ActivityStatus.delivered;

    return Material(
      color: _StudentActivitiesScreenState.cardColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          constraints: const BoxConstraints(minHeight: 104),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE1E1E1)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x22000000),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      activity.title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      activity.deadlineLabel,
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      delivered ? 'Entregue' : 'Pendente',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: delivered ? Colors.green.shade700 : Colors.orange.shade800,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
