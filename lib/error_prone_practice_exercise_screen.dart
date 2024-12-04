import 'package:flutter/material.dart';

class ErrorPronePracticeExerciseScreen extends StatefulWidget {
  final List<String> wrongQuestions;

  ErrorPronePracticeExerciseScreen({Key? key, required this.wrongQuestions}) : super(key: key);

  @override
  _ErrorPronePracticeExerciseScreenState createState() => _ErrorPronePracticeExerciseScreenState();
}

class _ErrorPronePracticeExerciseScreenState extends State<ErrorPronePracticeExerciseScreen> {
  late List<String> questions;
  int currentQuestionIndex = 0;
  final TextEditingController answerController = TextEditingController();
  String message = '';
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    questions = widget.wrongQuestions;  // 获取错题列表
  }

  void _checkAnswer() {
    String problem = questions[currentQuestionIndex];
    String correctAnswer = _getCorrectAnswer(problem);
    String userAnswer = answerController.text;

    setState(() {
      if (userAnswer == correctAnswer) {
        isCorrect = true;
        message = "正确！";
      } else {
        isCorrect = false;
        message = "错误，正确答案: $correctAnswer";
      }

      // 切换到下一个问题
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        answerController.clear();
      } else {
        message = "你已经完成了所有题目！";
      }
    });
  }

  String _getCorrectAnswer(String problem) {
    List<String> parts = problem.split(' ');
    int num1 = int.parse(parts[0]);
    int num2 = int.parse(parts[2]);

    if (parts[1] == '+') {
      return (num1 + num2).toString();
    } else {
      return (num1 * num2).toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("错题练习"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              '题目${currentQuestionIndex + 1}:  ${questions[currentQuestionIndex]}',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),

            // 用户输入答案区域
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                labelText: '请输入你的答案',
                labelStyle: TextStyle(fontSize: 18, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
              style: TextStyle(fontSize: 22),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // 提交答案按钮
            Center(
              child: ElevatedButton(
                onPressed: _checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                child: Text('提交答案', style: TextStyle(fontSize: 20)),
              ),
            ),
            SizedBox(height: 20),

            // 显示结果反馈信息
            Center(
              child: Text(
                message,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
              ),
            ),
            SizedBox(height: 30),

            // 进度条
            Center(
              child: Text(
                "进度: ${currentQuestionIndex + 1} / ${questions.length}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
