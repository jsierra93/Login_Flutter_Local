import 'package:flutter/material.dart';
import 'package:login_flutter_local/model/User.dart';
import 'package:login_flutter_local/pages/login_page.dart';
import 'package:login_flutter_local/providers/login_provider.dart';
import 'package:login_flutter_local/services/user_db.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future<List<User>> _getUsers = UserDb.db.getUsers();
    var loginProvider = Provider.of<LoginProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Lista de usuarios registrados'),
          centerTitle: true,
        ),
        body: Column(children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Hola : ' + loginProvider.user.toString(),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              RaisedButton(
                  child: Text('Cerrar Sesion'),
                  onPressed: () {
                    loginProvider.isLogin = false;
                    loginProvider.email = '';
                    loginProvider.pass = '';
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return (LoginPage());
                    }));
                  }),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.8,
            child: FutureBuilder(
                future: _getUsers,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading...")));
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _tileUser(snapshot.data[index].user,
                              snapshot.data[index].email, Icons.people);
                        });
                  }
                }),
          ),
        ])
        /* Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Text('Hola : ' + loginProvider.user.toString()),
                Spacer(),
                RaisedButton(
                    child: Text('Cerrar Sesion'),
                    onPressed: () {
                      loginProvider.isLogin = false;
                      loginProvider.email = '';
                      loginProvider.pass = '';
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return (LoginPage());
                      }));
                    }),
              ],
            ),
            _listUser()
          ],
        ),*/
        );
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
}
