import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

_sendingMails() async {
  const url = 'mailto:ahmadkalloka@gmail.com';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Contact Us'),
      ),
      body: SafeArea(
        child: ListView(children: [
          Column(
            children: [
              Image.asset('images/gd.jpg'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'GROWING DEVELOPERS',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  color: Colors.red,
                  thickness: 5,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15.0)),
                child: GestureDetector(
                  onTap: _sendingMails,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.email_outlined,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'growingdevp@gmail.com',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                height: 80,
                width: 330,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(15.0)),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.call,
                        color: Colors.white,
                        size: 35,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '+923001234567',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
                height: 80,
                width: 330,
              )
            ],
          ),
        ]),
      ),
    );
  }
}
