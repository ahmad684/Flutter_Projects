
import 'package:flutter/material.dart';
import 'package:my_chat_app/Views/Sigin.dart';
import 'package:my_chat_app/authentication1/Constants.dart';
import 'package:my_chat_app/authentication1/Sharedpref.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Theme(
        data: Theme.of(context).copyWith(
      canvasColor: Colors.white),
      child: Container(
        alignment: Alignment.topCenter,
        width: 250,

        child: Drawer(
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                accountName: Text(Constants.MyName),
                accountEmail: Text('guest@gmail.com'),
                currentAccountPicture: GestureDetector(
                  child: CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.green,
                    ),
                  ),
                ),

              ),

              Divider(),
              InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => ContactUs()));
                  },
                  child: ListTile(
                      title: Text('Profile'),
                      leading: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ))),
              InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                  child: ListTile(
                      title: Text('Setting'),
                      leading: Icon(
                        Icons.settings,
                        color: Colors.blue,
                      ))),
              InkWell(
                  onTap: () {


                     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignIn()));

                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                  child: ListTile(
                      title: Text('Log Out'),
                      leading: Icon(
                        Icons.logout,
                        color: Colors.blue,
                      ))),
              InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => ContactUs()));
                  },
                  child: ListTile(
                      title: Text('Contact Us'),
                      leading: Icon(
                        Icons.contact_phone,
                        color: Colors.blue,
                      ))),
              InkWell(
                  onTap: () {
                    // Navigator.push(context,
                    //     MaterialPageRoute(builder: (context) => AboutUs()));
                  },
                  child: ListTile(
                      title: Text('About'),
                      leading: Icon(
                        Icons.help,
                        color: Colors.blue,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}
