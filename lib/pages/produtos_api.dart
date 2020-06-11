import 'dart:convert';

import 'package:flutter_login_metalser/pages/produto.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProdutosApi{

 static Future<List<Produto>> getProdutos() async {

    List<Produto> produtos;

    var prefs = await SharedPreferences.getInstance();
    String token = (prefs.getString("tokenjwt") ?? "");

    print("token jwt : $token");

     var header = {
       "Content-Type" : "application/json",
       "Authorization" : "Bearer $token"
       };

    var url = 
    "http://189.84.211.26/api_metalser/api/token";

    var response = await http.get(url, headers: header);

    print("status code :  ${response.statusCode} ");
 
    if(response.statusCode == 200){

    List listaResponse = json.decode(response.body);
    
    produtos = List<Produto>();

    for(Map map in listaResponse){
          Produto p = Produto.fromJson(map);
          produtos.add(p);
    }
    }else{
      throw Exception;
    }
    return produtos;
  }
}