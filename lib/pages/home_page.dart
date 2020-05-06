import 'package:flutter/material.dart';
import 'package:login_flutter_local/providers/login_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
      ),
      body:  Container(
        child: Row(
          children: <Widget>[
            Text('Hola : ' + loginProvider.email.toString()),
            Spacer(),
            RaisedButton(
                child: Text('Cerrar Sesion'),
                onPressed: () {
                  loginProvider.isLogin = false;
                  loginProvider.email = '';
                  loginProvider.pass = '';
                  Navigator.of(context).pop();
                })
          ],
        ),
      ),
    );
  }
}
