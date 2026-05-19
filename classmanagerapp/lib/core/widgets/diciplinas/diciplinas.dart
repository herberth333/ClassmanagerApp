import 'package:flutter/material.dart';
import 'detalhesDisciplina.dart';

class DiciplinasScreen extends StatelessWidget {
  const DiciplinasScreen({super.key});

  final List<String> disciplinas = const [
    'Calculo 1',
    'Calculo 2',
    'Estatística',
    'Redes',
    'Programação de Redes', 
    'Direito Penal',
    'Experiencia Extencionista',
    'Sociologia',
    'Libras'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0569FF), 
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.white), // Ícone de saída
          onPressed: () {
          },
        ),
        title: const Text(
          'Class Manager',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined, color: Colors.white, size: 28), 
            onPressed: () {
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          itemCount: disciplinas.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0), 
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetalhesDisciplina(
                        nomeDisciplina: disciplinas[index],
                      ),
                    ),
                  );
                },
                child: Container(
                  width: double.infinity,
                  height: 110, 
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEEEE), 
                    borderRadius: BorderRadius.circular(12), 
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Align(
                      alignment: Alignment.bottomLeft, 
                      child: Text(
                        disciplinas[index],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 24, 
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}