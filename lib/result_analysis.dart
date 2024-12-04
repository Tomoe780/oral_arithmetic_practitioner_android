import 'package:flutter/material.dart';

class ResultAnalysisScreen extends StatelessWidget {
  // 这里可以传递参数，比如用户的答题记录，或者从数据库中获取结果
  // 这里使用固定数据来展示示例
  final int correctAnswers = 8; // 正确答案数
  final int totalQuestions = 10; // 总题目数
  final double accuracy = 80.0; // 正确率

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("结果分析"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "你的练习结果：",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // 显示正确答案数
            Text(
              "正确答案数: $correctAnswers / $totalQuestions",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),

            // 显示正确率
            Text(
              "正确率: ${accuracy.toStringAsFixed(2)}%",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),

            // 可以添加图表或其他数据展示
            Text(
              "建议: 继续保持练习，提升答题速度！",
              style: TextStyle(fontSize: 18, color: Colors.green),
            ),
            SizedBox(height: 30),

            // 返回按钮
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // 返回上一页
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  elevation: 5,
                ),
                child: Text('返回', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
