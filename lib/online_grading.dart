class OnlineGrading {
  // 根据问题的正确答案批改
  bool gradeProblem(String problem, String answer) {
    String correctAnswer = _getCorrectAnswer(problem);
    return correctAnswer == answer;
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
}
