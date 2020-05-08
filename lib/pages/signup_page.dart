import 'package:SqliteFlutter/widget/dialog_popup.dart';
import 'package:flutter/material.dart';
import 'package:SqliteFlutter/model/User.dart';
import 'package:SqliteFlutter/pages/home_page.dart';
import 'package:SqliteFlutter/providers/login_provider.dart';
import 'package:SqliteFlutter/services/user_db.dart';
import 'package:SqliteFlutter/widget/rounded_button.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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
              ],
            )),
      ),
    );
  }

  Widget _titleContainer() {
    final double heightDevices = MediaQuery.of(context).size.height;

    return Container(
        height: (heightDevices * 0.40),
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
              'Registrarme',
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
    final double heightDevices = MediaQuery.of(context).size.height;
    var loginProvider = Provider.of<LoginProvider>(context);
    var hidePass = true;
    var focusUser = false;
    String user;
    String pass;
    String email;

    return Container(
      height: (heightDevices * 0.6),
      padding: EdgeInsets.only(left: 20.0, right: 20.0),
      color: Colors.white,
      child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            TextFormField(
                autofocus: focusUser,
                keyboardType: TextInputType.text,
                onSaved: (value) {
                  user = value;
                  loginProvider.user = value;
                },
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    labelText: 'usuario', icon: Icon(Icons.people))),
            SizedBox(
              height: 20,
            ),
            TextFormField(
                keyboardType: TextInputType.emailAddress,
                onSaved: (value) {
                  email = value;
                  loginProvider.email = value;
                },
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                    labelText: 'email', icon: Icon(Icons.email))),
            SizedBox(
              height: 20,
            ),
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
                  text: "Registrar",
                  press: () {
                    final form = _formKey.currentState;
                    form.save();
                    form.reset();
                    if (user.isNotEmpty &&
                        pass.isNotEmpty &&
                        email.isNotEmpty) {
                      User newUser = new User(
                          user: user,
                          email: email,
                          pass: pass,
                          profile: 'admin');
                      print('Usuario nuevo: ' + newUser.toString());
                      UserDb.db.insertUser(newUser).then((cantRegistro) {
                        print('registrado : $cantRegistro');
                        if (cantRegistro) {
                          loginProvider.isLogin = true;
                          FocusScope.of(context).requestFocus(
                              FocusNode()); // para ocultar el teclado
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return (HomePage());
                          }));
                        } else {
                          DialogPopup(
                              titulo: 'Registrarme',
                              texto:
                                  'No fue posible crear nuevo usuario. \n Intente nuevamente.',
                              press: () {
                                Navigator.of(context).pop();
                              }).showDialogPopup(context);
                        }
                      });
                    } else {
                      DialogPopup(
                          titulo: 'Registrarme',
                          texto:
                              'Debe ingresar usuario, email y contraseña. \n Intente nuevamente.',
                          press: () {
                            Navigator.of(context).pop();
                          }).showDialogPopup(context);
                      focusUser = true;
                    }
                  },
                ),
                RoundedButton(
                  color: Colors.blue,
                  text: "Volver",
                  press: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
