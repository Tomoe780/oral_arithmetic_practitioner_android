class ErrorPronePractice {
  List<String> wrongQuestions = [];  // 存储错题

  // 添加错题
  void addWrongQuestion(String problem) {
    wrongQuestions.add(problem);
  }

  // 获取错题列表
  List<String> getWrongQuestions() {
    return wrongQuestions;
  }

  // 清空错题列表
  void clearWrongQuestions() {
    wrongQuestions.clear();
  }
}
