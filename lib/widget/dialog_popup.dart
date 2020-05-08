import 'package:flutter/material.dart';

class DialogPopup{
  final String titulo;
  final String texto;
  final Function press;

  const DialogPopup(
      {@required this.titulo, @required this.texto, @required this.press}
      );

  init(){
    print('init');
  }

  Future<void> showDialogPopup(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(titulo, style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold
          ),)),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(texto, style: TextStyle(
            fontSize: 16,
          )),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Cerrar'),
              onPressed: press,
            ),
          ],
        );
      },
    );
  }

}
