import 'package:flutter/material.dart';
//import 'package:progress_dialog/progress_dialog.dart';

class BotonRedesSociales extends StatelessWidget {
  String texto;
  String icono;
  String colorHex;

  BotonRedesSociales(
      {@required this.texto, @required this.icono, @required this.colorHex});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        shape: StadiumBorder(),
        elevation: 4,
        child: Row(
          children: <Widget>[
            Image.asset(
              icono,
              color: Colors.white,
              height: 30,
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
        color: convertColorHex(colorHex), //Color(0xff0091ea),
        textColor: Colors.white,
        splashColor: Colors.black45,
        onPressed: () {
          
        });
  }
}

Color convertColorHex(String color) {
  color = color.replaceAll("#", "");
  if (color.length == 6) {
    return Color(int.parse("0xFF" + color));
  } else if (color.length == 8) {
    return Color(int.parse("0x" + color));
  }
}

/*
ProgressDialog pr =
              new ProgressDialog(context, type: ProgressDialogType.Normal);
          pr.style(
            message: 'Ingresando via ' + texto,
          );
          pr.show();
*/