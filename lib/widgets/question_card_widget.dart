import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/global/common/hero_dialog_route.dart';
import 'package:humanresoucemanagement/models/question_data_model.dart';
import 'package:humanresoucemanagement/styles/custom_rect_tween.dart';

class QuestionContents extends StatelessWidget {
  const QuestionContents({
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

///[=====================================================================]

// sharing list title setting
class _QuestionTitle extends StatelessWidget {
  const _QuestionTitle({
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    );
  }
}

///[=====================================================================]

class _QuestionItemBox extends StatelessWidget {
  const _QuestionItemBox({
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

///[=====================================================================]

class _QuestionItemTile extends StatefulWidget {
  const _QuestionItemTile({
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
    // set chatacter limit
    const int textLimit = 15;

    // truncate the text if it exceeds the limit
    String truncatedText = widget.question.contents.length > textLimit
        ? '${widget.question.contents.substring(0, textLimit)}...'
        : widget.question.contents;

    return ListTile(
      leading: Checkbox(
        onChanged: _onChanged,
        value: widget.question.completed,
      ),
      title: Text(truncatedText),
    );
  }
}

///[=====================================================================]

class _QuestionPopupCard extends StatelessWidget {
  const _QuestionPopupCard({
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
                      _QuestionFullItemBox(question: question),
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

///[=====================================================================]

class _QuestionFullItemTile extends StatefulWidget {
  const _QuestionFullItemTile({
    required this.question,
  });

  final Question question;

  @override
  State<_QuestionFullItemTile> createState() => __QuestionFullItemTileState();
}

class __QuestionFullItemTileState extends State<_QuestionFullItemTile> {
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

///[=====================================================================]

class _QuestionFullItemBox extends StatelessWidget {
  const _QuestionFullItemBox({
    required this.question,
  });

  final Question question;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      _QuestionFullItemTile(question: question),
    ]);
  }
}
