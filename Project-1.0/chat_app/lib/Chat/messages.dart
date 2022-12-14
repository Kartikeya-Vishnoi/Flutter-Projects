//The Widget Messages fetches messages from chats collection
// maps every document fields of every chat into the ChatBubble Constructor

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'ChatBubbles.dart';

class messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return FutureBuilder(
      future: Future.value(FirebaseAuth.instance.currentUser),
      builder: (ctx, futuresnapshot) {
        if (futuresnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('chat')
                .orderBy("Created at", descending: true)
                .snapshots(),
            builder: (ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
              if (chatSnapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              final docs = chatSnapshot.data?.docs;
              //final Docs = FirebaseFirestore.instance.collection("users");
              return ListView.builder(
                  reverse: true,
                  itemCount: docs?.length,
                  itemBuilder: (context, index) => (Bubbles(
                        docs?[index].data()['text'],
                        docs?[index].data()['username'],
                        docs?[index].data()['userimage'],
                        docs?[index].data()['userId'] == user.uid,
                        key:ValueKey(docs?[index].data()['userId'])
                      )));
            });
      },
    );
  }
}











































// Widget build(BuildContext context) {
//     return StreamBuilder(
//         stream: Firestore.instance
//             .collection('chat')
//             .orderBy("Created at", descending: true)
//             .snapshots(),
//         builder: (ctx, AsyncSnapshot chatSnapshot) {
//           if (chatSnapshot.connectionState == ConnectionState.waiting) {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final docs = chatSnapshot.data?.documents;
//           // curr=cuser(docs[index]['userId']);
//           return ListView.builder(
//               reverse: true,
//               itemCount: docs.length,
//               itemBuilder: (context, index) => (Bubbles(
//                     docs[index]['text'],
//                     (cuser(
//                       docs[index]['userId'],
//                     )),
//                   )));
//         });
//   }
// }
