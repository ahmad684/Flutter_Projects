import 'package:blood_donation_app/Authentication.dart';
import 'package:blood_donation_app/LoginPage.dart';
import 'package:blood_donation_app/Register.dart';
import 'package:blood_donation_app/SaveToDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

var query, id;
final db = FirebaseFirestore.instance;
SaveData _saveData = new SaveData();
Register _register = new Register();

class UserProfile extends StatefulWidget {
  UserProfile(var ID) {
    id = ID;
  }

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('User Profile'),
        actions: [
          IconButton(
              onPressed: () {
                signOut().whenComplete(() => Navigator.pop(
                    context, MaterialPageRoute(builder: (context) => Login())));
              },
              icon: Icon(Icons.logout_sharp))
        ],
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: db
                  .collection('Register')
                  .where('ID', isEqualTo: id)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data!.docs[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          child: Column(
                        children: [
                          Card(
                            color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: Column(
                                    children: [
                                      Visibility(
                                        visible: true,
                                        child: ListTile(
                                          leading: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              _showMyDialog(
                                                  'Successfully',
                                                  'Data Deleted Successful',
                                                  '');
                                              _saveData.deleteData(
                                                  'Register', ds.id);
                                            },
                                          ),
                                          trailing: IconButton(
                                              icon: Icon(
                                                Icons.edit,
                                                color: Colors.black,
                                              ),
                                              onPressed: () {
                                                Map<String, dynamic> data = {
                                                  'name': ds['Name'],
                                                  'gender': ds['Gender'],
                                                  'dob': ds['DOB'],
                                                  'blood group':
                                                      ds['Blood Group'],
                                                  'mobile': ds['Mobile'],
                                                  'country': ds['Country'],
                                                  'province': ds['Province'],
                                                  'city': ds['City'],
                                                  'address': ds['Address'],
                                                  'availability':
                                                      ds['Availability'],
                                                };
                                                _register.getData(
                                                    'Update Donor Data',
                                                    data,
                                                    ds.id,
                                                    'Update',
                                                    false);
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Register()));
                                              }),
                                        ),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.account_box,
                                          color: Colors.red,
                                        ),
                                        title: Text(ds['Name'],
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold)),
                                      ),
                                      ListTile(
                                        leading: Icon(Icons.bloodtype,
                                            color: Colors.red),
                                        title: Text(
                                          'Blood Group :        ' +
                                              ds['Blood Group'],
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            16.0, 0, 16, 0),
                                        child: Divider(
                                          thickness: 2,
                                          color: Colors.red,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                ListTile(
                                  leading: Icon(Icons.accessibility_outlined,
                                      color: Colors.red),
                                  title: Text(
                                    'Gender :        ' + ds['Gender'],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.event_available,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        '       Status :     ' +
                                            ds['Availability'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        '      ' +
                                            ds['City'] +
                                            ', ' +
                                            ds['Province'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16.0, 8, 8, 8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.contact_phone_outlined,
                                        color: Colors.red,
                                      ),
                                      Text(
                                        '      ' + ds['Mobile'],
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                    );
                  },
                );
              })),
    );
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
