//import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/remote/openai_services.dart';

final chatStreamProvider = StateNotifierProvider<ChatNotifier, List<String>>(
  (ref) => ChatNotifier(),
);

class ChatNotifier extends StateNotifier<List<String>> {
  ChatNotifier() : super([]);

  void sendMessage(String prompt) async {
    state = [...state, "You: $prompt"];
    state = [...state, "AI: "];

    final index = state.length - 1;
    String current = "";

    try {
      final stream = OpenAIService.streamItinerary(prompt);
      await for (final token in stream) {
        current += token;
        state = [...state.sublist(0, index), "AI: $current"];
      }
    } catch (e) {
      state = [...state.sublist(0, index), "AI: (error: ${e.toString()})"];
    }
  }
}
class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final messages = ref.watch(chatStreamProvider);
    final controller = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Trip Assistant')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: messages.length,
              itemBuilder: (_, index) {
                final msg = messages[index];
                final isUser = msg.startsWith("You:");
                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blueAccent : Colors.grey.shade700,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.replaceFirst("You: ", "").replaceFirst("AI: ", ""),
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: "Describe your trip...",
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  final text = controller.text.trim();
                  if (text.isNotEmpty) {
                    ref.read(chatStreamProvider.notifier).sendMessage(text);
                    controller.clear();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
