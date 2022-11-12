//The Chat screen widget consists of 1)Appbar 2)Chats 3)Textinput for chat


import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Chat/messages.dart';
import '../Chat/newmessage.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      //APPBAR
      appBar: AppBar(
        title: Text("Chat_App"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text("Logout"),
                    ],
                  ),
                ),
                value: 'log',
              ),
            ],
            onChanged: (itemIdentifier) {
              //Onchanged is a property of drop-down menu which is called once user selects something
              if (itemIdentifier == 'log') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      //Chats
      //Text i/p
      body: Container(
          child: Column(
        children: [Expanded(child: messages()), NewMessage()],
      )),
    );
  }
}
