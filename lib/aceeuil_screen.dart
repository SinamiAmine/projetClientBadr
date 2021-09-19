import 'package:flutter/material.dart';
import 'package:projetbadr/Login/login_screen.dart';
import 'package:projetbadr/MovieList.dart';

class AcceuilScreen extends StatefulWidget {
  const AcceuilScreen({Key? key}) : super(key: key);

  @override
  _AcceuilScreenState createState() => _AcceuilScreenState();
}

class _AcceuilScreenState extends State<AcceuilScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("Acceuil"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new LoginScreen()));
              },
              child: Icon(Icons.logout),
            ),
          )
        ],
      ),
      body: MovieList(),
    );
  }
}
