import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../services/horario_service.dart';
import 'horario_model.dart';

class HorariosScreen extends StatefulWidget {
  final String disciplinaId;

  const HorariosScreen({
    super.key,
    this.disciplinaId = 'calculo1',
  });

  @override
  State<HorariosScreen> createState() => _HorariosScreenState();
}

class _HorariosScreenState extends State<HorariosScreen> {
  static const Color _blueColor = Color(0xFF0569FF);
  final HorarioService _horarioService = HorarioService();
  late String _pessoaId;

  @override
  void initState() {
    super.initState();
    _pessoaId = FirebaseAuth.instance.currentUser?.uid ?? '';
  }

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
      body: StreamBuilder<List<Horario>>(
        stream: _horarioService.getHorariosDisciplina(_pessoaId, widget.disciplinaId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar: ${snapshot.error}'),
            );
          }

          final horarios = snapshot.data ?? [];

          if (horarios.isEmpty) {
            return const Center(
              child: Text('Nenhum horário cadastrado'),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(20.0),
            itemCount: horarios.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              return _HorarioCard(horario: horarios[index]);
            },
          );
        },
      ),
    );
  }
}

class _HorarioCard extends StatelessWidget {
  final Horario horario;

  const _HorarioCard({required this.horario});

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
                  horario.dia,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  horario.disciplina,
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
                  '${horario.sala}  -  ${horario.horario}',
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
