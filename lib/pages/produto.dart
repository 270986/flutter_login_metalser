class Produto {
  int produtoId;
  String nome;
  String descricao;
  double preco;
  bool ativo;
  String imagemUrl;

  Produto(
      {this.produtoId,
      this.nome,
      this.descricao,
      this.preco,
      this.ativo,
      this.imagemUrl});

  Produto.fromJson(Map<String, dynamic> json) {
    produtoId = json['produtoId'];
    nome = json['nome'];
    descricao = json['descricao'];
    preco = json['preco'];
    ativo = json['ativo'];
    imagemUrl = json['imagemUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['produtoId'] = this.produtoId;
    data['nome'] = this.nome;
    data['descricao'] = this.descricao;
    data['preco'] = this.preco;
    data['ativo'] = this.ativo;
    data['imagemUrl'] = this.imagemUrl;
    return data;
  }
}