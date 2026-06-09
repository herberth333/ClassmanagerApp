import 'package:flutter/material.dart';
import '../../services/auth/auth_service.dart'; 

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  // Instância do seu serviço de autenticação
  final AuthService _authService = AuthService(); 
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // 2. Método _resetarSenha atualizado para se comunicar com o Firebase
  Future<void> _resetarSenha() async {
    final email = _emailController.text.trim();

    // Validação de campo vazio
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, insira seu e-mail.')),
      );
      return;
    }

    // Validação do domínio institucional para manter o padrão do app
    if (!email.endsWith('@souunit.com.br')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, insira seu e-mail institucional (@souunit.com.br).'),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Chamando a função do Firebase mapeada no seu AuthService
    String? erro = await _authService.recuperarSenha(email);

    if (!mounted) return;

    setState(() {
      _isLoading = false;
    });

    if (erro == null) {
      // Sucesso!
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Link de recuperação enviado com sucesso! Verifique sua caixa de entrada.'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Retorna o usuário para a tela de login, já que o processo continuará no e-mail dele
      Navigator.pop(context);
    } else {
      // Caso ocorra algum erro (ex: e-mail não cadastrado)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(erro),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // Botão voltar
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF2F2F2),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 18,
                      color: Colors.black,
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Título
                const Text(
                  'Esqueceu a senha',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 8),

                // Subtítulo
                const Text(
                  'Por favor, insira seu e-mail para redefinir a senha.',
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF9E9E9E),
                  ),
                ),

                const SizedBox(height: 28),

                // Texto email
                const Text(
                  'Seu e-mail:',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 10),

                // Campo email
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Digite seu e-mail',
                    hintStyle: const TextStyle(
                      color: Color(0xFFBDBDBD),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFFE0E0E0),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xFF0569FF),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 28),

                // Botão resetar senha
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _resetarSenha,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0569FF),
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3,
                            ),
                          )
                        : const Text(
                            'Resetar senha',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}