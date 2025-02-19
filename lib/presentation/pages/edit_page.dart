import 'package:app_gerenciamento_de_tarefas/data/model/model.dart';
import 'package:app_gerenciamento_de_tarefas/data/repository/tarefa_repository.dart';
import 'package:app_gerenciamento_de_tarefas/presentation/viewmodel/tarefa_viewmodel.dart';
import 'package:flutter/material.dart';
// Importe o ViewModel

class EditLivroPage extends StatefulWidget {
  final Livro livro;

  const EditLivroPage({super.key, required this.livro});

  @override
  State<EditLivroPage> createState() => _EditLivroPageState();
}

class _EditLivroPageState extends State<EditLivroPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController tituloController;
  late TextEditingController autorController;
  late TextEditingController anoPublicacaoController;
  late TextEditingController avaliacaoController;
  late TextEditingController urlCapaController;
  final LivroViewmodel _viewModel = LivroViewmodel(LivroRepository());

  @override
  void initState() {
    super.initState();
    tituloController = TextEditingController(text: widget.livro.titulo);
    autorController = TextEditingController(text: widget.livro.autor);
    anoPublicacaoController =
        TextEditingController(text: widget.livro.anoPublicacao.toString());
    avaliacaoController =
        TextEditingController(text: widget.livro.avaliacao.toString());
    urlCapaController = TextEditingController(text: widget.livro.urlCapa);
  }

  @override
  void dispose() {
    tituloController.dispose();
    autorController.dispose();
    anoPublicacaoController.dispose();
    avaliacaoController.dispose();
    urlCapaController.dispose();
    super.dispose();
  }

  Future<void> saveEdits() async {
    if (_formKey.currentState!.validate()) {
      final updatedLivro = Livro(
        id: widget.livro.id,
        titulo: tituloController.text,
        autor: autorController.text,
        anoPublicacao: int.parse(anoPublicacaoController.text),
        avaliacao: double.parse(avaliacaoController.text),
        urlCapa: urlCapaController.text,
      );

      try {
        await _viewModel.updateBook(widget.livro.id!, updatedLivro);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Livro atualizado com sucesso!')),
          );
          Navigator.pop(context, true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Erro ao atualizar o livro: ${e.toString()}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Livro'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  _buildTextField(tituloController, 'Título',
                      'Por favor, insira o título do livro'),
                  const SizedBox(height: 16),
                  _buildTextField(autorController, 'Autor',
                      'Por favor, insira o autor do livro'),
                  const SizedBox(height: 16),
                  _buildTextField(anoPublicacaoController, 'Ano de Publicação',
                      'Por favor, insira o ano de publicação',
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _buildTextField(avaliacaoController, 'Avaliação (1 a 5)',
                      'Por favor, insira a avaliação',
                      keyboardType: TextInputType.number),
                  const SizedBox(height: 16),
                  _buildTextField(urlCapaController, 'URL da Capa',
                      'Por favor, insira a URL da capa'),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: saveEdits,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,
                      padding: const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)),
                    ),
                    icon: const Icon(Icons.save, size: 24),
                    label: const Text('Salvar', style: TextStyle(fontSize: 18)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, String errorMsg,
      {TextInputType keyboardType = TextInputType.text, int maxLines = 1}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) => value == null || value.isEmpty ? errorMsg : null,
    );
  }
}
