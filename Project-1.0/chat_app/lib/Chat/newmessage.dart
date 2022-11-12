// This Widget extracts information about the user which is typing the message
//through userdata and user varaiables initailized at _sendmessage function
//and adds up the Entered message, user id, name, image_url as a document....
//(IN FIREBASE A COLLECTION.. here chats.. CONSISTS 
//OF DOCUMENT..which stores fields like uid, imgurl etc) 
// to the chats collection onece the send button is pressed


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _controller = new TextEditingController();
  var _EnteredMessage = '';

  void _sendmessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser;
    final userdata =await FirebaseFirestore.instance.collection("users").doc(user.uid).get();
    FirebaseFirestore.instance.collection('chat').add({
      "text": _EnteredMessage,
      "Created at": Timestamp.now(),
      "userId": user.uid,
      "username":userdata["Username"],
      "userimage":userdata["image_url"]
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(children: [
        Expanded(
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Enter a Message',
            ),
            onChanged: (value) {
              setState(() {
                _EnteredMessage = value;
              });
            },
          ),
        ),
        IconButton(
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.send),
          onPressed: _EnteredMessage.trim().isEmpty ? null : _sendmessage,
        )
      ]),
    );
  }
}
