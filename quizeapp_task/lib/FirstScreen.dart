import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizeapp_task/Questions.dart';
var color=Color(0xFFE8DCDC);
var quizeid;
List imag=['asset/images/num.png','asset/images/cal.png'];
int a=1;
String Canidate_id='Ahmad Raza_ahmadkalloka@gmail.com';
 List listResponse=[];
class FirstScreean extends StatefulWidget {
  const FirstScreean({Key? key}) : super(key: key);

  @override
  _FirstScreeanState createState() => _FirstScreeanState();
}

class _FirstScreeanState extends State<FirstScreean> {

  Future APiCall()async{
    http.Response response=await http.get(Uri.parse('http://perceptiondraft.com/api/gbas00721-cat.php'));
    if(response.statusCode==200){
      setState(() {
        listResponse=jsonDecode(response.body);
        a=1;
      });

    }else{
      return CircularProgressIndicator();
    }
    
  }
  @override
  void initState() {
    // TODO: implement initState
   APiCall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: PreferredSize(
        preferredSize: Size.fromHeight(150),
        child: Column(
          children: [
            AppBar(
              elevation: 0,

                backgroundColor: Colors.white,
                title: Center(child: Image.asset('asset/images/logo.png',height: 80,width: 80,
                ))
            ),
            Container(
              margin: const EdgeInsets.only(top: 60,bottom: 0),
                child: Text('Available Quiz'))
          ],
        ),
      ),

      body: SafeArea(
        child: Container(
          child: ListView.builder(

              itemCount: listResponse.length,
              itemBuilder: (context,index){
                return Column(
                  children: [

                    Padding(

                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: (){
                          quizeid=listResponse[index]["name"];
                          GetURl(index, quizeid);
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Questions()));

                          print(quizeid);


                        },
                        child: Container(

                          decoration: BoxDecoration(
                            color: color,
                        borderRadius: BorderRadius.all(
                        Radius.circular(10.0)
                          ),),

                          child: ListTile(


                            leading: Image.asset(imag[index]),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: listResponse.isEmpty?Text('Loading...'):Text(listResponse[index]["name"],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: Text('Difficulty: BAsics'),
                                ),
                                Text('100/2000 Questions'),

                              ],
                            ),

                          ),

                        ),
                      ),
                    )

                  ],
                );

          }),
        ),

      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(80.0),
            child:MaterialButton(
              height: 50,
              minWidth: 200,
              color: Colors.green,
              onPressed: (){

              },
              child: Text("Instant Quiz",style: TextStyle(color: Colors.white),),

            )
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text((Canidate_id)),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      
    );

  }
}
