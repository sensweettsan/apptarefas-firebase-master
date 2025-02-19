import '../../core/database.dart'; // Importe o helper do Firestore
import '../model/model.dart'; // Importe o modelo Livro

class LivroRepository {
  final String collection = 'livros'; // Nome da coleção no Firestore

  // Método para adicionar um novo livro ao Firestore (CREATE)
  Future<void> createBook(Livro livro) async {
    await DatabaseHelper.addDocument(collection, livro.toMap());
  }

  // Método para obter todos os livros do Firestore (READ)
  Future<List<Livro>> getBooks() async {
    List<Map<String, dynamic>> booksMaps =
        await DatabaseHelper.getDocuments(collection);
    return booksMaps.map((map) {
      return Livro.fromMap(map, map['id']); // Converte o Map em um objeto Livro
    }).toList();
  }

  // Método para atualizar um livro existente no Firestore (UPDATE)
  Future<void> updateBook(String id, Livro livro) async {
    await DatabaseHelper.updateDocument(collection, id, livro.toMap());
  }

  // Método para deletar um livro do Firestore (DELETE)
  Future<void> deleteBook(String id) async {
    await DatabaseHelper.deleteDocument(collection, id);
  }
}
