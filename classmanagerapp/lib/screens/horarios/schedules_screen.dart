import 'package:classmanagerapp/core/services/schedule_service.dart';
import 'package:classmanagerapp/core/widgets/navbar/navbar.dart';
import 'package:flutter/material.dart';
import 'package:classmanagerapp/core/widgets/schedules/schedule_card.dart';

class SchedulesScreen extends StatefulWidget {
  const SchedulesScreen({super.key});

  @override
  State<SchedulesScreen> createState() => _SchedulesScreenState();
}

class _SchedulesScreenState extends State<SchedulesScreen> {
  final ScheduleService _scheduleService = ScheduleService();
  late List<String> _daysOfWeek;
  int _selectedDayIndex = 1; // Começar com segunda-feira (SEG)
  late Future<List<Schedule>> _schedulesFuture;

  @override
  void initState() {
    super.initState();
    _daysOfWeek = _scheduleService.getDaysOfWeek();
    _loadSchedules();
  }

  void _loadSchedules() {
    _schedulesFuture =
        _scheduleService.getSchedulesByDayOfWeek(_daysOfWeek[_selectedDayIndex]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0569FF),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Horários',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          // Abas dos dias da semana
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            color: Colors.white,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: List.generate(
                  _daysOfWeek.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedDayIndex = index;
                          _loadSchedules();
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12.0,
                          vertical: 8.0,
                        ),
                        decoration: BoxDecoration(
                          color: _selectedDayIndex == index
                              ? const Color(0xFF0569FF)
                              : Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          _daysOfWeek[index],
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: _selectedDayIndex == index
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(height: 1),
          // Lista de horários
          Expanded(
            child: FutureBuilder<List<Schedule>>(
              future: _schedulesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFF0569FF)),
                    ),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Erro ao carregar horários: ${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                final schedules = snapshot.data ?? [];

                if (schedules.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.schedule_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Nenhuma aula neste dia',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  itemCount: schedules.length,
                  itemBuilder: (context, index) {
                    return ScheduleCard(schedule: schedules[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
