class Livro {
  String? id;
  String titulo;
  String autor;
  int anoPublicacao;
  double avaliacao; // Novo campo para avaliação
  String? urlCapa;

  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.anoPublicacao,
    required this.avaliacao,
    this.urlCapa,
  });

  // Método para converter o objeto Livro em um Map
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'autor': autor,
      'anoPublicacao': anoPublicacao,
      'avaliacao': avaliacao,
      'urlCapa': urlCapa,
    };
  }

  // Método para criar um objeto Livro a partir de um Map
  factory Livro.fromMap(Map<String, dynamic> map, String id) {
    return Livro(
      id: id,
      titulo: map['titulo'],
      autor: map['autor'],
      anoPublicacao: map['anoPublicacao'],
      avaliacao: map['avaliacao'],
      urlCapa: map['urlCapa'],
    );
  }
}