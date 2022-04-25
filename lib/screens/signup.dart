import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travel/API/API.dart';
import 'package:travel/components/colors.dart';
import 'package:travel/screens/login.dart';
import 'package:travel/screens/menu.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _obscureText = false;
  bool showPassword = false;
  String username = '';
  String password = '';
  String email = '';
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  register(String username, password, email) async {
    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
    };

    var response = await http.post(
      Uri.parse('https://travel27.herokuapp.com/user/register'),
      headers: requestHeaders,
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
        'email': email,
      }),
    );
    print(json.decode(response.body));

    if (response.statusCode == 201 || response.statusCode == 200) {
      print('Registered successfully');
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 70),
              child: Text(
                'Welcome to Traveln',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  color: MyColor.secClr,
                ),
              ),
            ),
            Container(
              height: 300,
              child: Lottie.network(
                  'https://assets6.lottiefiles.com/packages/lf20_6wuFVO.json'),
            ),
            Container(
                child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Form(
                      key: formkey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 10.0, right: 150),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: MyColor.secClr,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              width: 310,
                              height: 42,
                              decoration: BoxDecoration(
                                color: MyColor.orClr.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 5, bottom: 3),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: usernameController,
                                  decoration: new InputDecoration(
                                      hintText: "Enter username",
                                      hintStyle: TextStyle(fontSize: 14),
                                      fillColor: Colors.white,
                                      counterText: "",
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 310,
                              height: 42,
                              decoration: BoxDecoration(
                                color: MyColor.orClr.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 5, bottom: 3),
                                child: TextFormField(
                                  obscureText: !this.showPassword,
                                  controller: passwordController,
                                  maxLength: 6,
                                  decoration: new InputDecoration(
                                      hintText: "Enter Password",
                                      hintStyle: TextStyle(fontSize: 14),
                                      fillColor: Colors.white,
                                      counterText: "",
                                      suffixIcon: IconButton(
                                        icon: Icon(_obscureText
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_outlined),
                                        color: this.showPassword
                                            ? MyColor.bg1Clr
                                            : MyColor.bg1Clr,
                                        onPressed: () {
                                          setState(() => this.showPassword =
                                              !this.showPassword);
                                          _obscureText = !_obscureText;
                                        },
                                      ),
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Visibility(
                              visible: false,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text('Password Incorrect',
                                        style: TextStyle(
                                            color: MyColor.secClr,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: 310,
                              height: 42,
                              decoration: BoxDecoration(
                                color: MyColor.orClr.withOpacity(0.1),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 15, right: 5, bottom: 4),
                                child: TextFormField(
                                  autovalidateMode: AutovalidateMode.always,
                                  controller: emailController,
                                  decoration: new InputDecoration(
                                      hintText: "Enter email",
                                      hintStyle: TextStyle(fontSize: 14),
                                      fillColor: Colors.white,
                                      counterText: "",
                                      border: InputBorder.none),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                  top: 15.0,
                                ),
                                child: Center(
                                  child: Container(
                                    height: 42,
                                    width: 310,
                                    child: ValueListenableBuilder<
                                            TextEditingValue>(
                                        valueListenable: passwordController,
                                        builder: (context, value, child) {
                                          return ElevatedButton(
                                            onPressed: () {
                                              username =
                                                  usernameController.text;
                                              password =
                                                  passwordController.text;
                                              email = emailController.text;
                                              if (usernameController
                                                      .text.isEmpty ||
                                                  passwordController
                                                      .text.isEmpty) {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(SnackBar(
                                                  content: Text(
                                                    'Enter username and password',
                                                    textAlign: TextAlign.center,
                                                  ),
                                                  duration: Duration(
                                                      milliseconds: 300),
                                                ));
                                              }
                                              register(
                                                      username, password, email)
                                                  .then((response) async {
                                                if (formkey.currentState!
                                                    .validate()) {
                                                  Navigator.of(context)
                                                      .pushAndRemoveUntil(
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  LoginScreen()),
                                                          (Route<dynamic>
                                                                  route) =>
                                                              false);
                                                }
                                              });
                                            },
                                            child: Text(
                                              'Sign Up',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              primary: MyColor.secClr,
                                              onPrimary: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 10),
                                              shape: StadiumBorder(),
                                            ),
                                          );
                                        }),
                                  ),
                                )),
                            Container(
                                margin: EdgeInsets.only(top: 15),
                                alignment: AlignmentDirectional.center,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Already have an Account ?",
                                      style: const TextStyle(
                                        color: MyColor.bg1Clr,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 40),
                                    InkWell(
                                      child: Text(
                                        'Login',
                                        style: TextStyle(
                                          color: MyColor.secClr,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      onTap: () => {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()),
                                        )
                                      },
                                    ),
                                  ],
                                )),
                          ]),
                    )))
          ]),
    ));
  }
}
