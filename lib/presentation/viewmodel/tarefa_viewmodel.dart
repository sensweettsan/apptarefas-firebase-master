import 'package:app_gerenciamento_de_tarefas/data/repository/tarefa_repository.dart';

import '../../data/model/model.dart'; // Importe o modelo Livro
// Importe o repositório

class LivroViewmodel {
  final LivroRepository repository;

  LivroViewmodel(this.repository);

  // Método para adicionar um livro (CREATE)
  Future<void> createBook(Livro livro) async {
    await repository.createBook(livro);
  }

  // Método para obter todos os livros (READ)
  Future<List<Livro>> getBooks() async {
    return await repository.getBooks();
  }

  // Método para atualizar um livro (UPDATE)
  Future<void> updateBook(String id, Livro livro) async {
    await repository.updateBook(id, livro);
  }

  // Método para deletar um livro (DELETE)
  Future<void> deleteBook(String id) async {
    await repository.deleteBook(id);
  }
}
