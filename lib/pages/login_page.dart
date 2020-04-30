import 'package:flutter/material.dart';
import 'package:login_flutter_local/widget/widget_personalizados.dart';

class LoginPage extends StatefulWidget {
  final bool isLogin = false;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          child: Column(
            children: <Widget>[
              _titleContainer(),
              _formContainer(),
              _buttonContainer(),
             _creditContainer()
            ],
          )),
    );
  }

  Widget _titleContainer() {
    return SingleChildScrollView(
      child: Container(
      height: (MediaQuery.of(context).size.height / 4)*1.2,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Spacer(),
              Image.asset(
                'assets/images/Logo_Demo.png',
                height: 200,
              ),
              Text(
                'Bienvenido',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.black,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w800),
              ),
            ],
          )),
    );
  }

  Widget _formContainer() {
    return SingleChildScrollView(
      child: Container(
          color: Colors.white,
      height: (MediaQuery.of(context).size.height / 4)*1.2,
          child: Padding(
            padding: const EdgeInsets.only(left: 25, right: 25),
            child: Column(
              children: <Widget>[
                Spacer(),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: 'email', icon: Icon(Icons.email))),
                Spacer(),
                TextFormField(
                    decoration: InputDecoration(
                        labelText: 'contraseña', icon: Icon(Icons.lock))),
                Spacer(),
                Container(
                  width: double.infinity,
                  height: 60,
                  child: RaisedButton(
                      shape: StadiumBorder(),
                      elevation: 4,
                      child: Text('Ingresar',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      padding: EdgeInsets.all(15),
                      color: Colors.blue,
                      textColor: Colors.white,
                      splashColor: Colors.black45,
                      onPressed: () {
                        
                      }),
                ),
              ],
            ),
          )),
    );
  }

  Widget _buttonContainer() {
    return SingleChildScrollView(
          child: Container(
        width: double.infinity,
        height: (MediaQuery.of(context).size.height / 4)*1.2,
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: <Widget>[
              Spacer(),
              BotonRedesSociales(
                texto: 'Facebook',
                icono: 'assets/images/logos_terceros/facebook.png',
                colorHex: '3b5999',
              ),
              Spacer(),
              BotonRedesSociales(
                texto: 'Twitter',
                icono: 'assets/images/logos_terceros/twitter.png',
                colorHex: '55acee',
              ),
              Spacer(),
              BotonRedesSociales(
                texto: 'Google',
                icono: 'assets/images/logos_terceros/google.png',
                colorHex: '8a8a8a',
              ),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _creditContainer() {
    return SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(vertical: 25),
        height: (MediaQuery.of(context).size.height / 4)*0.4,
        width: double.infinity,
        color: Colors.white,
        child: Text(
          'Jsierra93 ',
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 20,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.none),
        ),
      ),
    );
  }
}
