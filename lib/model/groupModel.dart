import 'package:chatapp/model/userModel.dart';

class GroupModel {
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

  GroupModel({
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

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      profileUrl: json['profileUrl'],
      // members: List<UserModel>.from(json['members'] ?? []),
      members: (json['members'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
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
      // 'members': members,
      'members': members?.map((e) => e.toJson()).toList(),
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
