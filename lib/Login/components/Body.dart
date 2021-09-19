import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:projetbadr/Login/components/background.dart';
import 'package:projetbadr/Signup/signup_screen.dart';
import 'package:projetbadr/aceeuil_screen.dart';
import 'package:projetbadr/components/already_have_an_account_check.dart';
import 'package:projetbadr/components/rounded_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants.dart';

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String message = "";
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _email = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _name = TextEditingController();

  signIn(String email, String pass) async {
    String url = "http://192.168.1.109:8000/api/login";
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'authorization': 'Basic c3R1ZHlkb3RlOnN0dWR5ZG90ZTEyMw=='
    };
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var jsonRespnses;
    var res = await http.post(Uri.parse(url),
        headers: headers,
        body: json.encode({"email": _email.text, "password": _pass.text}));
    if (res.statusCode == 200) {
      jsonRespnses = json.decode(res.body);
      print("Response status : ${res.statusCode}");
      print("Response status : ${res.body}");

      if (jsonRespnses != null) {
        setState(() {
          _isLoading = false;
        });
        sharedPreferences.setString("api_token", jsonRespnses['api_token']);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AcceuilScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BackGround(
      child: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: size.height,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/images/l.png",
                  width: 800,
                  height: size.height * 0.2,
                ),
                SizedBox(height: size.height * 0.03),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextFormField(
                    onFieldSubmitted: (value) {
                      signIn(_email.text, _pass.text);
                    },
                    onEditingComplete: () {},
                    controller: _email,
                    onChanged: (value) {
                      _email
                        ..text = value
                        ..selection =
                            TextSelection.collapsed(offset: _email.text.length);
                    },
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      hintText: "Your Email",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.lightBlueAccent,
                    borderRadius: BorderRadius.circular(29),
                  ),
                  child: TextFormField(
                    onEditingComplete: () {},
                    onChanged: (value) {
                      _pass
                        ..text = value
                        ..selection =
                            TextSelection.collapsed(offset: _pass.text.length);
                    },
                    controller: _pass,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                RoundedButton(
                    text: "LOGIN",
                    press: () {
                      signIn(_email.text, _pass.text);
                    }),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
