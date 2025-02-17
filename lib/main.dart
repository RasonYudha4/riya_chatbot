import 'package:flutter/material.dart';
import 'package:riya_chatbot/screens/chat_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AI Summarization',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ChatScreen(),
    );
  }
}
