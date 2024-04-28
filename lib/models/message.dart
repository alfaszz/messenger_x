// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:cloud_firestore/cloud_firestore.dart';

class Message {
  final String senderID;
  final String senderEmail;
  final String receiverID;
  final String message;
  final Timestamp time;
  Message({
    required this.senderID,
    required this.senderEmail,
    required this.receiverID,
    required this.message,
    required this.time,
  });

  Message copyWith({
    String? senderID,
    String? senderEmail,
    String? receiverID,
    String? message,
    Timestamp? time,
  }) {
    return Message(
      senderID: senderID ?? this.senderID,
      senderEmail: senderEmail ?? this.senderEmail,
      receiverID: receiverID ?? this.receiverID,
      message: message ?? this.message,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderID': senderID,
      'senderEmail': senderEmail,
      'receiverID': receiverID,
      'message': message,
      'time': time,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderID: map['senderID'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverID: map['receiverID'] as String,
      message: map['message'] as String,
      time: (map['time'] as Timestamp),
    );
  }
}
