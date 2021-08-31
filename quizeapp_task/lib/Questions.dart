import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:quizeapp_task/LastScreen.dart';

import 'FirstScreen.dart';
var icno;
var name;
late int level;
int index=0;
int q=1;
late String URl;
late int cid;
late List ListResponse1;
String ButtonText="SKIP";
var ButtonColor=Color(0xFFD46400);
var ButtonTextolor=Color(0xFFD46400);
var ContainerColor=Colors.white;
var Option1_color=Colors.black12;
var Option2_color=Colors.black12;
var Option3_color=Colors.black12;
var Option4_color=Colors.black12;
var info_Text="To Hard!Go to next Question";

void GetURl(int url,String n){

  name=n;
  if(url==0){
    URl="http:\/\/perceptiondraft.com\/api\/gbas00721-quiz.php?cid=1";
  } if(url==1){
    URl="http:\/\/perceptiondraft.com\/api\/gbas00721-quiz.php?cid=2";
  }

}
class Questions extends StatefulWidget {
  const Questions({Key? key}) : super(key: key);

  @override
  _QuestionsState createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {

  Future GetQuestion()async{

    http.Response response=await http.get(Uri.parse(URl));

    if(response.statusCode==200){
      setState(() {
        ListResponse1=jsonDecode(response.body);
      });
    }


  }

  void CorrectAnswer(int num){
    setState(() {
      ButtonTextolor=Colors.white;
      ButtonColor=Colors.green;
      ButtonText="Next";
      ContainerColor=Colors.green;
      info_Text="Awesome!Try another question ";
      if(num==1){
        Option1_color=Colors.green;
        Option4_color=Colors.black12;
        Option3_color=Colors.black12;
        Option2_color=Colors.black12;

      }if(num==2){
        Option2_color=Colors.green;

        Option4_color=Colors.black12;
        Option3_color=Colors.black12;
        Option1_color=Colors.black12;
      }if(num==3){
        Option3_color=Colors.green;
        Option4_color=Colors.black12;
        Option2_color=Colors.black12;
        Option1_color=Colors.black12;
      }if(num==4){
        Option4_color=Colors.green;
        Option2_color=Colors.black12;
        Option3_color=Colors.black12;
        Option1_color=Colors.black12;
      }

    });

  }void WrongAnswer(int num){
    setState(() {
      ButtonTextolor=Color(0xFFD46400);;
      ButtonColor=Color(0xFFD46400);;
      ButtonText="SKIP";
      ContainerColor=Colors.white;
      info_Text="To Hard!Go to next Question";
      if(num==1){
        Option1_color=Colors.red;
        Option4_color=Colors.black12;
        Option3_color=Colors.black12;
        Option2_color=Colors.black12;

      }if(num==2){
        Option2_color=Colors.red;

        Option4_color=Colors.black12;
        Option3_color=Colors.black12;
        Option1_color=Colors.black12;
      }if(num==3){
        Option3_color=Colors.red;
        Option4_color=Colors.black12;
        Option2_color=Colors.black12;
        Option1_color=Colors.black12;
      }if(num==4){
        Option4_color=Colors.red;
        Option2_color=Colors.black12;
        Option3_color=Colors.black12;
        Option1_color=Colors.black12;
      }

    });

  }
  void GetNextQuestion(){
    setState(() {
      if(index<ListResponse1.length-1){
        index++;
        Option4_color=Colors.black12;
        Option2_color=Colors.black12;
        Option3_color=Colors.black12;
        Option1_color=Colors.black12;
        ButtonColor=Color(0xFFD46400);
        ButtonTextolor=Color(0xFFD46400);
        ButtonText="SKIP";
        ContainerColor=Colors.white;
        info_Text="To Hard!Go to next Question";
      }else{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Last()));

      }


    });

  }
  @override
  void initState() {
    // TODO: implement initState
    GetQuestion();level=1;
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
                title: Container(
                    margin: const EdgeInsets.only(left:60),
                    child: Image.asset('asset/images/logo.png',height: 80,width: 80,))
            ),
            Container(
              height: 70,
              width: MediaQuery.of(context).size.width,
              color: Color(0xFF0F0F39),

                child: Center(
                  child: Column(
                    children: [
                      Text(name,style: TextStyle(color: Colors.white,fontSize: 19,fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0,16.0,0,0),
                        child: Text('Level-${level}',style: TextStyle(color: Colors.white)),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(60,4.0,60,5),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListResponse1.isEmpty?Text("Loading.."):Text(ListResponse1[index]["q"].toString(),style: TextStyle(fontSize: 16)),
                        ),

                      ],
                    ),
                  )),
            ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               child: ListTile(
                 leading: Container(
                   height: 25,
                   width: 26,
                   decoration:  BoxDecoration(
                 border: Border.all(color: Option1_color,width: 2),
                   borderRadius: BorderRadius.all(Radius.circular(50))
               ),
                 ),
                 title: Text(ListResponse1[index]["o1"].toString()),
                   onTap: () {
                     if(ListResponse1[index]["o1"
                         ""]==ListResponse1[index]["co"]){
                      CorrectAnswer(1);

                     }else{
                       WrongAnswer(1);
                     }

                   }
               ),
               decoration: BoxDecoration(

                 border: Border.all(color: Option1_color,width: 2),
                 borderRadius: BorderRadius.all(Radius.circular(40))
               ),
             ),
           ) ,
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               child: ListTile(

                 leading: Container(
                   height: 25,
                   width: 26,
                   decoration:  BoxDecoration(
                 border: Border.all(color: Option2_color,width: 2),
                   borderRadius: BorderRadius.all(Radius.circular(50))
               ),
                 ),
                 title: Text(ListResponse1[index]["o2"].toString()),
                 onTap: () {
                   if(ListResponse1[index]["o2"]==ListResponse1[index]["co"]){
                     CorrectAnswer(2);
                   }else{
                     WrongAnswer(2);
                   }

                 }
               ),
               decoration: BoxDecoration(
                 border: Border.all(color: Option2_color,width: 2),
                 borderRadius: BorderRadius.all(Radius.circular(40))
               ),
             ),
           ),
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               child: ListTile(
                 leading: Container(
                   height: 25,
                   width: 26,
                   decoration:  BoxDecoration(
                 border: Border.all(color: Option3_color,width: 2),
                   borderRadius: BorderRadius.all(Radius.circular(50))
               ),
                 ),
                 title: Text(ListResponse1[index]["o3"].toString()),
                   onTap: () {
                     if(ListResponse1[index]["o3"]==ListResponse1[index]["co"]){
                       CorrectAnswer(3);
                     }else{
                       WrongAnswer(3);
                     }

                   }
               ),
               decoration: BoxDecoration(
                 border: Border.all(color: Option3_color,width: 2),
                 borderRadius: BorderRadius.all(Radius.circular(40))
               ),
             ),
           ),
            Padding(
             padding: const EdgeInsets.all(8.0),
             child: Container(
               child: ListTile(
                 leading: Container(
                   height: 25,
                   width: 26,
                   decoration:  BoxDecoration(
                 border: Border.all(color: Option4_color,width: 2),
                   borderRadius: BorderRadius.all(Radius.circular(50))
               ),
                 ),
                 title: Text(ListResponse1[index]["o4"].toString()),
                   onTap: () {
                     if(ListResponse1[index]["o4"]==ListResponse1[index]["co"]){
                      CorrectAnswer(4);
                     }else{
                       WrongAnswer(4);
                     }

                   }
               ),
               decoration: BoxDecoration(
                 border: Border.all(color: Option4_color,width: 2),
                 borderRadius: BorderRadius.all(Radius.circular(40))
               ),
             ),
           ),
          Text(info_Text,style: TextStyle(color: ButtonColor),),
            





            
          GestureDetector(
            onTap: (){
              if(ButtonText=="Next"){
                GetNextQuestion();
                level++;
              }

            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8.0,16,8,0),
              child: Container(
                width: 200,
                height: 40,
                decoration: BoxDecoration(
                  color: ContainerColor,
                  border: Border.all(color: ButtonColor,width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(30))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(child: Text(ButtonText,style: TextStyle(color: ButtonTextolor),)),
                ),
              ),
            ),
          ) ,
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0,20,0,0),
              child: Text((Canidate_id)),
            ),
          ],
          
          
        ),
        
      ),
      
    );
  }
}
