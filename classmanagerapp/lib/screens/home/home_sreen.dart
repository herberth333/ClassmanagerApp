import 'package:classmanagerapp/screens/academico/academico_screen.dart';
import 'package:classmanagerapp/screens/home/disciplinas_screen.dart';
import 'package:classmanagerapp/screens/screen_academico/screen_academico.dart';
import 'package:classmanagerapp/screens/screen_calculadora/screen_calculadora.dart';
import 'package:classmanagerapp/core/widgets/navbar/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _abaAtiva = 0;

  
  final List<Widget> _telas = [
    const DisciplinasScreen(), 
    const AcademicoScreen(), 
    const Scaffold(           
      body: Center(
        child: Text(
          'Conteúdo das Configurações',
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _telas[_abaAtiva],
      bottomNavigationBar: CustomNavbar(
        currentIndex: _abaAtiva,
        onTap: (index) {
          setState(() {
            _abaAtiva = index;
          });
        },
      ),
    );
  }
}