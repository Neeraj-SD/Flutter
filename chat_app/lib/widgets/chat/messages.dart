import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseAuth.instance.currentUser(),
        builder: (ctx, AsyncSnapshot<FirebaseUser> futureSnapshot) {
          if (futureSnapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );

          return StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance
                .collection('chat')
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (ctx, AsyncSnapshot dataSnapshot) {
              if (dataSnapshot.connectionState == ConnectionState.waiting)
                return Center(
                  child: CircularProgressIndicator(),
                );
              final messageDoc = dataSnapshot.data.documents;
              return ListView.builder(
                  reverse: true,
                  itemCount: messageDoc.length,
                  itemBuilder: (c, i) {
                    return MessageBubble(
                      messageDoc[i]['text'],
                      messageDoc[i]['userId'] == futureSnapshot.data.uid,
                      messageDoc[i]['username'],
                      messageDoc[i]['userImage'],
                      key: ValueKey(messageDoc[i].documentID),
                    );
                  });
            },
          );
        });
  }
}
