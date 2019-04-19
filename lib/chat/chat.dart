import 'dart:io';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yaoshi/common/models.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ChatPage extends StatefulWidget {
  final Doctor doctor;
  const ChatPage(this.doctor, {
    Key key,
  }) : super(key: key);
  @override //new
  State createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final List<ChatMessage> _messages = <ChatMessage>[];
  File _image;
  bool _isComposing = false;
  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      border: Border(
        top: BorderSide(color: Colors.grey[200]),
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("咨询${widget.doctor.name}"),
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Flexible(
                child: ListView.builder(
                  padding: EdgeInsets.all(8.0),
                  reverse: true,
                  itemBuilder: (_, int index) => _messages[index],
                  itemCount: _messages.length,
                ),
              ),
              Divider(height: 1.0),
              Container(
                decoration: BoxDecoration(color: Theme.of(context).cardColor),
                child: _buildTextComposer(),
              ),
            ],
          ),
          decoration: Theme.of(context).platform == TargetPlatform.iOS
              ? decoration
              : null,
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages) //new
      message.animationController.dispose(); //new
    super.dispose();
  }
  Future<void> getImage() async {
    File imageFile = await ImagePicker.pickImage();
    int random = new Random().nextInt(100000);
    StorageReference ref =
    FirebaseStorage.instance.ref().child("image_$random.jpg");
    StorageUploadTask uploadTask = ref.putFile(imageFile);
    uploadTask.onComplete.then((StorageTaskSnapshot snapshot) {
      //snapshot.ref.getDownloadURL() 下载地址
    });
//    Uri downloadUrl = (await uploadTask.future).downloadUrl;


  }
  void _sendMsg() {
    if (_isComposing) _handleSubmitted(_textController.text);
  }
  Widget _buildTextComposer() {
    Widget sendBtn;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      sendBtn = CupertinoButton(
        child: Text("Send"), //new
        onPressed: _sendMsg,
      );
    } else {
      sendBtn = IconButton(
        icon: Icon(Icons.send),
        onPressed: _sendMsg
      );
    }

    Widget pickImageBtn;
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      pickImageBtn = CupertinoButton(
        child: Text("图片"), //new
        onPressed: _sendMsg,
      );
    } else {
      pickImageBtn = IconButton(
          icon: Icon(Icons.send),
          onPressed: _sendMsg
      );
    }


    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: TextField(
              controller: _textController,
              onSubmitted: _handleSubmitted,
              decoration: InputDecoration.collapsed(hintText: "Send a message"),
              onChanged: (text) {
                setState(() {
                  _isComposing = text.length > 0;
                });
              },
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0),
            child: Row(
              children: <Widget>[
                sendBtn,
                pickImageBtn,
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleSubmitted(String text) {
    _textController.clear();
    setState(() {
      _isComposing = false;
    });
    ChatMessage message = ChatMessage(
      text: text,
      animationController: AnimationController(
        vsync: this,
        duration: Duration(
          milliseconds: 700,
        ),
      ),
    );
    setState(() {
      _messages.insert(0, message);
    });
  }
}

const String _name = "Your Name";

class ChatMessage extends StatelessWidget {
  final String text;
  final AnimationController animationController;
  ChatMessage({this.text, this.animationController});

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animationController,
        curve: Curves.easeOut,
      ),
      axisAlignment: 0.0,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 16.0),
              child: CircleAvatar(child: Text(_name[0])),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(_name, style: Theme.of(context).textTheme.subhead),
                Container(
                  margin: EdgeInsets.only(top: 5.0),
                  child: Text(text),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
