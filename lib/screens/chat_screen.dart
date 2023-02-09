import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  //const ChatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) => Container(
          padding: EdgeInsets.all(8),
          child: Text('This works!'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/dhel7VS3bjmkw6HzZqsK/messages')
              .snapshots()
              .listen((data) {
            //print(data.documents[0]['text']);
            data.documents.forEach((element) {
              print(element['text']);
            });
          });
        },
      ),
    );
  }
}
