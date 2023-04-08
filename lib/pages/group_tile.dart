import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/database_service.dart';
import '../shared/local_parameters.dart';
import 'chat_page/chat_page.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupId;
  final String groupName;
  const GroupTile(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  String lastMessage = "";
  String lastMessageTime = "";
  String lastMessageSender = "";
  @override
  void initState() {
    super.initState();

    getLastMessage();
    getLastMessageSender();
    getLastMessageTime();
  }

  getLastMessage() async {
    DatabaseService().getLastMessage(widget.groupId).then((value) {
      setState(() {
        if (value == null) {
          lastMessage = "";
        } else {
          if (value.length >= 20) {
            lastMessage = value.substring(1, 20) + "...";
          } else {
            lastMessage = value;
          }
        }
      });
    });
  }

  getLastMessageTime() async {
    DatabaseService().getLastMessageTime(widget.groupId).then((value) {
      setState(() {
        lastMessageTime = value;
      });
    });
  }

  getLastMessageSender() async {
    DatabaseService().getLastMessageSender(widget.groupId).then((value) {
      setState(() {
        if (value == null) {
          lastMessageSender = "";
        } else {
          lastMessageSender = value;
        }
      });
    });
  }

  //overring noSuchMethod
  @override
  dynamic noSuchMethod(Invocation invocation) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return ChatPage(
            groupId: widget.groupId,
            groupName: widget.groupName,
            userName: widget.userName,
          );
        }));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            backgroundColor: Parameters().navbar_IColor,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          title: Text(
            widget.groupName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: textGetir(),
        ),
      ),
    );
  }

  textGetir() {
    if (lastMessage != "") {
      return Row(
        children: <Widget>[
          Expanded(
            flex: 7,
            child: Text("$lastMessageSender: $lastMessage"),
          ),
          Expanded(flex: 2, child: Text(readTimestamp(lastMessageTime)))
        ],
      );
    } else {
      return Text(
        "Join the conversation as ${widget.userName}",
        style: const TextStyle(fontSize: 13),
      );
    }
  }
}

String readTimestamp(String timer) {
  var timestamp = int.parse(timer);
  var now = DateTime.now();
  var format = DateFormat('HH:mm a');
  var date = DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);
  var diff = date.difference(now);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else {
    if (diff.inDays == 1) {
      time = '${diff.inDays}DAY AGO';
    } else {
      time = '${diff.inDays}DAYS AGO';
    }
  }

  return time;
}
