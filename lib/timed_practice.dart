import 'dart:async';
import 'package:flutter/material.dart';
import 'package:oral_arithmetic_practitioner/math_problem_generator.dart'; // 导入 MathProblemGenerator
import 'utils.dart'; // 用于格式化时间

class TimedPracticeScreen extends StatefulWidget {
  final int grade; // 传递年级

  TimedPracticeScreen({Key? key, this.grade = 1}) : super(key: key);

  @override
  _TimedPracticeScreenState createState() => _TimedPracticeScreenState();
}

class _TimedPracticeScreenState extends State<TimedPracticeScreen> {
  int timeLimit = 60; // 限时60秒
  int timeRemaining;
  Timer? _timer;
  late List<String> problems; // 随机生成的题目列表
  int currentProblemIndex = 0;

  _TimedPracticeScreenState() : timeRemaining = 60;

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        timeRemaining--;
      });
      if (timeRemaining <= 0) {
        _timer?.cancel();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("时间结束！"),
              content: Text("你未能在限定时间内完成。"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  @override
  void initState() {
    super.initState();
    _loadProblems();  // 加载题目
    startTimer();
  }

  // 异步加载并生成题目
  Future<void> _loadProblems() async {
    List<String> generatedProblems = await MathProblemGenerator.generateProblems(widget.grade);  // 生成题目
    setState(() {
      problems = generatedProblems;  // 更新题目列表
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("限时练习"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("时间还剩: ${formatTime(timeRemaining)}",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            Text("题目${currentProblemIndex + 1}: ${problems[currentProblemIndex]}",
                style: TextStyle(fontSize: 24)),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if (currentProblemIndex < problems.length - 1) {
                  setState(() {
                    currentProblemIndex++;
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("恭喜！"),
                        content: Text("你已经做完了所有题目。"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              child: Text('下一道题'),
            ),
          ],
        ),
      ),
    );
  }
}
