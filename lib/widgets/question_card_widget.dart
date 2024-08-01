import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: <Widget>[
            const ClipRRect(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(15),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "Xard title",
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Button1",
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text("Button2"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
