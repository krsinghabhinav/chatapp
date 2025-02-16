import 'package:chatapp/model/chatmodel.dart';
import 'package:chatapp/model/userModel.dart';

class ChatRoomModel {
  String? id;
  UserModel? sender;
  UserModel? receiver;
  List<Chatmodel>? message;
  int? unReadMessNo;
  String? lastMessage;
  String? lastMessageTimestamp;
  String? timestamp;

  ChatRoomModel({
    this.id,
    this.sender,
    this.receiver,
    this.message,
    this.unReadMessNo,
    this.lastMessage,
    this.lastMessageTimestamp,
    this.timestamp,
  });

  factory ChatRoomModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomModel(
      id: json['id'],
      sender: json['sender'] != null ? UserModel.fromJson(json['sender']) : null,
      receiver: json['receiver'] != null ? UserModel.fromJson(json['receiver']) : null,
      message: (json['message'] as List<dynamic>?)
          ?.map((e) => Chatmodel.fromJson(e))
          .toList(),
      unReadMessNo: json['unReadMessNo'],
      lastMessage: json['lastMessage'],
      lastMessageTimestamp: json['lastMessageTimestamp'],
      timestamp: json['timestamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender?.toJson(),
      'receiver': receiver?.toJson(),
      'message': message?.map((e) => e.toJson()).toList(),
      'unReadMessNo': unReadMessNo,
      'lastMessage': lastMessage,
      'lastMessageTimestamp': lastMessageTimestamp,
      'timestamp': timestamp,
    };
  }
}
