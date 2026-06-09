import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'package:flutter/foundation.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Instância do Banco de Dados
  
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '952623983658-rc0ddbsgl9bhvjsv7gtom29lhlv548l1.apps.googleusercontent.com',
    scopes: ['email'],
  );

  /// Novo método para cadastrar usuário com E-mail, Senha, Nome e Matrícula
  Future<String?> cadastrarComEmailSenha({
    required String email,
    required String senha,
    required String nome,
    required String matricula,
    required String tipoUsuario,
  }) async {
    try {
      // 1. Cria a autenticação do usuário no Firebase Auth
      UserCredential credencial = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: senha,
      );

      User? usuario = credencial.user;

      if (usuario != null) {
        // 2. Salva os dados complementares no Cloud Firestore vinculando ao UID do usuário
        await _firestore.collection('usuarios').doc(usuario.uid).set({
          'uid': usuario.uid,
          'nome': nome.trim(),
          'matricula': matricula.trim(),
          'email': email.trim(),
          'dataCriacao': FieldValue.serverTimestamp(),
          'tipoUsuario': tipoUsuario,
        });
      }

      return null; // Indica sucesso
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Este e-mail já está sendo utilizado por outra conta.';
      } else if (e.code == 'weak-password') {
        return 'A senha fornecida é muito fraca.';
      } else if (e.code == 'invalid-email') {
        return 'O formato do e-mail inserido é inválido.';
      }
      return 'Erro no cadastro: ${e.message}';
    } catch (e) {
      debugPrint("Erro no cadastro de dados complementares: $e");
      return 'Erro ao salvar os dados no banco de dados. Tente novamente.';
    }
  }

  Future<String?> fazerLogin(String email, String senha) async {
    try {
      UserCredential credencial = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: senha,
      );

      User? usuario = credencial.user;

      if (usuario != null && usuario.email != null) {
        if (!usuario.email!.endsWith('@souunit.com.br')) {
          await _auth.signOut();
          return 'Acesso negado. Utilize seu e-mail institucional (@souunit.com.br).';
        }
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return 'E-mail ou senha incorretos.';
      }
      return 'Erro na autenticação: ${e.message}';
    } catch (e) {
      debugPrint("Erro no login: $e");
      return 'Ocorreu um erro inesperado. Tente novamente.';
    }
  }

  Future<String?> recuperarSenha(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Nenhum usuário encontrado com este e-mail.';
      }
      return 'Erro ao enviar o link: ${e.message}';
    } catch (e) {
      debugPrint("Erro ao recuperar senha: $e");
      return 'Ocorreu um erro inesperado. Tente novamente.';
    }
  }

  Future<void> fazerLogout() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  Future<String?> loginComGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return 'Login cancelado pelo usuário.';
      }

      if (!googleUser.email.endsWith('@souunit.com.br')) {
        await _googleSignIn.signOut();
        return 'Acesso negado. Utilize seu e-mail institucional (@souunit.com.br).';
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      UserCredential userCredential = await _auth.signInWithCredential(credential);
      User? usuario = userCredential.user;

      // salva um documento base para ele no banco para não quebrar as regras de leitura do app!
      if (usuario != null && userCredential.additionalUserInfo?.isNewUser == true) {
        await _firestore.collection('usuarios').doc(usuario.uid).set({
          'uid': usuario.uid,
          'nome': usuario.displayName ?? 'Usuário Google',
          'matricula': 'Via Google Login',
          'email': usuario.email,
          'dataCriacao': FieldValue.serverTimestamp(),
          'tipoUsuario': 'aluno',
        });
      }

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        return 'Já existe uma conta com um método de login diferente para este e-mail.';
      }
      return 'Erro na autenticação do Google: ${e.message}';
    } catch (e) {
      debugPrint('Erro no Google Sign-In: $e');
      return 'Ocorreu um erro ao tentar logar com o Google.';
    }
  }
}