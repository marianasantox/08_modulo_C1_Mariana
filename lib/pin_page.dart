
import 'package:flutter/material.dart';

class PinPage extends StatefulWidget {
  const PinPage({super.key});

  @override
  State<PinPage> createState() => _PinPageState();
}

class _PinPageState extends State<PinPage> {
  String pin = '';
  final String pinCorreto = '1234';

  void adicionarNumero(String numero) {
    if (pin.length < 4) {
      setState(() {
        pin += numero;
      });
    }
  }

  void apagarNumero() {
    if (pin.isNotEmpty) {
      setState(() {
        pin = pin.substring(0, pin.length - 1);
      });
    }
  }

  void confirmarPin() {
    if (pin == pinCorreto) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN confirmado com sucesso!'),
        ),
      );
    } else {
      setState(() {
        pin = '';
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('PIN incorreto. Tente novamente.'),
        ),
      );
    }
  }

  Widget botaoNumero(String numero) {
    return SizedBox(
      width: 75,
      height: 65,
      child: ElevatedButton(
        onPressed: () => adicionarNumero(numero),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: const Color(0xFF6650A4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: Text(
          numero,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5FA),
      appBar: AppBar(
        backgroundColor: const Color(0xFF6650A4),
        foregroundColor: Colors.white,
        title: const Text('Segurança'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.lock_outline,
                size: 65,
                color: Color(0xFF6650A4),
              ),

              const SizedBox(height: 20),

              const Text(
                'Digite seu PIN',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Insira seu código de 4 dígitos',
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 30),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  4,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 17,
                    height: 17,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index < pin.length
                          ? const Color(0xFF6650A4)
                          : Colors.grey.shade300,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 35),

              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      botaoNumero('1'),
                      botaoNumero('2'),
                      botaoNumero('3'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      botaoNumero('4'),
                      botaoNumero('5'),
                      botaoNumero('6'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      botaoNumero('7'),
                      botaoNumero('8'),
                      botaoNumero('9'),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const SizedBox(width: 75),
                      botaoNumero('0'),
                      SizedBox(
                        width: 75,
                        height: 65,
                        child: IconButton(
                          onPressed: apagarNumero,
                          icon: const Icon(
                            Icons.backspace_outlined,
                            color: Color(0xFF6650A4),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: pin.length == 4 ? confirmarPin : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6650A4),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    'Confirmar PIN',
                    style: TextStyle(fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
