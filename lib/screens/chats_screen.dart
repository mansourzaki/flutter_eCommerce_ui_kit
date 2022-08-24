import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_ecommerce_ui_kit/helper/auth_helper.dart';
import 'package:flutter_ecommerce_ui_kit/providers/auth_provider.dart';
import 'package:flutter_ecommerce_ui_kit/providers/firestore_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String? uid;
  @override
  void initState() {
    uid = AuthHelper.authHelper.getUserState()!.uid;
    super.initState();
  }

  TextEditingController _controller = TextEditingController();
  bool isPlayingMsg = false, isRecording = false, isSending = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthProvider>(context);
    final fp = Provider.of<FireStoreProvider>(context);
    return Scaffold(
      appBar: AppBar(),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chats')
            .orderBy('sentTime')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                String sentBy = snapshot.data!.docs[index]['sentBy'];
                return buildItem(snapshot.data!.docs[index], sentBy == uid);
              },
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: Container(
        padding: MediaQuery.of(context).viewInsets,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 2),
          child: Container(
            height: 50,
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: Colors.blue,
                    ),
                    onPressed: () async {
                      FirebaseFirestore.instance.collection('chats').add({
                        'message': _controller.text,
                        'sentBy': uid,
                        'sentTime': Timestamp.now()
                      });
                      _controller.text = '';
                    },
                  ),
                  prefixIcon: IconButton(
                    icon: Icon(Icons.mic),
                    onPressed: () {},
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildItem(doc, bool isMe) {
    return SizedBox(
      height: 70,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: isMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))
                : BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        color: isMe ? Colors.amber : Colors.pink,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: ListTile(
            title: Text(
              doc['message'].toString(),
              style: TextStyle(color: Colors.white, fontSize: 20),
              textAlign: isMe ? TextAlign.right : TextAlign.left,
            ),
          ),
        ),
      ),
    );
  }
}
