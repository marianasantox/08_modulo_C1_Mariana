
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(4, (_) => FocusNode());

  bool pinIncorreto = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    // Manter a tela na vertical
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    // Abrir teclado automaticamente
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        FocusScope.of(context).requestFocus(focusNodes[0]);
      }
    });
  }

  void verificarPin() {
    String pin = controllers.map((c) => c.text).join();

    // Verificar campos obrigatórios
    if (controllers.any((c) => c.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todos os campos são obrigatórios'),
        ),
      );
      return;
    }

    // PIN correto
    if (pin == '3245') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginPage(),
        ),
      );
    } else {
      // PIN incorreto
      setState(() {
        pinIncorreto = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pin incorreto'),
          duration: Duration(seconds: 2),
        ),
      );

      // Limpar os campos
      for (var controller in controllers) {
        controller.clear();
      }

      // Manter caixas vermelhas por 2 segundos
      timer?.cancel();
      timer = Timer(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() {
            pinIncorreto = false;
          });
          focusNodes[0].requestFocus();
        }
      });
    }
  }

  void alterarCampo(int index, String value) {
    if (value.isNotEmpty) {
      // Avançar para o próximo campo
      if (index < 3) {
        focusNodes[index + 1].requestFocus();
      } else {
        focusNodes[index].unfocus();
      }
    } else {
      // Voltar para o campo anterior
      if (index > 0) {
        focusNodes[index - 1].requestFocus();
      }
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    for (var controller in controllers) {
      controller.dispose();
    }

    for (var node in focusNodes) {
      node.dispose();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(25),

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                // LOGO
                Image.asset(
                  'assets/logo.png',
                  width: 150,
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(
                      Icons.school,
                      size: 100,
                      color: Color(0xFF6650A4),
                    );
                  },
                ),

                const SizedBox(height: 35),

                // TÍTULO
                const Text(
                  'Digite seu PIN de acesso',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 23,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF333333),
                  ),
                ),

                const SizedBox(height: 35),

                // QUATRO CAMPOS DO PIN
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {

                    return Container(
                      width: 58,
                      height: 65,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 7,
                      ),

                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],

                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        obscureText: true,
                        maxLength: 1,

                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(1),
                        ],

                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),

                        decoration: InputDecoration(
                          counterText: '',
                          filled: true,
                          fillColor: Colors.white,

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: pinIncorreto
                                  ? Colors.red
                                  : const Color(0xFF6650A4),
                              width: 2,
                            ),
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color: pinIncorreto
                                  ? Colors.red
                                  : const Color(0xFF6650A4),
                              width: 2,
                            ),
                          ),
                        ),

                        onChanged: (value) {
                          alterarCampo(index, value);
                        },
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 40),

                // BOTÃO ENTRAR
                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(
                    onPressed: verificarPin,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF6650A4),
                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),

                    child: const Text(
                      'Entrar',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
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
