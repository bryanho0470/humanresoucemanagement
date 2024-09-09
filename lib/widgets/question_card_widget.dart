import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/global/common/hero_dialog_route.dart';
import 'package:humanresoucemanagement/models/question_data_model.dart';
import 'package:humanresoucemanagement/pages/detailed_question_page.dart';
import 'package:humanresoucemanagement/styles/custom_rect_tween.dart';
import 'package:humanresoucemanagement/styles/style.dart';

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

class _QuestionCard extends StatefulWidget {
  const _QuestionCard({
    required this.question,
  });

  final Question question;

  @override
  State<_QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<_QuestionCard> {
  bool isFolded = false;

  void toggleFold() {
    setState(() {
      isFolded = !isFolded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(HeroDialogRoute(
          builder: (context) => Center(
            child: _QuestionPopupCard(question: widget.question),
          ),
        ));
      },
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
                _QuestionTitleForHide(
                  title: widget.question.title,
                  toggleFold: toggleFold,
                  isFolded: isFolded,
                ),
                AnimatedSize(
                  duration: const Duration(milliseconds: 50),
                  child: isFolded
                      ? const SizedBox.shrink()
                      : Column(
                          children: [
                            const Divider(),
                            _QuestionItemBox(question: widget.question),
                          ],
                        ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///[=====================================================================]

// sharing list title setting
class _QuestionTitleForHide extends StatelessWidget {
  const _QuestionTitleForHide({
    required this.title,
    required this.toggleFold,
    required this.isFolded,
  });

  final String title;
  final VoidCallback toggleFold;
  final bool isFolded;

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
            onPressed: toggleFold,
            child: Text(
              isFolded ? "Show" : "Hide",
              style: const TextStyle(color: Colors.grey),
            ),
          ),
        )
      ],
    );
  }
}

///[=====================================================================]

// sharing list title setting
class _QuestionTitleForClose extends StatelessWidget {
  const _QuestionTitleForClose({
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
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              "Close",
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
  @override
  Widget build(BuildContext context) {
    // set chatacter limit
    const int textLimit = 25;

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
              Expanded(
                child: Wrap(
                  spacing: 3,
                  runSpacing: 3,
                  alignment: WrapAlignment.end,
                  runAlignment: WrapAlignment.spaceBetween,
                  children: [
                    /// [need to convert this list to Widget]
                    Chip(
                      label: const Text(
                        'Economy',
                        style: TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.grey[400],
                      padding: const EdgeInsets.all(0.1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    Chip(
                      label: const Text(
                        "Social",
                        style: TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.grey[400],
                      padding: const EdgeInsets.all(0.1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    Chip(
                      label: const Text(
                        "Environment",
                        style: TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.grey[400],
                      padding: const EdgeInsets.all(0.1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: const TextStyle(color: Colors.white),
                    ),
                    Chip(
                      label: const Text(
                        "Sports",
                        style: TextStyle(fontSize: 10),
                      ),
                      backgroundColor: Colors.grey[400],
                      padding: const EdgeInsets.all(0.1),
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      labelStyle: const TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          const Divider(),
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
                    _QuestionTitleForClose(title: question.title),
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
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          "https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Lion_waiting_in_Namibia.jpg/220px-Lion_waiting_in_Namibia.jpg"),
                    )),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: SizedBox(
                  height: 300,
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(widget.question.contents),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.nkColortrans,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailedQuestion(
                    question: widget.question,
                  ),
                ),
              );
            },
            child: const Text(
              "Let me Answer",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
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
