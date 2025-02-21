import 'package:app_gerenciamento_de_tarefas/data/repository/tarefa_repository.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/viewmodel/tarefa_viewmodel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import '../../data/model/model.dart';

class CadastroLivro extends StatefulWidget {
  const CadastroLivro({super.key});

  @override
  State<CadastroLivro> createState() => _CadastroLivroState();
}

class _CadastroLivroState extends State<CadastroLivro> {
  final _formKey = GlobalKey<FormState>();
  final tituloController = TextEditingController();
  final autorController = TextEditingController();
  final anoPublicacaoController = TextEditingController();
  final avaliacaoController = TextEditingController();
  final LivroViewmodel _viewModel = LivroViewmodel(LivroRepository());
  final ImagePicker _picker = ImagePicker();
  XFile? _imagemSelecionada;

// Método para selecionar uma imagem da galeria
  Future<void> _selecionarImagem() async {
    final XFile? imagem = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imagemSelecionada = imagem;
    });
  }

// Método para fazer upload da imagem no Firebase Storage
  Future<String?> _uploadImagem() async {
    if (_imagemSelecionada == null) return null;

    final storageRef = FirebaseStorage.instance
        .ref()
        .child('capas/${DateTime.now().toString()}');
    await storageRef.putFile(File(_imagemSelecionada!.path));
    return await storageRef.getDownloadURL();
  }

  // Método para salvar o livro
  Future<void> saveLivro() async {
    try {
      if (_formKey.currentState!.validate()) {
        final urlCapa = await _uploadImagem();

        final livro = Livro(
          titulo: tituloController.text,
          autor: autorController.text,
          anoPublicacao: int.parse(anoPublicacaoController.text),
          avaliacao: double.parse(avaliacaoController.text),
          urlCapa: urlCapa,
        );

        await _viewModel.createBook(livro);

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Livro adicionado com sucesso!')),
          );
          Navigator.pop(context); // Fecha a página após salvar
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Erro ao salvar o livro: ${e.toString()}',
              style: const TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Livro'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const Text(
                        'Cadastrar um Livro',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.teal,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Campo Título
                      TextFormField(
                        controller: tituloController,
                        decoration: InputDecoration(
                          labelText: 'Título',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o título do livro';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Campo Autor
                      TextFormField(
                        controller: autorController,
                        decoration: InputDecoration(
                          labelText: 'Autor',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o autor do livro';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Campo Ano de Publicação
                      TextFormField(
                        controller: anoPublicacaoController,
                        decoration: InputDecoration(
                          labelText: 'Ano de Publicação',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira o ano de publicação';
                          }
                          if (int.tryParse(value) == null) {
                            return 'Ano de publicação inválido';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Campo Avaliação (1 a 5)
                      TextFormField(
                        controller: avaliacaoController,
                        decoration: InputDecoration(
                          labelText: 'Avaliação (1 a 5)',
                          labelStyle: TextStyle(color: Colors.teal.shade700),
                          border: const OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal.shade700),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a avaliação';
                          }
                          final avaliacao = double.tryParse(value);
                          if (avaliacao == null ||
                              avaliacao < 1 ||
                              avaliacao > 5) {
                            return 'Avaliação deve ser entre 1 e 5';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      // Campo para selecionar imagem da capa
                      if (_imagemSelecionada != null)
                        Image.file(
                          File(_imagemSelecionada!.path),
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ElevatedButton(
                        onPressed: _selecionarImagem,
                        child: const Text('Selecionar Imagem da Capa'),
                      ),
                      const SizedBox(height: 30),
                      // Botão de Salvar
                      ElevatedButton.icon(
                        onPressed: saveLivro,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(
                            vertical: 15.0,
                            horizontal: 30.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        icon: const Icon(Icons.save, size: 24),
                        label: const Text(
                          'Salvar',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
