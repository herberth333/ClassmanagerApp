import 'package:flutter/material.dart';

import '../../services/configuracoes_service.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() => _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState extends State<ConfiguracoesScreen> {
  static const Color _blueColor = Color(0xFF0569FF);

  final ConfiguracoesService _service = ConfiguracoesService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _blueColor,
        elevation: 0,
        title: const Text(
          'Configuracoes',
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
          const SizedBox(width: 8),
        ],
      ),
      body: StreamBuilder<ConfiguracoesUsuario>(
        stream: _service.assistirConfiguracoes(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Erro ao carregar configuracoes: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final configuracoes =
              snapshot.data ??
              const ConfiguracoesUsuario(notificacoesAtivas: false);

          return Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Notificacoes',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Permitir que o aplicativo envie notificacoes',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                          height: 1.25,
                        ),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: configuracoes.notificacoesAtivas,
                  activeThumbColor: _blueColor,
                  onChanged: (value) {
                    _service.atualizarNotificacoes(value);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
