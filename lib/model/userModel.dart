class UserModel {
  String? id;
  String? name;
  String? email;
  String? phoneNumber;
  String? profileImage;
  String? about;
  String? createdAt;
  String? lastOnlineStatus;
  String? status;
  String? role;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.profileImage,
    this.about,
    this.createdAt,
    this.lastOnlineStatus,
    this.status,
    this.role,
  });

  // Convert JSON to UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      profileImage: json['profileImage'] ?? '',
      about: json['about'] ?? '',
      createdAt: json['createdAt'] ?? '',
      lastOnlineStatus: json['lastOnlineStatus'] ?? '',
      status: json['status'] ?? '',
      role: json['role'] ?? '',
    );
  }

  // Convert UserModel to JSON (Map)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImage': profileImage,
      'about': about,
      'createdAt': createdAt,
      'lastOnlineStatus': lastOnlineStatus,
      'status': status,
      'role': role,
    };
  }
}
