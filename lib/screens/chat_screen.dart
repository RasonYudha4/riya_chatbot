import 'package:flutter/material.dart';
import 'package:riya_chatbot/services/chat_service.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final APIService _apiService = APIService();
  List<Map<String, dynamic>> _messages = [];
  bool _isLoading = false;

  void _sendMessage() async {
    String message = _controller.text.trim();
    if (message.isEmpty) return;

    setState(() {
      _messages.add({'type': 'sent', 'message': message});
      _controller.clear();
      _isLoading = true;
    });

    try {
      String response = await _apiService.askQuestion(message);
      setState(() {
        _messages.add({'type': 'received', 'message': response});
      });
    } catch (e) {
      setState(() {
        _messages.add(
            {'type': 'received', 'message': 'Error: Unable to fetch response'});
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
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
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                bool isSent = msg['type'] == 'sent';
                return Align(
                  alignment:
                      isSent ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    margin: EdgeInsets.symmetric(vertical: 4.0),
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7,
                    ),
                    decoration: BoxDecoration(
                      color: isSent ? Color(0xFF213687) : Color(0xFFE6E6E6),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24.0),
                        topRight: Radius.circular(24.0),
                        bottomLeft:
                            isSent ? Radius.circular(24.0) : Radius.zero,
                        bottomRight:
                            isSent ? Radius.zero : Radius.circular(24.0),
                      ),
                    ),
                    child: Text(
                      msg['message'],
                      style: TextStyle(
                        color: isSent ? Colors.white : Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (_isLoading)
            Padding(
              padding: EdgeInsets.all(10),
              child: CircularProgressIndicator(),
            ),
          Container(
            color: Color(0xFF213687),
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      print("Add attachment");
                    },
                    icon:
                        Icon(Icons.add_rounded, color: Colors.white, size: 32),
                  ),
                  Spacer(),
                  Flexible(
                    flex: 12,
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        hintStyle: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
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
                        fillColor: Color(0xFF213687),
                      ),
                      style: TextStyle(color: Colors.white),
                      controller: _controller,
                    ),
                  ),
                  Spacer(),
                  IconButton(
                    onPressed: _sendMessage,
                    icon:
                        Icon(Icons.send_rounded, color: Colors.white, size: 32),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
