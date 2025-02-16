class Chatmodel {
  String? id;
  String? message;
  String? senderName;
  String? senderId;
  String? receiverId;
  String? timestamp;
  String? imageUrl;
  String? videoUrl;
  String? audioUrl;
  String? documentUrl;
  List<String>? reactions;
  List<dynamic>? replies;

  Chatmodel({
    this.id,
    this.message,
    this.senderName,
    this.senderId,
    this.receiverId,
    this.timestamp,
    this.imageUrl,
    this.videoUrl,
    this.audioUrl,
    this.documentUrl,
    this.reactions,
    this.replies,
  });

  // Convert from JSON to Chatmodel
  factory Chatmodel.fromJson(Map<String, dynamic> json) {
    return Chatmodel(
      id: json['id'] ?? '', // Use empty string if null
      message: json['message'] ?? '', // Use empty string if null
      senderName: json['senderName'] ?? '', // Use empty string if null
      senderId: json['senderId'] ?? '', // Use empty string if null
      receiverId: json['receiverId'] ?? '', // Use empty string if null
      timestamp: json['timestamp'] ?? '', // Use empty string if null
      imageUrl: json['imageUrl'] ?? '', // Use empty string if null
      videoUrl: json['videoUrl'] ?? '', // Use empty string if null
      audioUrl: json['audioUrl'] ?? '', // Use empty string if null
      documentUrl: json['documentUrl'] ?? '', // Use empty string if null
      reactions:
          json['reactions'] != null ? List<String>.from(json['reactions']) : [],
      replies:
          json['replies'] != null ? List<dynamic>.from(json['replies']) : [],
    );
  }

  // Convert Chatmodel to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id ?? '',
      'message': message ?? '',
      'senderName': senderName ?? '',
      'senderId': senderId ?? '',
      'receiverId': receiverId ?? '',
      'timestamp': timestamp ?? '',
      'imageUrl': imageUrl ?? '',
      'videoUrl': videoUrl ?? '',
      'audioUrl': audioUrl ?? '',
      'documentUrl': documentUrl ?? '',
      'reactions': reactions ?? [],
      'replies': replies ?? [],
    };
  }
}
