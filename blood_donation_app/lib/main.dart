// @dart=2.9
import 'package:blood_donation_app/ActiveRequests.dart';
import 'package:blood_donation_app/Drawer.dart';
import 'package:blood_donation_app/LoginPage.dart';
import 'package:blood_donation_app/Register.dart';
import 'package:blood_donation_app/splashScrean.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_app/Doner.dart';
import 'PostRequest.dart';

MyDrawer drawer = new MyDrawer();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Set();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => SplashScreen(),
      '/second': (context) => MyApp(),
    },
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Blood Donation App'),
      ),
      drawer: drawer,
      body: SafeArea(
        child: Center(
          child: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Container(
                      color: Colors.white70,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Make a\ndifference , Save\na Life:Donate\nBlood Now!',
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  height: 1.5),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Register()));
                            },
                            child: Text(
                              'Register For Donation',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white),
                              minimumSize:
                                  MaterialStateProperty.all(Size(50, 60)),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      side: BorderSide(
                                          width: 5, color: Colors.red),
                                      borderRadius:
                                          BorderRadius.circular(30.0))),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Image.asset('images/bd.jpg'),
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => DonerDate()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Container(
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Find a blood Donor',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '         Quickly find a Blood Donor by\n     selecting the blood type, city and availability'
                                'all across the Pakistan.View\n              details and Contact',
                                style: TextStyle(fontSize: 15, height: 1.5),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                DeleteVisibilty(false);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DonerDate()));
                              },
                              child: Text(
                                'Find',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(60, 60)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 5, color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(10.0)))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PostReq()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Container(
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Post a request for Blood',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '    If you can’t find blood by searching\n    '
                                'the portal, you can post the Patient\n    Details with Exact Blood Donation\n'
                                '                            Date',
                                style: TextStyle(fontSize: 15, height: 1.5),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => PostReq()));
                              },
                              child: Text(
                                'Post',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(60, 60)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 5, color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(10.0)))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Container(
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'Blood Donor Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'If you are already a registered blood\n donor login to update your profile\n and help others to join this portal to\n                  help humanity  ',
                                style: TextStyle(fontSize: 15, height: 1.5),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Login()));
                              },
                              child: Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(60, 60)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 5, color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(10.0)))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      RDveisibilty(false);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrentRequest()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Container(
                        color: Colors.white70,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'View Active Blood Requests',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    height: 1.5),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '        You must be logged in order to view or edit your profile. Note: Kindly update your Availability Status after\n                      Blood Donation',
                                style: TextStyle(fontSize: 15, height: 1.5),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CurrentRequest()));
                              },
                              child: Text(
                                'View Requests',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                  minimumSize:
                                      MaterialStateProperty.all(Size(60, 60)),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          side: BorderSide(
                                              width: 5, color: Colors.red),
                                          borderRadius:
                                              BorderRadius.circular(10.0)))),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
