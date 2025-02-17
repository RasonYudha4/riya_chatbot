import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  List<Map<String, dynamic>> _message = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Default AppBar height
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), // Adjust radius as needed
            bottomRight: Radius.circular(30),
          ),
          child: AppBar(
            backgroundColor: Color(0xFF213687),
            leading: IconButton(
              onPressed: () {
                print("Go back");
              },
              icon: Icon(Icons.chevron_left_rounded,
                  color: Colors.white, size: 38),
            ),
            leadingWidth: 56,
            title: Text(
              "RIYA Chatbot",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w400,
              ),
            ),
            centerTitle: true,
          ),
        ),
      ),
      body: Column(
        children: [],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFF213687),
        shape: CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                print("Add attachment");
              },
              icon: Icon(Icons.add_rounded, color: Colors.blue, size: 28),
            ),
            Spacer(),
            Flexible(
              flex: 12,
              child: TextField(
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                print("Send message");
              },
              icon: Icon(Icons.send_rounded, color: Colors.white, size: 28),
            ),
          ],
        ),
      ),
    );
  }
}
