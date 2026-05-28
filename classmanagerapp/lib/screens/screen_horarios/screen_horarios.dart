import 'package:flutter/material.dart';

class HorariosScreen extends StatelessWidget {
  const HorariosScreen({super.key});

  static const Color _blueColor = Color(0xFF0569FF);

  static const List<_HorarioItem> _horarios = [
    _HorarioItem(
      dia: 'Segunda',
      disciplina: 'Calculo 1',
      sala: 'Sala 22',
      horario: '18:45 as 22:15',
    ),
    _HorarioItem(
      dia: 'Terca',
      disciplina: 'Redes',
      sala: 'Lab 03',
      horario: '18:45 as 20:25',
    ),
    _HorarioItem(
      dia: 'Quarta',
      disciplina: 'Estatistica',
      sala: 'Sala 18',
      horario: '20:35 as 22:15',
    ),
    _HorarioItem(
      dia: 'Quinta',
      disciplina: 'Programacao de Redes',
      sala: 'Lab 02',
      horario: '18:45 as 22:15',
    ),
    _HorarioItem(
      dia: 'Sexta',
      disciplina: 'Direito Penal',
      sala: 'Sala 12',
      horario: '19:00 as 21:30',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _blueColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: const Text(
          'Horarios',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
              size: 28,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(20.0),
        itemCount: _horarios.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _HorarioCard(item: _horarios[index]);
        },
      ),
    );
  }
}

class _HorarioCard extends StatelessWidget {
  final _HorarioItem item;

  const _HorarioCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              color: Color(0xFFE8F8FA),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.calendar_today_outlined,
              color: Colors.black87,
              size: 26,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.dia,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item.disciplina,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${item.sala}  -  ${item.horario}',
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _HorarioItem {
  final String dia;
  final String disciplina;
  final String sala;
  final String horario;

  const _HorarioItem({
    required this.dia,
    required this.disciplina,
    required this.sala,
    required this.horario,
  });
}
