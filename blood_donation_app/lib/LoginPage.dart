import 'dart:io';

import 'package:blood_donation_app/Authentication.dart';
import 'package:blood_donation_app/Register.dart';
import 'package:blood_donation_app/ResetPasswordPage.dart';
import 'package:blood_donation_app/UserProfile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var _formKey = GlobalKey<FormState>();
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text('Post Request'),
        ),
        body: SafeArea(
            child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    Image.asset('images/blood.jpg'),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(12, 20, 12, 8),
                        child: TextFormField(
                            controller: email,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Email Address',
                                labelText: 'Email:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                              ).hasMatch(value)) {
                                return "a valid email like abc122@gmail.com";
                              }
                            })),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(60, 8, 12, 8),
                        child: TextFormField(
                            controller: password,
                            obscureText: true,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: 'Enter Password',
                                labelText: 'Password:',
                                floatingLabelBehavior:
                                    FloatingLabelBehavior.always),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Field is required';
                              }
                              if (value.length < 6) {
                                return 'Password must be of 6 digits';
                              }
                              return null;
                            })),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(
                                  Size.fromHeight(50)),
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.red),
                            ),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _signIn(
                                    email.text.trim(), password.text.trim());
                                /*Future<bool> res=signIn(email.text.trim();
                                if(res){
                                     Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                UserProfile())));
                              }*/
                              }
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(fontSize: 18),
                            ))),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ResetPassword()));
                        },
                        child: Text(
                          'Forgotten Password?',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    Divider(height: 5, color: Colors.grey),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 50,
                        margin: EdgeInsets.symmetric(horizontal: 84),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.blue),
                            ),
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text(
                              'Register as Donor',
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    )
                  ],
                ))));
  }

  void _signIn(String email, String password) async {
    try {
      await auth
          .signInWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((task) {
        // go to home screen
        if (task.additionalUserInfo != null) {
          setState(() {
            Navigator.pushReplacement(
                context,
                new MaterialPageRoute(
                    builder: (BuildContext context) =>
                        new UserProfile(task.user?.uid)));
          });
        }
      });
    } catch (e) {
      switch (e.toString()) {
        case '[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.':
          _showMyDialog('Donor not Registered', 'Please registered as donor.',
              'If you are registered! Please Enter Correct email');
          break;
        case '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.':
          _showMyDialog('Incorrect Password!', 'Please enter correct password',
              'or you can chose forgotten password option');
          break;
        case '[firebase_auth/network-request-failed] A network error (such as timeout, interrupted connection or unreachable host) has occurred.':
          _showMyDialog('No Internet Connection',
              'Please connect your device to internet', '');
          break;
        case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later.':
          _showMyDialog(
              'Request Blocked',
              'We are detect unusual Activity from this device',
              'Try again later');
          break;
        case '[firebase_auth/too-many-requests] We have blocked all requests from this device due to unusual activity. Try again later. is not yet implemented':
          _showMyDialog(
              'Request Blocked',
              'We are detect unusual Activity from this device.',
              'Try again later!');
          break;
        case '[firebase_auth/user-disabled] The user account has been disabled by an administrator.':
          _showMyDialog('User Blocked', 'Your Blocked by Admin',
              'Please Contact to Admin');
          break;
        default:
          print('Case $e is not yet implemented');
      }
      print('The error is $e');
    }
  }

  Future<void> _showMyDialog(String title, String msg1, var msg2) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(msg1),
                Text(msg2),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
