class Callmodel {
  String? id;
  String? callerName;
  String? callerPic;
  String? callerUid;
  String? callerEmail;
  String? receiverName;
  String? receiverPic;
  String? receiverUid;
  String? receiverEmail;
  String? status;
  String? type;
  String? time;
  String? timestamp;

  Callmodel({
    this.id,
    this.callerName,
    this.callerPic,
    this.callerUid,
    this.callerEmail,
    this.receiverName,
    this.receiverPic,
    this.receiverUid,
    this.receiverEmail,
    this.status,
    this.type,
    this.time,
    this.timestamp,
  });

  // Convert JSON to Model
  factory Callmodel.fromJson(Map<String, dynamic> json) {
    return Callmodel(
      id: json['id'],
      callerName: json['callerName'],
      callerPic: json['callerPic'],
      callerUid: json['callerUid'],
      callerEmail: json['callerEmail'],
      receiverName: json['receiverName'],
      receiverPic: json['receiverPic'],
      receiverUid: json['receiverUid'],
      receiverEmail: json['receiverEmail'],
      status: json['status'],
      type: json['type'], // Included the missing field
      time: json['time'], // Included the missing field
      timestamp: json['timestamp'], // Included the missing field
    );
  }

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'callerName': callerName,
      'callerPic': callerPic,
      'callerUid': callerUid,
      'callerEmail': callerEmail,
      'receiverName': receiverName,
      'receiverPic': receiverPic,
      'receiverUid': receiverUid,
      'receiverEmail': receiverEmail,
      'status': status,
      'type': type, // Included the missing field
      'time': time, // Included the missing field
      'timestamp': timestamp, // Included the missing field
    };
  }
}
