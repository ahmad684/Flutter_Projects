import 'package:flutter/material.dart';
import 'package:quizeapp_task/FirstScreen.dart';
class Last extends StatefulWidget {
  const Last({Key? key}) : super(key: key);

  @override
  _LastState createState() => _LastState();
}

class _LastState extends State<Last> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Center(child: Image.asset('asset/images/logo.png',height: 80,width: 70,)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment:  MainAxisAlignment.center,
          children: [

            Text("Thanks For Your Response",style: TextStyle(fontSize: 25),),
            GestureDetector(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstScreean()));

              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(8.0,16,8,0),
                child: Container(
                  width: 200,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      border: Border.all(color: Colors.green,width: 2),
                      borderRadius: BorderRadius.all(Radius.circular(30))
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(child: Text('Back To Home',style: TextStyle(color: Colors.white),)),
                  ),
                ),
              ),
            ) ,


          ],
        )
      ),
    );
  }
}
