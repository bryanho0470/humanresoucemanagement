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

///[=====================================================================]

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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 32,
              child: Icon(
                Icons.priority_high,
                color: Colors.red,
              ),
            ),
            SizedBox(
              width: 32,
              child: Icon(
                Icons.flash_on_rounded,
                color: Colors.red,
              ),
            ),
          ],
        ),
        SizedBox(
          width: 220,
          child: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(
          width: 65,
          child: TextButton(
            onPressed: () {},
            child: const Text(
              "Hide",
              style: TextStyle(color: Colors.grey),
            ),
          ),
        )
      ],
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

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: 130,
                child: Text(truncatedText),
              ),
              const SizedBox(
                width: 20,
              ),
              const Expanded(
                child: Wrap(
                  children: [
                    Chip(
                      label: Text(
                        'Economy',
                        style: TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.blue,
                      padding: EdgeInsets.all(1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    Chip(
                      label: Text(
                        "Social",
                        style: TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.orange,
                      padding: EdgeInsets.all(4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    Chip(
                      label: Text(
                        "Environment",
                        style: TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.all(4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: TextStyle(color: Colors.white),
                    ),
                    Chip(
                      label: Text(
                        "Sports",
                        style: TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.purple,
                      padding: EdgeInsets.all(4),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 350,
            child: Text(
              textAlign: TextAlign.right,
              "Owned by ${widget.question.owner} : ${widget.question.name}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
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
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                "assets/images/person/face.JPG",
                width: 30,
                height: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(widget.question.contents),
            ],
          ),
          SizedBox(
            width: 350,
            child: Text(
              textAlign: TextAlign.right,
              "Owned by ${widget.question.owner} : ${widget.question.name}",
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
    );
  }
}
