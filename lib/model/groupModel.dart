import 'package:chatapp/model/userModel.dart';

class ChatModel {
  String? id;
  String? name;
  String? description;
  String? profileUrl;
  List<UserModel>? members;
  String? createdAt;
  String? createBy;
  String? status;
  String? lastMessage;
  String? lastMessageTime;
  String? lastMessageBy;
  int? unReadCount;
  String? timeStamp;

  ChatModel({
    this.id,
    this.name,
    this.description,
    this.profileUrl,
    this.members,
    this.createdAt,
    this.createBy,
    this.status,
    this.lastMessage,
    this.lastMessageTime,
    this.lastMessageBy,
    this.unReadCount,
    this.timeStamp,
  });

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      profileUrl: json['profileUrl'],
      members: List<UserModel>.from(json['members'] ?? []),
      createdAt: json['createdAt'],
      createBy: json['createBy'],
      status: json['status'],
      lastMessage: json['lastMessage'],
      lastMessageTime: json['lastMessageTime'],
      lastMessageBy: json['lastMessageBy'],
      unReadCount: json['unReadCount'],
      timeStamp: json['timeStamp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'profileUrl': profileUrl,
      'members': members,
      'createdAt': createdAt,
      'createBy': createBy,
      'status': status,
      'lastMessage': lastMessage,
      'lastMessageTime': lastMessageTime,
      'lastMessageBy': lastMessageBy,
      'unReadCount': unReadCount,
      'timeStamp': timeStamp,
    };
  }
}
