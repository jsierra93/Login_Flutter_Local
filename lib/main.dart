import 'package:flutter/material.dart';
import 'package:SqliteFlutter/providers/login_provider.dart';
import 'package:provider/provider.dart';

import 'pages/login_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
          child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login Flutter',
        home: LoginPage(),
      ), create: ( context)=> LoginProvider(),
    );
  }
}
