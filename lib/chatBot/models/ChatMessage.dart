class ChatMessage {
  final String message;
  final String sender;
  final String? replyTo; // Optional field to store the message being replied to
  final DateTime timestamp; // Timestamp for sorting messages

  ChatMessage({
    required this.message,
    required this.sender,
    this.replyTo,
    required this.timestamp,
  });

  // Convert a ChatMessage to a Map (for Firebase or local storage)
  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'sender': sender,
      'replyTo': replyTo,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Create a ChatMessage from a Map (for Firebase or local storage)
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      message: map['message'],
      sender: map['sender'],
      replyTo: map['replyTo'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
