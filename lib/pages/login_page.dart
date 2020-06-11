import 'package:flutter/material.dart';
import 'package:flutter_login_metalser/pages/alerta.dart';
import 'package:flutter_login_metalser/pages/home_page.dart';
import 'package:flutter_login_metalser/pages/login_api.dart';

class LoginPage extends StatelessWidget {
  
  final _ctrlLogin = TextEditingController();
  final _ctrlSenha = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Metalser", style: 
        TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: _body(context),
    );
  }

  _body(BuildContext context) {
    return Form(
      key: _formKey,      
      child: Container(        
        padding: EdgeInsets.all(15),     
        child: ListView(        
          children: <Widget>[
  
          
          SizedBox(height: 50.0),
                        
           _textFormField(
              "Login",
              "Digite o Usuario",
              controller: _ctrlLogin,
              validator : _validaLogin
            ),

                 SizedBox(height: 30.0),


            _textFormField(
              "Senha",
              "Digite a Senha",
              senha: true,
              controller: _ctrlSenha,
              validator : _validaSenha
            ),

                 SizedBox(height: 50.0),


            _raisedButton("Login", Colors.blue, context),
          ],
        ),
      ),
    );
  }

  

  _textFormField(
    String label,
    String hint, {
    bool senha = false,
    TextEditingController controller,
    FormFieldValidator<String> validator,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: senha,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))
      ),
    );
  }

  String _validaLogin(String texto) {
    if(texto.isEmpty){
      return "Digite o Login";
    }
    if(texto.length<3){
      return "O campo precisa ter mais de 3 caracteres";
    }
    return null;
  }

  String _validaSenha(String texto) {
    if(texto.isEmpty){
      return "Digite a Senha";
    }
    return null;
  }

  _raisedButton(
    String texto, 
    Color cor, 
    BuildContext context) {
    return RaisedButton(
      
      color: cor,
      padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),     
      child: Text(
        texto,
        style: TextStyle(
          color: Colors.white,
          
          fontSize: 20        

        ),
      ),
      onPressed: () {
        _clickButton(context);
      },
    );
  }

   _clickButton(BuildContext context) async {
    bool formOk = _formKey.currentState.validate();

    if (!formOk) {
      return;
    }
    String login = _ctrlLogin.text;
    String senha = _ctrlSenha.text;

    print("login : $login senha: $senha");

    var usuario = await LoginApi.login(login,senha);
    
    if( usuario != null){

      print("==> $usuario");
      
      _navegaHomepage(context);
    }else{
      alert(context,"Login Inválido");
    }
  }
  _navegaHomepage(BuildContext context){
    Navigator.push( 
      context, MaterialPageRoute(
        builder : (context)=> HomePage()),
    );
  }
}