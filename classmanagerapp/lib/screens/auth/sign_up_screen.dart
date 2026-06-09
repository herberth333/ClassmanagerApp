import 'package:flutter/material.dart';
import '/services/auth/auth_service.dart'; 

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _confirmeSenhaController = TextEditingController();

  // 👈 Nova variável para armazenar o tipo de usuário selecionado
  String? _tipoUsuarioSelecionado; 

  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  final Color _primaryBlue = const Color(0xFF0569FF);

  @override
  void dispose() {
    _nomeController.dispose();
    _matriculaController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    _confirmeSenhaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Botão voltar alinhado à esquerda
                Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context); // Retorna para a tela de login
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
                ),
                
                const SizedBox(height: 24),

                const Text(
                  'Solicitar Acesso',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF1E212B),
                  ),
                ),
                const SizedBox(height: 32),

                const Text(
                  'Seu Nome:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _nomeController,
                  decoration: _getInputDecoration(hintText: 'Digite seu nome completo'),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Matrícula:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _matriculaController,
                  decoration: _getInputDecoration(hintText: 'Digite sua matrícula'),
                ),
                const SizedBox(height: 16),

                const Text(
                  'E-mail:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: _getInputDecoration(hintText: 'Digite um email'),
                ),
                const SizedBox(height: 16),

                // 👈 NOVO CAMPO: SELEÇÃO DE TIPO DE USUÁRIO (ALUNO / PROFESSOR)
                const Text(
                  'Tipo de Conta:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                DropdownButtonFormField<String>(
                  value: _tipoUsuarioSelecionado,
                  hint: const Text('Selecione se você é Aluno ou Professor', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  decoration: _getInputDecoration(hintText: ''),
                  icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
                  items: const [
                    DropdownMenuItem(
                      value: 'aluno',
                      child: Text('Aluno', style: TextStyle(fontSize: 15)),
                    ),
                    DropdownMenuItem(
                      value: 'professor',
                      child: Text('Professor', style: TextStyle(fontSize: 15)),
                    ),
                  ],
                  onChanged: (String? novoValor) {
                    setState(() {
                      _tipoUsuarioSelecionado = novoValor;
                    });
                  },
                ),
                const SizedBox(height: 16),

                const Text(
                  'Digite uma senha:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _senhaController,
                  obscureText: !_isPasswordVisible,
                  decoration: _getInputDecoration(
                    hintText: '**********',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 4.0),
                  child: Text(
                    'Crie uma senha forte.',
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ),
                const SizedBox(height: 16),

                const Text(
                  'Confirme a senha:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),
                const SizedBox(height: 4),
                TextField(
                  controller: _confirmeSenhaController,
                  obscureText: !_isConfirmPasswordVisible,
                  decoration: _getInputDecoration(
                    hintText: '**********',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 48),

                // 🚀 BOTÃO UNIFICADO COM LÓGICA DO FIREBASE ATUALIZADA
                SizedBox(
                  height: 55,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                    onPressed: () async {
                      // 1. Validação básica dos campos vazios (Adicionado o check do Dropdown)
                      if (_nomeController.text.trim().isEmpty ||
                          _matriculaController.text.trim().isEmpty ||
                          _emailController.text.trim().isEmpty ||
                          _tipoUsuarioSelecionado == null || // 👈 Impede envio sem selecionar o cargo
                          _senhaController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Por favor, preencha todos os campos!'),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      // 2. Trava de segurança para o e-mail institucional
                      if (!_emailController.text.trim().endsWith('@souunit.com.br')) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Apenas e-mails com domínio @souunit.com.br são permitidos!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // 3. Validação de senhas idênticas
                      if (_senhaController.text != _confirmeSenhaController.text) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('As senhas não coincidem!'),
                            backgroundColor: Colors.red,
                          ),
                        );
                        return;
                      }

                      // 4. Se passou, exibe o loading na tela
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (context) => const Center(child: CircularProgressIndicator()),
                      );

                      try {
                        final authService = AuthService(); 
                        
                        // 🚀 ATUALIZAÇÃO DA CHAMADA: Agora enviamos dinamicamente se é aluno ou professor
                        String? erro = await authService.cadastrarComEmailSenha(
                          email: _emailController.text.trim(),
                          senha: _senhaController.text,
                          nome: _nomeController.text.trim(),
                          matricula: _matriculaController.text.trim(),
                          tipoUsuario: _tipoUsuarioSelecionado!, // 👈 Parâmetro injetado aqui
                        );

                        if (!mounted) return;
                        Navigator.pop(context); // Remove o loading

                        if (erro == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Cadastro realizado com sucesso!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          Navigator.pop(context); // Volta para a tela anterior (Login)
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(erro), backgroundColor: Colors.red),
                          );
                        }
                      } catch (e) {
                        if (!mounted) return;
                        Navigator.pop(context); // Remove o loading
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Erro inesperado: $e'), backgroundColor: Colors.red),
                        );
                      }
                    },
                    child: const Text(
                      'Solicitar Acesso',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Center(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(color: Colors.black87, fontSize: 13, height: 1.5),
                      children: [
                        const TextSpan(text: 'Ao continuar, você concorda com os '),
                        TextSpan(
                          text: 'Termos de Serviços',
                          style: TextStyle(
                            color: _primaryBlue,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: ' e de '),
                        TextSpan(
                          text: 'Política de Privacidade',
                          style: TextStyle(
                            color: _primaryBlue,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const TextSpan(text: '.'),
                      ],
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

  InputDecoration _getInputDecoration({required String hintText, Widget? suffixIcon}) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      suffixIcon: suffixIcon,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0),
        borderSide: BorderSide(color: _primaryBlue, width: 2.0),
      ),
    );
  }
}