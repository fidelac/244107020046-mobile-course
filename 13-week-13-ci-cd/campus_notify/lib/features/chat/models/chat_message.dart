enum MessageRole { user, assistant }

class ChatMessage {
  const ChatMessage({
    required this.content,
    required this.role,
    required this.createdAt,
  });

  final String content;
  final MessageRole role;
  final DateTime createdAt;

  bool get isUser => role == MessageRole.user;
}
