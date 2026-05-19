class AuthService {
  Future<bool> fazerLogin(String email, String senha) async {
    await Future.delayed(const Duration(seconds: 1));

    if (email == "1" && senha == "1") {
      return true; 
    } else {
      return false; 
    }
  }
}
