import 'package:classmanagerapp/core/widgets/navbar/navbar.dart';


class CalculadoraScreen extends StatefulWidget {
  const CalculadoraScreen({super.key});

  @override
  State<CalculadoraScreen> createState() => _CalculadoraScreenState();
}

class _CalculadoraScreenState extends State<CalculadoraScreen> {
  static const Color _blueColor = Color(0xFF0569FF);

  final TextEditingController _nota1Controller = TextEditingController();
  final TextEditingController _nota2Controller = TextEditingController();

  String _resultadoTexto = '';
  Color _resultadoCor = Colors.black87;

  void _calcularMedia() {
    String textoNota1 = _nota1Controller.text.replaceAll(',', '.');
    String textoNota2 = _nota2Controller.text.replaceAll(',', '.');

    double? nota1 = double.tryParse(textoNota1);
    double? nota2 = double.tryParse(textoNota2);

    if (nota1 == null || nota2 == null) {
      setState(() {
        _resultadoTexto = 'Preencha as duas notas corretamente.';
        _resultadoCor = Colors.redAccent;
      });
      return;
    }

    if (nota1 < 0 || nota1 > 10 || nota2 < 0 || nota2 > 10) {
      setState(() {
        _resultadoTexto = 'As notas devem estar entre 0 e 10.';
        _resultadoCor = Colors.orange;
      });
      return;
    }

    double media = (nota1 + nota2) / 2;

    setState(() {
      if (media >= 6) {
        _resultadoTexto = 'Aprovado!\nMédia: ${media.toStringAsFixed(1)}';
        _resultadoCor = Colors.green;
      } else {
        _resultadoTexto = 'Reprovado.\nMédia: ${media.toStringAsFixed(1)}';
        _resultadoCor = Colors.red;
      }
    });
  }

  @override
  void dispose() {
    _nota1Controller.dispose();
    _nota2Controller.dispose();
    super.dispose();
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
              onPressed: () {
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('Digite a primeira nota:'),
            const SizedBox(height: 8),
            _buildTextField('N1', _nota1Controller),

            const SizedBox(height: 20),

            _buildLabel('Digite a segunda nota:'),
            const SizedBox(height: 8),
            _buildTextField('N2', _nota2Controller),

            const SizedBox(height: 30),

            _buildLabel('Resultado:'),
            const SizedBox(height: 8),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F8FA),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  _resultadoTexto,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: _resultadoCor,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

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
                onPressed: _calcularMedia,
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
          ],
        ),
      ),
    );
  }

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

  Widget _buildTextField(String hintText, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
        signed: false,
      ),
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
