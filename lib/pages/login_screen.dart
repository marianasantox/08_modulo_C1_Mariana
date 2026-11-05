
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:social_app/home_page.dart';
import 'package:social_app/pages/login_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final List<TextEditingController> controllers =
      List.generate(4, (_) => TextEditingController());

  final List<FocusNode> focusNodes =
      List.generate(4, (_) => FocusNode());

  void verificarPin() {
    String pin = controllers.map((c) => c.text).join();

    if (pin.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todos os campos são obrigatórios'),
        ),
      );
      return;
    }

    if (pin == '3245') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Pin incorreto'),
        ),
      );

      for (var controller in controllers) {
        controller.clear();
      }

      focusNodes[0].requestFocus();
    }
  }

  @override
  void dispose() {
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
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.school,
                  size: 85,
                  color: Color(0xFF145C9E),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Aprender+',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF23022E),
                  ),
                ),
                const SizedBox(height: 35),
                const Text(
                  'Digite seu PIN de acesso',
                  style: TextStyle(fontSize: 19),
                ),
                const SizedBox(height: 25),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(4, (index) {
                    return SizedBox(
                      width: 55,
                      child: TextField(
                        controller: controllers[index],
                        focusNode: focusNodes[index],
                        autofocus: index == 0,
                        obscureText: true,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        decoration: const InputDecoration(
                          counterText: '',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 3) {
                            focusNodes[index + 1].requestFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: verificarPin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF145C9E),
                      foregroundColor: const Color(0xFFEAF2EF),
                    ),
                    child: const Text('Entrar'),
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
