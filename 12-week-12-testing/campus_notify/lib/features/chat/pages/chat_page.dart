import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/chat_message.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_bubble.dart';
import '../widgets/chat_empty.dart';
import '../widgets/chat_input.dart';

class ChatPage extends ConsumerWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Campus Notify AI', style: TextStyle(fontSize: 17)),
            Text(
              'Asisten virtual kampus',
              style: TextStyle(fontSize: 11, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: 'Hapus percakapan',
            icon: const Icon(Icons.delete_outline),
            onPressed: () {
              ref.read(chatProvider.notifier).clearMessages();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          const Expanded(child: _ChatMessageList()),
          ChatInput(
            onSend: (text) {
              ref.read(chatProvider.notifier).addMessage(
                    ChatMessage(
                      content: text,
                      role: MessageRole.user,
                      createdAt: DateTime.now(),
                    ),
                  );
            },
          ),
        ],
      ),
    );
  }
}

class _ChatMessageList extends ConsumerWidget {
  const _ChatMessageList();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatProvider);

    if (messages.isEmpty) {
      return const ChatEmptyState();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return ChatBubble(message: messages[index]);
      },
    );
  }
}