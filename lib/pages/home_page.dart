import 'package:flutter/material.dart';
import 'package:SqliteFlutter/model/User.dart';
import 'package:SqliteFlutter/pages/login_page.dart';
import 'package:SqliteFlutter/providers/login_provider.dart';
import 'package:SqliteFlutter/services/user_db.dart';
import 'package:SqliteFlutter/widget/widget_personalizados.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double heightDevice = MediaQuery.of(context).size.height;
    Future<List<User>> _getUsers = UserDb.db.getUsers();
    var loginProvider = Provider.of<LoginProvider>(context);

    return Scaffold(
        body: Column(children: <Widget>[
      Container(
        color: Colors.blue,
        height: heightDevice * 0.13,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(top: 30.0, left: 20, right: 10, bottom: 0),
          child: Row(
            children: <Widget>[
              Icon(
                Icons.people,
                size: 30,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Bienvenido ',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Text(
                loginProvider.user.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
              Spacer(),
              bottonLogOut('Logout', Icons.exit_to_app, () {
                loginProvider.isLogin = false;
                loginProvider.email = '';
                loginProvider.pass = '';
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return (LoginPage());
                }));
              }, Colors.blue),
            ],
          ),
        ),
      ),
      Container(
        width: double.infinity,
        height: 50,
        padding: EdgeInsets.only(top: 10, bottom: 0),
        child: Center(
          child: Text('Usuarios registrados en BD', style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),),
        ),
      ),
      Container(
        padding: EdgeInsets.only(top:0, left: 20, right: 20),
        height: MediaQuery.of(context).size.height * 0.8,
        child: FutureBuilder(
            future: _getUsers,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Container(child: Center(child: Text("Loading...")));
              } else {
                return ListView.separated(
                    separatorBuilder: (context, index) => Divider(
                          color: Colors.blue,
                        ),
                    itemCount: snapshot.data.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _tileUser(snapshot.data[index].user,
                          snapshot.data[index].email, Icons.people);
                    });
              }
            }),
      ),
    ]));
  }

  ListTile _tileUser(String title, String subtitle, IconData icon) => ListTile(
        title: Text(title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            )),
        subtitle: Text(subtitle),
        leading: Icon(
          icon,
          size: 40,
          color: Colors.blue[500],
        ),
        onTap: () {
          print('clic en el boton: $title');
        },
      );

  RaisedButton bottonLogOut(
      String texto, IconData icono, Function press, Color color) {
    return RaisedButton(
        shape: StadiumBorder(),
        elevation: 4,
        child: Row(
          children: <Widget>[
            Icon(
              Icons.people,
              size: 30,
              color: Colors.white,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Text(
                texto,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        padding: EdgeInsets.all(15),
        color: color,
        textColor: Colors.white,
        splashColor: Colors.black45,
        onPressed: press);
  }
}
