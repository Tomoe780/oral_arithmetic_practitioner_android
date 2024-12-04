import 'dart:math';
import 'databaseHelper.dart';

class MathProblemGenerator {
  // 根据年级生成不同难度的口算题
  static Future<List<String>> generateProblems(int grade) async {
    List<String> problems = [];
    List<Map<String, dynamic>> problemEntries = [];
    Random rand = Random();

    for (int i = 0; i < 10; i++) {
      int num1, num2;
      String problem;
      String answer;

      // 生成题目
      if (grade == 1) {
        num1 = rand.nextInt(20);
        num2 = rand.nextInt(20);
        problem = "$num1 + $num2 = ?";
        answer = (num1 + num2).toString();
      } else if (grade == 2) {
        num1 = rand.nextInt(50);
        num2 = rand.nextInt(50);
        problem = "$num1 + $num2 = ?";
        answer = (num1 + num2).toString();
      } else if (grade == 3) {
        num1 = rand.nextInt(100);
        num2 = rand.nextInt(100);
        problem = "$num1 + $num2 = ?";
        answer = (num1 + num2).toString();
      } else if (grade == 4) {
        num1 = rand.nextInt(100);
        num2 = rand.nextInt(100);
        problem = "$num1 * $num2 = ?";
        answer = (num1 * num2).toString();
      } else if (grade == 5) {
        num1 = rand.nextInt(200);
        num2 = rand.nextInt(200);
        problem = "$num1 * $num2 = ?";
        answer = (num1 * num2).toString();
      } else {
        num1 = rand.nextInt(200);
        num2 = rand.nextInt(200);
        problem = "$num1 * $num2 = ?";
        answer = (num1 * num2).toString();
      }

      // 将问题和答案保存到列表中
      problemEntries.add({
        'problem': problem,
        'answer': answer,
      });

      problems.add(problem);
    }

    // 将生成的题目保存到数据库
    DatabaseHelper dbHelper = DatabaseHelper.instance;  // 使用单例访问实例
    for (var entry in problemEntries) {
      await dbHelper.insertProblem(entry['problem'], entry['answer']);
    }

    return problems;
  }
}
