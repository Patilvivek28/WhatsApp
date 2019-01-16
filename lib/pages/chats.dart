import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:whatsapp/models/chat.dart';

class Chats extends StatelessWidget {
  Widget _buildChatItem(BuildContext context, DocumentSnapshot document) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30.0,
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.grey,
        backgroundImage: NetworkImage(document['avatarUrl']),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            document['name'],
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(
            document['time'],
            style: TextStyle(color: Colors.grey, fontSize: 14.0),
          ),
        ],
      ),
      subtitle: Container(
        padding: const EdgeInsets.only(top: 5.0),
        child: Text(
          document['message'],
          style: TextStyle(color: Colors.grey, fontSize: 15.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('chats').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();
        return ListView.builder(
            itemCount: snapshot.data.documents.length,
            itemBuilder: (context, index) => Column(
                  children: <Widget>[
                    index == 0
                        ? Container()
                        : Divider(
                            height: 10.0,
                          ),
                    _buildChatItem(context, snapshot.data.documents[index]),
                    index == snapshot.data.documents.length-1
                        ? Divider(
                            height: 10.0,
                          )
                        : Container(),
                  ],
                ));
      },
    );
  }
}
