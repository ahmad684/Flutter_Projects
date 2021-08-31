import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_chat_app/Views/CoverstionScreen.dart';
import 'package:my_chat_app/Views/Drawer.dart';
import 'package:my_chat_app/Views/SearchScreen.dart';
import 'package:my_chat_app/authentication1/Constants.dart';
import 'package:my_chat_app/authentication1/Sharedpref.dart';
import 'package:my_chat_app/authentication1/UserInfo.dart';
SaveData _saveData=new SaveData();
SearchScreen _searchScreen=new SearchScreen();
class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key}) : super(key: key);

  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  Widget ChatRoomList(){
    return StreamBuilder<QuerySnapshot>(
        stream: db.collection("ChatRoom").where("Users",arrayContains: Constants.MyName).snapshots(),
        builder: (context,snapshot){
          return snapshot.hasData?ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,index){
                return ListTile(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Conversation(snapshot.data!.docs[index]["chatRoomID"])));
                  },
                  leading: CircleAvatar(
                    child: Center(child:
                      Text(snapshot.data!.docs[index]["chatRoomID"][0]),),
                  ),

                  title: Text(snapshot.data!.docs[index]["chatRoomID"].toString().replaceAll(" ", "").replaceAll(Constants.MyName, ""),style: TextStyle(color: Colors.white),),

                );

          }):CircularProgressIndicator();

    });
  }
  GEtUserInfo()async{
    Constants.MyName=await SharedPrefrencesData.GetMyName();

    setState(() {

    });

  }
  @override
  void initState() {
    GEtUserInfo();

      ChatRoomList();



    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Room'),
      ),
      drawer: MyDrawer(),
      body: ChatRoomList(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.search), onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchScreen()));

      },),
    );
  }
}
