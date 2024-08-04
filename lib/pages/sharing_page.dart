import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/global/common/hero_dialog_route.dart';
import 'package:humanresoucemanagement/models/question_data_model.dart';
import 'package:humanresoucemanagement/styles/custom_rect_tween.dart';

class SharingPage extends StatefulWidget {
  const SharingPage({super.key});

  @override
  State<SharingPage> createState() => _SharingPageState();
}

class _SharingPageState extends State<SharingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Question>> _getQuestionData() {
    return firestore.collection("questions").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Question.fromFirestore(doc)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              Expanded(
                child: SafeArea(
                  child: StreamBuilder<List<Question>>(
                    stream: _getQuestionData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data == null || snapshot.data!.isEmpty) {
                        return const Center(
                          child: Text('no request found'),
                        );
                      } else {
                        final questionData = snapshot.data!;
                        return _QuestionContents(
                          questions: questionData,
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuestionContents extends StatelessWidget {
  const _QuestionContents({
    super.key,
    required this.questions,
  });

  final List<Question> questions;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: questions.length,
      itemBuilder: (context, index) {
        final question = questions[index];
        return _QuestionCard(question: question);
      },
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(
          builder: (context) => Center(
            child: _QuestionPopupCard(question: question),
          ),
        ));
      },
      child: Hero(
        createRectTween: (begin, end) {
          return CustomRectTween(begin: begin, end: end);
        },
        tag: question.id,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Material(
            shadowColor: Colors.grey,
            elevation: 2,
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _QuestionTitle(title: question.title),
                  ...[
                    const Divider(),
                    _QuestionItemBox(question: question),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionTitle extends StatelessWidget {
  const _QuestionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}

class _QuestionPopupCard extends StatelessWidget {
  const _QuestionPopupCard({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: question.id,
      createRectTween: (begin, end) {
        return CustomRectTween(begin: begin, end: end);
      },
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Material(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _QuestionTitle(title: question.title),
                    const SizedBox(
                      height: 8,
                    ),
                    ...[
                      const Divider(),
                      _QuestionItemBox(question: question),
                    ],
                    Container(
                      margin: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const TextField(
                        maxLines: 8,
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          hintText: "write a questions...",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionItemBox extends StatelessWidget {
  const _QuestionItemBox({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _QuestionItemTile(question: question),
    ]);
  }
}

class _QuestionItemTile extends StatefulWidget {
  const _QuestionItemTile({
    super.key,
    required this.question,
  });

  final Question question;

  @override
  State<_QuestionItemTile> createState() => __QuestionItemTileState();
}

class __QuestionItemTileState extends State<_QuestionItemTile> {
  bool val = false;
  void _onChanged(bool? val) {
    setState(() {
      widget.question.completed = val!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        onChanged: _onChanged,
        value: widget.question.completed,
      ),
      title: Text(widget.question.contents),
    );
  }
}
