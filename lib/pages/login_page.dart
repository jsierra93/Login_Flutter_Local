import 'package:SqliteFlutter/widget/dialog_popup.dart';
import 'package:flutter/material.dart';
import 'package:SqliteFlutter/pages/home_page.dart';
import 'package:SqliteFlutter/pages/signup_page.dart';
import 'package:SqliteFlutter/providers/login_provider.dart';
import 'package:SqliteFlutter/services/user_db.dart';
import 'package:SqliteFlutter/widget/rounded_button.dart';
import 'package:SqliteFlutter/widget/widget_personalizados.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                _titleContainer(),
                _formContainer(),
                _buttonContainer(),
              ],
            )),
      ),
    );
  }

  Widget _titleContainer() {
    final double heightDevices = MediaQuery.of(context).size.height;
    return Container(
        height: heightDevices * 0.4,
        width: double.infinity,
        color: Colors.white,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: heightDevices * 0.35,
              child: Image.asset(
                "assets/images/Logo_Demo.png",
                fit: BoxFit.contain,
              ),
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
        ));
  }

  Widget _formContainer() {
    var loginProvider = Provider.of<LoginProvider>(context);
    var hidePass = true;
    String user;
    String pass;
    return Container(
        padding: EdgeInsets.all(20.0),
        color: Colors.white,
        height: (MediaQuery.of(context).size.height * 0.4),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Spacer(),
              TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onSaved: (value) {
                    user = value;
                    loginProvider.user = value;
                  },
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      labelText: 'usuario', icon: Icon(Icons.people))),
              Spacer(),
              TextFormField(
                  onSaved: (value) {
                    pass = value;
                    loginProvider.pass = value;
                  },
                  obscureText: hidePass,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    labelText: 'contraseña',
                    icon: Icon(Icons.lock),
                  )),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  RoundedButton(
                    color: Colors.blue,
                    text: "Ingresar",
                    press: () {
                      final form = _formKey.currentState;
                      form.save();
                      form.reset();
                      if (user.isNotEmpty && pass.isNotEmpty) {
                        UserDb.db.authenticator(user, pass).then((isLogin) {
                          if (isLogin) {
                            loginProvider.isLogin = true;
                            FocusScope.of(context).requestFocus(
                                FocusNode()); // para ocultar el teclado
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return (HomePage());
                            }));
                          } else {
                            DialogPopup(
                                titulo: 'Autenticación',
                                texto:
                                    'Usuario/Contraseña incorrecta. \n Intente nuevamente.',
                                press: () {
                                  Navigator.of(context).pop();
                                }).showDialogPopup(context);
                          }
                        });
                      } else {
                        DialogPopup(
                            titulo: 'Autenticación',
                            texto:
                                'Debe ingresar usuario y contraseña. \n Intente nuevamente.',
                            press: () {
                              Navigator.of(context).pop();
                            }).showDialogPopup(context);
                      }
                    },
                  ),
                  RoundedButton(
                    color: Colors.blue,
                    text: "Registrar",
                    press: () {
                      final form = _formKey.currentState;
                      form.save();
                      form.reset();
                      FocusScope.of(context)
                          .requestFocus(FocusNode()); // para ocultar el teclado
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return (SignupPage());
                      }));
                    },
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget _buttonContainer() {
    return SingleChildScrollView(
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.2,
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

}
