import 'package:flutter/material.dart';

class CalculadoraScreen extends StatelessWidget {
  const CalculadoraScreen({super.key});

  static const Color _blueColor = Color(0xFF0569FF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: _blueColor,
        elevation: 0,
        // Botão de voltar customizado (círculo branco com seta)
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
              onPressed: () {
                // Ação de voltar
                Navigator.pop(context);
              },
            ),
          ),
        ),
        title: const Text(
          'Calculadora',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        // Ícone de perfil no canto direito
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
      // Usamos o SingleChildScrollView para evitar que o teclado cubra os elementos na tela
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Campo 1
            _buildLabel('Selecione a primeira nota:'),
            const SizedBox(height: 8),
            _buildTextField('Digite a primeira nota'),

            const SizedBox(height: 20),

            // Campo 2
            _buildLabel('Selecione a segunda nota:'),
            const SizedBox(height: 8),
            _buildTextField('Digite a segunda nota'),

            const SizedBox(height: 25),

            // Botão Calcular Média
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _blueColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  elevation: 0,
                ),
                onPressed: () {
                  // Lógica para calcular a média vai aqui
                },
                child: const Text(
                  'Calcular Média',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Área de Resultado
            _buildLabel('Resultado:'),
            const SizedBox(height: 8),
            Container(
              height: 200, // Altura fixa para o quadro de resultado
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(
                  0xFFE8F8FA,
                ), // Ciano bem clarinho igual ao print
                borderRadius: BorderRadius.circular(12),
              ),
              // Aqui dentro você pode colocar um widget Text futuramente para exibir o valor
              child: const Center(
                child: Text(
                  '', // Deixado vazio por enquanto, como no design
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),

      // Barra de navegação inferior (BottomNavigationBar)
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: _blueColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        currentIndex: 1, // Acadêmico selecionado
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        selectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
        ),
        unselectedLabelStyle: const TextStyle(
          fontWeight: FontWeight.normal,
          fontSize: 12,
        ),
        items: const [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.home_outlined, size: 26),
            ),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.menu_book_outlined, size: 26),
            ),
            label: 'Acadêmico',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(bottom: 4.0),
              child: Icon(Icons.settings_outlined, size: 26),
            ),
            label: 'Configurações',
          ),
        ],
        onTap: (index) {
          // Gerenciar navegação do menu inferior
        },
      ),
    );
  }

  // Widget auxiliar para os rótulos de texto
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  // Widget auxiliar para os campos de texto
  Widget _buildTextField(String hintText) {
    return TextField(
      keyboardType: TextInputType.number, // Abre o teclado numérico
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: _blueColor, width: 1.5),
        ),
      ),
    );
  }
}
