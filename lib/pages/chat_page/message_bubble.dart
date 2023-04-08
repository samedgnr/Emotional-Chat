import 'package:flutter/material.dart';
import 'dart:math';

import 'package:intl/intl.dart';

import '../../shared/local_parameters.dart';

class MessageBubble extends StatefulWidget {
  const MessageBubble({
    Key? key,
    required this.message,
    required this.sender,
    required this.sentByMe,
    required this.lastSender,
    required this.time,
  }) : super(key: key);
  final String message;
  final String sender;
  final bool sentByMe;
  final String lastSender;
  final int time;

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  @override
  Widget build(BuildContext context) {
    return messageTile(context);
  }

  messageTile(BuildContext context) {
    if (widget.sender == widget.lastSender) {
      return Padding(
        // asymmetric padding
        padding: EdgeInsets.fromLTRB(
          widget.sentByMe ? 64.0 : 5.0,
          1,
          widget.sentByMe ? 5.0 : 64.0,
          1,
        ),
        child: Align(
          alignment:
              widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.sentByMe
                    ? Parameters().sBubble_Color
                    : Parameters().rBubble_Color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: whoSendIt(context),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        // asymmetric padding
        padding: EdgeInsets.fromLTRB(
          widget.sentByMe ? 64.0 : 5.0,
          10,
          widget.sentByMe ? 5.0 : 64.0,
          1,
        ),
        child: Align(
          alignment:
              widget.sentByMe ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: widget.sentByMe
                    ? Parameters().sBubble_Color
                    : Parameters().rBubble_Color,
                borderRadius: BorderRadius.circular(16),
              ),
              child: whoSendIt(context),
            ),
          ),
        ),
      );
    }
  }

  whoSendIt(
    BuildContext context,
  ) {
    Color color = Colors.primaries[Random().nextInt(Colors.primaries.length)];
    if (!widget.sentByMe) {
      if (widget.sender == widget.lastSender) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                widget.message,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: widget.sentByMe ? Colors.white : Colors.black87),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(8, 2, 12, 12),
                child: Text(
                  readTimestamp(widget.time),
                  style: TextStyle(
                      fontSize: 10,
                      color: widget.sentByMe ? Colors.white : Colors.black87),
                ))
          ],
        );
      } else {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
              child: Text(
                widget.sender.toLowerCase(),
                textAlign: TextAlign.start,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: color),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 5, 5, 5),
              child: Text(
                widget.message,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: widget.sentByMe ? Colors.white : Colors.black87),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 12, 12),
              child: Text(
                readTimestamp(widget.time),
                style: TextStyle(
                    fontSize: 10,
                    color: widget.sentByMe ? Colors.white : Colors.black87),
              ),
            ),
          ],
        );
      }
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              widget.message,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: widget.sentByMe ? Colors.white : Colors.black87),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 2, 12, 12),
            child: Text(
              readTimestamp(widget.time),
              style: TextStyle(
                  fontSize: 10,
                  color: widget.sentByMe ? Colors.white : Colors.black87),
            ),
          ),
        ],
      );
    }
  }

  String readTimestamp(int timestamp) {
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
}
