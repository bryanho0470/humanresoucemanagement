import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/models/chat_model.dart';
import 'package:file_picker/file_picker.dart';

class DocumentsAiPage extends StatefulWidget {
  const DocumentsAiPage({super.key});

  @override
  _DocumentsAiPageState createState() => _DocumentsAiPageState();
}

class _DocumentsAiPageState extends State<DocumentsAiPage> {
  final TextEditingController _controller = TextEditingController();
  final List<String> _messages = [];
  final ChatService _chatService = ChatService();

  void _sendMessage() async {
    String userMessage = _controller.text;
    setState(() {
      _messages.add('User: $userMessage');
    });
    _controller.clear();

    String aiResponse = await _chatService.sendMessage(userMessage);
    setState(() {
      _messages.add('AI: $aiResponse');
    });
  }

  void _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null && result.files.isNotEmpty) {
      final file = result.files.first;
      setState(() {
        _messages.add('User: File selected: ${file.name}');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Chat')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_messages[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: _pickFile,
                  icon: const Icon(Icons.attach_file),
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration:
                        const InputDecoration(hintText: 'Type a message'),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
