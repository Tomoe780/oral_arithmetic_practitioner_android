import 'package:flutter/material.dart';
import 'error_prone_practice_screen.dart';
import 'math_problem_generator.dart';
import 'online_grading.dart';
import 'error_prone_practice.dart';

class MathPracticeScreen extends StatefulWidget {
  final int grade;

  MathPracticeScreen({Key? key, this.grade = 1, required ErrorPronePractice errorPronePractice}) : super(key: key);

  @override
  _MathPracticeScreenState createState() => _MathPracticeScreenState();
}

class _MathPracticeScreenState extends State<MathPracticeScreen> {
  late List<String> problems;
  final OnlineGrading grading = OnlineGrading();
  final TextEditingController answerController = TextEditingController();
  int currentProblemIndex = 0;
  bool isCorrect = false;
  String message = '';
  final ErrorPronePractice errorPronePractice = ErrorPronePractice();  // 错题记录

  @override
  void initState() {
    super.initState();
    _loadProblems();  // 加载题目
  }

  // 异步加载并生成题目
  Future<void> _loadProblems() async {
    List<String> generatedProblems = await MathProblemGenerator.generateProblems(widget.grade);  // 生成题目
    setState(() {
      problems = generatedProblems;  // 更新题目列表
    });
  }

  void _checkAnswer() {
    String problem = problems[currentProblemIndex];
    String correctAnswer = _getCorrectAnswer(problem);
    String userAnswer = answerController.text;

    if (userAnswer == correctAnswer) {
      setState(() {
        isCorrect = true;
        message = "正确!";
      });
    } else {
      setState(() {
        isCorrect = false;
        message = "错误，正确答案: $correctAnswer";
        // 将错题添加到错题列表
        errorPronePractice.addWrongQuestion(problem);
      });
    }

    if (currentProblemIndex < problems.length - 1) {
      setState(() {
        currentProblemIndex++;
        answerController.clear();
      });
    } else {
      setState(() {
        message = "你已经做完所有题目！";
      });
    }
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
        title: Text("口算练习", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blueAccent,
      ),
      body: problems.isEmpty
          ? Center(child: CircularProgressIndicator())  // 如果题目还在加载，显示加载进度
          : Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 当前数学问题显示区域
            Card(
              elevation: 8,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '题目${currentProblemIndex + 1}:  ${problems[currentProblemIndex]}',
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ),
            SizedBox(height: 30),

            // 用户输入答案区域
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                labelText: '输入你的答案',
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
                "进度: ${currentProblemIndex + 1} / ${problems.length}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),

            SizedBox(height: 30),

            // 易错题按钮
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ErrorPronePracticeScreen(errorPronePractice: errorPronePractice),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                child: Text('查看错题', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

