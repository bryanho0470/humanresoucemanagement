import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:humanresoucemanagement/models/question_data_model.dart';
import 'package:humanresoucemanagement/widgets/question_card_widget.dart';

class SharingPage extends StatefulWidget {
  const SharingPage({super.key});

  @override
  State<SharingPage> createState() => _SharingPageState();
}

class _SharingPageState extends State<SharingPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  late Stream<List<Question>> questionStream;

  @override
  void initState() {
    super.initState();
    questionStream = _getQuestionData();
  }

  Stream<List<Question>> _getQuestionData() {
    return firestore.collection("questions").snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Question.fromFirestore(doc)).toList());
  }

  Future<void> _refreshQuestions() async {
    setState(
      () {
        questionStream = _getQuestionData();
      },
    );
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
                  child: RefreshIndicator(
                    onRefresh: _refreshQuestions,
                    child: StreamBuilder<List<Question>>(
                      stream: _getQuestionData(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
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
                          return QuestionContents(
                            questions: questionData,
                          );
                        }
                      },
                    ),
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
