import 'package:flutter/material.dart';

import 'ActiveRequests.dart';
import 'Doner.dart';

class AdminPanel extends StatefulWidget {
  const AdminPanel({Key? key}) : super(key: key);

  @override
  _AdminPanelState createState() => _AdminPanelState();
}

class _AdminPanelState extends State<AdminPanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Admin Panel'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                DeleteVisibilty(true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DonerDate()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.red, width: 15)),
                    height: 150,
                    width: 300,
                    child: Center(
                        child: Text(
                      'Donner Data',
                      style: TextStyle(fontSize: 35),
                    )),
                  ),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                RDveisibilty(true);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CurrentRequest()));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                    child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(color: Colors.red, width: 15)),
                    height: 150,
                    width: 300,
                    child: Center(
                        child: Text(
                      'Requests Data',
                      style: TextStyle(fontSize: 35),
                    )),
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
