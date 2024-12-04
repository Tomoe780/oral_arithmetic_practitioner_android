import 'package:flutter/material.dart';
import 'error_prone_practice.dart';
import 'error_prone_practice_exercise_screen.dart';  // 导入 ErrorPronePractice 类

class ErrorPronePracticeScreen extends StatefulWidget {
  final ErrorPronePractice errorPronePractice;

  // 构造函数，接受 ErrorPronePractice 实例
  ErrorPronePracticeScreen({Key? key, required this.errorPronePractice}) : super(key: key);

  @override
  _ErrorPronePracticeScreenState createState() => _ErrorPronePracticeScreenState();
}

class _ErrorPronePracticeScreenState extends State<ErrorPronePracticeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("易错题练习"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "易错题列表",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: widget.errorPronePractice.getWrongQuestions().length,
                itemBuilder: (context, index) {
                  String wrongQuestion = widget.errorPronePractice.getWrongQuestions()[index];
                  return ListTile(
                    title: Text(wrongQuestion, style: TextStyle(fontSize: 18)),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        setState(() {
                          widget.errorPronePractice.getWrongQuestions().removeAt(index); // 删除错题
                        });
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // 跳转到错题练习界面，传递错题
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ErrorPronePracticeExerciseScreen(
                      wrongQuestions: widget.errorPronePractice.getWrongQuestions(),
                    ),
                  ),
                );
              },
              child: const Text("开始错题练习", style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
