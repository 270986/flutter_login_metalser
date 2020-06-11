import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_login_metalser/pages/usuario.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi{
   static Future<Usuario> login(String user, 
                          String password) async {

  var url =
  'http://189.84.211.26/api_metalser/api/token';

  var header = {"Content-Type" : "application/json"};

  Map params = {
    "USUA_DS_LOGIN" : user,
    "USUA_CD_SENHA" : password    
  };
  
  var usuario;

  var prefs = await SharedPreferences.getInstance();

  var _body = json.encode(params);
  print("json enviado: $_body");

  var response = await http.post(url, headers:header,
                                body: _body);

  Map mapResponse = json.decode(response.body);

  String messagem = mapResponse["message"];
  String token = mapResponse["token"];

  print("message $messagem");
  print("message $token");


  if(response.statusCode == 200){
    usuario = Usuario.fromJson(mapResponse);
    prefs.setString("tokenjwt", mapResponse["token"]);
  }else{
    usuario = null;
  }
  return usuario;

 }
}