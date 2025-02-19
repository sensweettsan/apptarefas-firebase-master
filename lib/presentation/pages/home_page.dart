
import 'package:app_gerenciamento_de_tarefas/data/model/model.dart';
import 'package:app_gerenciamento_de_tarefas/data/repository/tarefa_repository.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/viewmodel/tarefa_viewmodel.dart';
import 'package:flutter/material.dart';

import 'cadastro_page.dart'; // Importe a página de cadastro de livros
import 'edit_page.dart'; // Importe a página de edição de livros

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Livro> _livros = [];
  final LivroViewmodel _viewModel = LivroViewmodel(LivroRepository());
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLivros();
  }

  Future<void> _loadLivros() async {
    final livros = await _viewModel.getBooks();
    if (mounted) {
      setState(() {
        _livros = livros
          ..sort((a, b) => a.titulo.compareTo(b.titulo)); // Ordena por título
        _isLoading = false;
      });
    }
  }

  void _deleteLivroComUndo(Livro livro) async {
    await _viewModel.deleteBook(livro.id!);
    if (mounted) {
      setState(() {
        _livros.removeWhere((l) => l.id == livro.id);
      });
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Livro "${livro.titulo}" excluído'),
          action: SnackBarAction(
            label: 'Desfazer',
            onPressed: () async {
              await _viewModel.createBook(livro);
              _loadLivros();
            },
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo de Livros'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _livros.isEmpty
                ? const Center(child: Text('Nenhum livro disponível.'))
                : ListView.builder(
                    itemCount: _livros.length,
                    itemBuilder: (context, index) {
                      final livro = _livros[index];
                      return Card(
                        elevation: 5,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                livro.titulo,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('Autor: ${livro.autor}'),
                              const SizedBox(height: 8),
                              Text('Ano de Publicação: ${livro.anoPublicacao}'),
                              const SizedBox(height: 8),
                              Text('Avaliação: ${livro.avaliacao} estrelas'),
                              const SizedBox(height: 8),
                              if (livro.urlCapa != null && livro.urlCapa!.isNotEmpty)
                                Image.network(
                                  livro.urlCapa!,
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit, color: Colors.orange),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => EditLivroPage(livro: livro),
                                        ),
                                      ).then((wasUpdated) {
                                        if (wasUpdated == true) {
                                          _loadLivros();
                                        }
                                      });
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () => _deleteLivroComUndo(livro),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CadastroLivro()),
          ).then((_) => _loadLivros());
        },
        backgroundColor: Colors.teal,
        tooltip: 'Adicionar Livro',
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}