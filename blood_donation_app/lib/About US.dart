import 'package:flutter/material.dart';
class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('About App'),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                    child: Text('About This App',style: TextStyle(fontSize: 20),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                    child: Text('Heroes come in all types and sizes, become a blood donor and be someones Hero !',style: TextStyle(fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                    child: Text('The only source of blood is a healthy volunteer donors. As patients need blood for various reasons during their treatment all across Pakistan, become a blood donor and help us save lives maybe you need it someday. One bag of blood can save more than one life. Register Now and Save a Life.',style: TextStyle(fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                    child: Text('WHY?',style: TextStyle(fontSize: 18),),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8.0,8,8,16),
                    child: Text('Blood can save millions of lives, and young people are the hope and future of a safe blood supply in the world The reason is simple “Blood saves life, Safe blood starts with me.” In Pakistan, 64% population falls under 30 years of age, still we have blood crisis because of day-to-day number of patients increases more than blood donors. Even after combined efforts from the Government and NGO\'s the supply of safe blood is still in short of global demand. The aim of the present blood donation application is to target youth of Pakistan and get as many blood donors registered in this Central Blood Donor App, where donors from all parts of Pakistan are always ready to donate blood when and where needed. Selection of donors is an important means to improve the overall safety of blood supply. Students consist of a large healthy and active group of voluntary blood donors to meet the demand of safe blood. Lets take a pledge to donate blood to become someone\'s Hero.',style: TextStyle(fontSize: 18),),
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
