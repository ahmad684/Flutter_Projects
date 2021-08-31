import 'package:blood_donation_app/PostRequest.dart';
import 'package:blood_donation_app/SaveToDatabase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'Doner.dart';

PostReq _postReq = new PostReq();
bool _visibly = false;
RDveisibilty(bool _vis) {
  _visibly = _vis;
}

SaveData _saveData = new SaveData();

class CurrentRequest extends StatefulWidget {
  const CurrentRequest({Key? key}) : super(key: key);

  @override
  _CurrentRequestState createState() => _CurrentRequestState();
}

class _CurrentRequestState extends State<CurrentRequest> {
  String needDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  final callSerivices _serivices = locator<callSerivices>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white54,
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Active Requests'),
      ),
      body: SafeArea(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('PostRequest')
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
                                      ListTile(
                                        leading: Visibility(
                                          visible: _visibly,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                _showMyDialog(
                                                    'Successful',
                                                    'Data Deleted Successfully',
                                                    ' ');
                                                _saveData.deleteData(
                                                    'PostRequest', ds.id);
                                              });
                                            },
                                          ),
                                        ),
                                        title: Text(
                                          ds['Title'],
                                          style: TextStyle(
                                              decoration:
                                                  TextDecoration.underline,
                                              fontSize: 25,
                                              color: Colors.red),
                                        ),
                                        trailing: Visibility(
                                            visible: _visibly,
                                            child: IconButton(
                                                icon: Icon(
                                                  Icons.edit,
                                                  color: Colors.black,
                                                ),
                                                onPressed: () {
                                                  Map<String, dynamic> data = {
                                                    'title': ds['Title'],
                                                    'patientname':
                                                        ds['patientName'],
                                                    'patientage':
                                                        ds['patientAge'],
                                                    'dateofneed':
                                                        ds['DateOfNeed'],
                                                    'reason': ds['Reason'],
                                                    'gender': ds['Gender'],
                                                    'blood group':
                                                        ds['Blood Group'],
                                                    'mobile': ds['Mobile'],
                                                    'country': ds['Country'],
                                                    'province': ds['Province'],
                                                    'city': ds['City'],
                                                    'address': ds['Address'],
                                                  };
                                                  _postReq.getData(
                                                      'Update Post Request Data',
                                                      data,
                                                      ds.id,
                                                      'Update');
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PostReq()));
                                                })),
                                      ),
                                      ListTile(
                                        leading: Icon(
                                          Icons.account_box,
                                          color: Colors.red,
                                        ),
                                        title: Text(ds['patientName'],
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
                                    'Gender :  ' + ds['Gender'],
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.black),
                                  ),
                                ),
                                ListTile(
                                  leading:
                                      Icon(Icons.date_range, color: Colors.red),
                                  title: Text(
                                    'Date of Need:  ' + ds['DateOfNeed'],
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
                                        '       Reason :  ' + ds['Reason'],
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
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 8.0),
                                  child: Text(
                                    '     Posted On:  ' + ds['Entry Date'],
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                )
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
