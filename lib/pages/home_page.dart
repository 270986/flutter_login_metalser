import 'package:flutter/material.dart';
import 'package:flutter_login_metalser/pages/produto.dart';
import 'package:flutter_login_metalser/pages/produtos_api.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text("Catálogo de Produtos", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _body(),
    );
  }

  _body() {
    Future<List<Produto>> produtos = ProdutosApi.getProdutos();
    return FutureBuilder(
       future: produtos,
       builder: (context, snapshot){

        if(snapshot.hasError){
          return Center(child: Text("Erro ao acessar os dados"));
        }

        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator());
        }

          List<Produto> produtos = snapshot.data;
          return _listView(produtos);
       },
     );
  }

  _listView(produtos) {
    return Container(
      padding: EdgeInsets.all(20),
      child: ListView.builder(
        itemCount:  produtos!=null ? produtos.length : 0,
        itemBuilder: (context, index) {
          Produto p = produtos[index];

          return Card(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.network(p.imagemUrl, width: 150),
              ),
              Text(
                p.nome,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                p.descricao,
                style: TextStyle(fontSize: 20),
              ),
              Text(
                p.preco.toString(),
                style: TextStyle(fontSize: 20),
              ),
              ButtonTheme(
                child: ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      child: Text("Detalhes"),onPressed:() {} ,
                     )
                  ],
                 )
               )
            ],
          ));
        },
      ),
    );
  }
}