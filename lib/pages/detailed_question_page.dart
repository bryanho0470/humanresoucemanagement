import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/models/question_data_model.dart';
import 'package:humanresoucemanagement/styles/style.dart';

class DetailedQuestion extends StatelessWidget {
  const DetailedQuestion({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    final ScrollController contentsScrollController = ScrollController();
    final ScrollController chatScrollController = ScrollController();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Question Detail",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: AppColors.nkColor,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.nkColortrans,
              Colors.white,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.priority_high,
                        color: Colors.red[800],
                      ),
                      Icon(
                        Icons.flash_on_rounded,
                        color: Colors.red[800],
                      ),
                    ],
                  ),
                  Flexible(
                    child: Text(
                      question.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Lion_waiting_in_Namibia.jpg/220px-Lion_waiting_in_Namibia.jpg"))),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.white,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      child: Scrollbar(
                        controller: contentsScrollController,
                        child: SingleChildScrollView(
                          controller: contentsScrollController,
                          child: Text(question.contents),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(),
              Expanded(
                child: ListView(
                  controller: chatScrollController,
                  padding: const EdgeInsets.all(5),
                  children: const [
                    ChatMessage(text: "haha"),
                    ChatMessage(text: "hoho"),
                    ChatMessage(text: "PUPU"),
                  ],
                ),
              ),
              _buildChatInput(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      color: Colors.grey[100],
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0),
        child: Row(children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Input your answer",
                  labelStyle: TextStyle(color: Colors.white)),
            ),
          ),
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.send,
                color: AppColors.nkColor,
              ))
        ]),
      ),
    );
  }
}

class ChatMessage extends StatelessWidget {
  final String text;

  const ChatMessage({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.blue[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(text),
    );
  }
}
