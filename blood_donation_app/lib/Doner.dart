import 'dart:ui';
import 'package:blood_donation_app/Register.dart';
import 'package:blood_donation_app/SaveToDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get_it/get_it.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

FirebaseAuth auth = FirebaseAuth.instance;

SaveData _saveData = new SaveData();
Register _register = new Register();
bool _visible = false;
DeleteVisibilty(bool _vis) {
  _visible = _vis;
}

class callSerivices {
  void call(String number) => launch('tel:$number');
}

GetIt locator = GetIt();
void Set() {
  locator.registerSingleton(callSerivices());
}

final db = FirebaseFirestore.instance;

class DonerDate extends StatefulWidget {
  @override
  _DonerDateState createState() => _DonerDateState();
}

class _DonerDateState extends State<DonerDate> {
  TextEditingController searchText = new TextEditingController();
  var searchBy;
  var query = db.collection('Register').snapshots();
  final callSerivices _serivices = locator<callSerivices>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(300),
        child: Column(
          children: [
            AppBar(
              backgroundColor: Colors.red,
              title: Text('Find Donner'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: Container(
                color: Colors.white,
                height: 230,
                child: Column(
                  children: [
                    Text(
                      '                   Search Donner                                     ',
                      style: TextStyle(fontSize: 22),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButtonFormField(
                          items: [
                            DropdownMenuItem(
                              child: Text("Show All"),
                              value: 'Show All',
                            ),
                            DropdownMenuItem(
                              child: Text("Blood Group"),
                              value: 'Blood Group',
                            ),
                            DropdownMenuItem(
                                child: Text("City"), value: 'City'),
                            DropdownMenuItem(
                                child: Text("Status"), value: 'Status'),
                          ],
                          decoration: InputDecoration(
                              hintText: 'Select Search Type',
                              labelText: 'Search By:',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              border: OutlineInputBorder()),
                          onChanged: (value) {
                            setState(() {
                              searchBy = value;
                            });
                          },
                          value: searchBy,
                          validator: (value) =>
                              value == null ? 'Field is required' : null),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: searchText,
                        decoration: InputDecoration(
                          hintText: 'Search here',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    Container(
                        width: 200,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                if (searchBy == 'Show All') {
                                  query = db.collection('Register').snapshots();
                                }
                                if (searchBy == 'Blood Group') {
                                  query = db
                                      .collection('Register')
                                      .where("Blood Group",
                                          isEqualTo: searchText.text
                                              .trim()
                                              .toUpperCase())
                                      .snapshots();
                                }
                                if (searchBy == 'City') {
                                  query = db
                                      .collection('Register')
                                      .where("City",
                                          isEqualTo: capitalize(
                                              searchText.text.trim()))
                                      .snapshots();
                                }
                                if (searchBy == 'Status') {
                                  query = db
                                      .collection('Register')
                                      .where("Availability",
                                          isEqualTo: capitalize(
                                              searchText.text.trim()))
                                      .snapshots();
                                }
                              });
                            },
                            style:
                                ElevatedButton.styleFrom(primary: Colors.red),
                            child: Text(
                              'Search',
                              style: TextStyle(fontSize: 18),
                            )))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: query,
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
                                        visible: _visible,
                                        child: ListTile(
                                          leading: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              _showMyDialog(
                                                  'Successful',
                                                  'Data Deleted Successfully',
                                                  ' ');
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
                                    'Gender : ' + ds['Gender'],
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
                                        '       Status :  ' +
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
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            60.0, 8, 0, 8),
                                        child: FloatingActionButton(
                                          heroTag: null,
                                          backgroundColor: Colors.white,
                                          onPressed: () {
                                            _serivices.call(ds['Mobile']);
                                          },
                                          child: Icon(
                                            Icons.call_rounded,
                                            color: Colors.red,
                                          ),
                                        ),
                                      )
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

  String capitalize(String inp) {
    var a = inp[0].toUpperCase();
    for (int i = 1; i < inp.length; i++) {
      a += inp[i];
    }
    return a;
  }
}
