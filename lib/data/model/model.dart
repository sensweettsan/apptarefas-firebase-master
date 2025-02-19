class Livro {
  String? id; // ID do documento no Firestore
  String titulo;
  String autor;
  int anoPublicacao;
  double avaliacao; // Avaliação de 1 a 5
  String? urlCapa; // URL da imagem da capa

  Livro({
    this.id,
    required this.titulo,
    required this.autor,
    required this.anoPublicacao,
    required this.avaliacao,
    this.urlCapa,
  });

  // Método para converter o objeto Livro em um Map (útil para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'autor': autor,
      'anoPublicacao': anoPublicacao,
      'avaliacao': avaliacao,
      'urlCapa': urlCapa,
    };
  }

  // Método para criar um objeto Livro a partir de um Map (útil para ler do Firestore)
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
