import 'package:classmanagerapp/services/student_activity/student_activity_service.dart';
import 'package:flutter/material.dart';

class StudentActivitySubmissionScreen extends StatefulWidget {
  const StudentActivitySubmissionScreen({
    super.key,
    required this.activityId,
  });

  final String activityId;

  @override
  State<StudentActivitySubmissionScreen> createState() =>
      _StudentActivitySubmissionScreenState();
}

class _StudentActivitySubmissionScreenState
    extends State<StudentActivitySubmissionScreen> {
  static const attachmentsBackground = Color(0xFFDDF7FB);
  static const secondaryButtonColor = Color(0xFF5A5A5A);

  StudentActivity? _activity;
  bool _loading = true;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _loadActivity();
  }

  Future<void> _loadActivity() async {
    final activity = await StudentActivityService.instance.fetchActivityById(
      widget.activityId,
    );

    if (!mounted) return;

    setState(() {
      _activity = activity;
      _loading = false;
    });
  }

  Future<void> _addAttachment() async {
    setState(() => _saving = true);

    final now = DateTime.now();
    final fileName =
        'trabalho_${now.hour}${now.minute}${now.second}${now.millisecond}.pdf';

    final updated = await StudentActivityService.instance.submitAttachment(
      activityId: widget.activityId,
      attachmentName: fileName,
    );

    if (!mounted) return;

    setState(() {
      _activity = updated;
      _saving = false;
    });
  }

  Future<void> _finishActivity() async {
    setState(() => _saving = true);

    final updated = await StudentActivityService.instance.markAsDelivered(
      widget.activityId,
    );

    if (!mounted) return;

    setState(() {
      _activity = updated;
      _saving = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Atividade marcada como concluida.')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final activity = _activity;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('Calculo 1'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : activity == null
              ? const Center(child: Text('Atividade nao encontrada.'))
              : SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFECECEC),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            activity.subjectName,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        Text(
                          activity.deadlineLabel,
                          style: const TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          activity.description,
                          style: const TextStyle(height: 1.6),
                        ),
                        const SizedBox(height: 20),
                        for (final instruction in activity.instructions)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 6),
                            child: Text('- $instruction'),
                          ),
                        const SizedBox(height: 18),
                        const Text(
                          'Seus trabalhos',
                          style: TextStyle(fontSize: 13),
                        ),
                        const SizedBox(height: 8),
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: attachmentsBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: activity.attachments.isEmpty
                                ? const Align(
                                    alignment: Alignment.topLeft,
                                    child: Text(
                                      'Nenhum anexo enviado ainda.',
                                      style: TextStyle(color: Colors.black54),
                                    ),
                                  )
                                : ListView.separated(
                                    itemCount: activity.attachments.length,
                                    separatorBuilder: (_, __) =>
                                        const SizedBox(height: 10),
                                    itemBuilder: (context, index) {
                                      return Row(
                                        children: [
                                          const Icon(Icons.attach_file_rounded),
                                          const SizedBox(width: 6),
                                          Expanded(
                                            child: Text(activity.attachments[index]),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: _saving ? null : _addAttachment,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: secondaryButtonColor,
                                ),
                                icon: const Icon(Icons.add),
                                label: const Text('Adicionar Trabalho'),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _saving ? null : _finishActivity,
                                child: Text(
                                  activity.status == ActivityStatus.delivered
                                      ? 'Concluido'
                                      : 'Marcar como concluido',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
