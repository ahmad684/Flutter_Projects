import 'package:blood_donation_app/About%20US.dart';
import 'package:blood_donation_app/AdminLogin.dart';
import 'package:blood_donation_app/Contact%20Us.dart';
import 'package:blood_donation_app/Doner.dart';
import 'package:blood_donation_app/LoginPage.dart';
import 'package:blood_donation_app/PostRequest.dart';
import 'package:blood_donation_app/Register.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text('Guest'),
            accountEmail: Text('guest@gmail.com'),
            currentAccountPicture: GestureDetector(
              child: CircleAvatar(
                child: Icon(
                  Icons.person,
                  color: Colors.green,
                ),
              ),
            ),
            decoration: BoxDecoration(color: Colors.red),
          ),

          Divider(),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
              child: ListTile(
                  title: Text('Contact Us'),
                  leading: Icon(
                    Icons.contact_phone,
                    color: Colors.blue,
                  ))),
          InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
              child: ListTile(
                  title: Text('About'),
                  leading: Icon(
                    Icons.help,
                    color: Colors.blue,
                  ))),
        ],
      ),
    );
  }
}
