
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List artigos = [];
  int paginaAtual = 0;
  final PageController pageController = PageController();

  @override
  void initState() {
    super.initState();
    carregarArtigos();
  }

  Future<void> carregarArtigos() async {
    final String resposta =
        await rootBundle.loadString('assets/artigos.json');

    final dados = jsonDecode(resposta);

    setState(() {
      artigos = dados;
    });
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aprender+'),
        backgroundColor: const Color(0xFF145C9E),
        foregroundColor: const Color(0xFFEAF2EF),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_outlined),
          ),
        ],
      ),

      body: artigos.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Olá, Estudante!',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF23022E),
                    ),
                  ),

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 160,
                    child: PageView.builder(
                      controller: pageController,
                      itemCount: artigos.length < 3 ? artigos.length : 3,
                      onPageChanged: (index) {
                        setState(() => paginaAtual = index);
                      },
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF145C9E),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Center(
                            child: Text(
                              artigos[index]['titulo'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color(0xFFEAF2EF),
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: 12),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      artigos.length < 3 ? artigos.length : 3,
                      (index) => Container(
                        margin: const EdgeInsets.all(4),
                        width: 9,
                        height: 9,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: paginaAtual == index
                              ? const Color(0xFF145C9E)
                              : const Color(0xFFD3C5D1),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  const Text(
                    'Artigos disponíveis',
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  ...artigos.map((artigo) {
                    return Card(
                      child: ListTile(
                        leading: const Icon(
                          Icons.article_outlined,
                          color: Color(0xFF145C9E),
                        ),
                        title: Text(artigo['titulo']),
                        subtitle: Text(
                          '${artigo['descricao']}\n${artigo['data']}',
                        ),
                        isThreeLine: true,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetalheArtigo(
                                artigo: artigo,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  }),
                ],
              ),
            ),

      bottomNavigationBar: NavigationBar(
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
          NavigationDestination(
            icon: Icon(Icons.library_books),
            label: 'Resumos',
          ),
        ],
      ),
    );
  }
}

class DetalheArtigo extends StatelessWidget {
  final Map artigo;

  const DetalheArtigo({super.key, required this.artigo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Artigo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              artigo['titulo'],
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            Text(artigo['descricao']),
            const SizedBox(height: 15),
            Text(artigo['data']),
          ],
        ),
      ),
    );
  }
}
