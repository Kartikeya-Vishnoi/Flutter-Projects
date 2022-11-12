import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Bubbles extends StatelessWidget {
  final Key key;
  String Message;
  final String username;
  bool isme;
  String userimage;
  Bubbles(this.Message, this.username, this.userimage, this.isme,
      {required this.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          mainAxisAlignment:
              isme ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  color: isme
                      ? Color.fromARGB(255, 90, 87, 87)
                      : Theme.of(context).accentColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                    bottomLeft:
                        !isme ? Radius.circular(0) : Radius.circular(12),
                    bottomRight:
                        isme ? Radius.circular(0) : Radius.circular(12),
                  )),
              width: 140,    
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: Column(
                crossAxisAlignment:
                    isme ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isme
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .titleMedium!
                                .color),
                  ),
                  Text(
                    Message,
                    style: TextStyle(
                        color: isme
                            ? Colors.black
                            : Theme.of(context)
                                .accentTextTheme
                                .titleMedium!
                                .color),
                    textAlign: isme ? TextAlign.end : TextAlign.start,
                  ),
                ],
              ),
            ),
          ],
        ),
        Positioned(
          top: 0,
          left: isme ? null : 120,
          right: isme ? 120 : null,
          child: CircleAvatar(
            backgroundImage: NetworkImage(
              userimage,
            ),
          ),
        ),
      ],
      clipBehavior: Clip.none,
    );
  }
}
