import 'package:flutter/material.dart';
import 'math_practice_screen.dart';
import 'timed_practice.dart';
import 'result_analysis.dart';
import 'import_export_screen.dart';
import 'error_prone_practice.dart';

class GradeSelectionScreen extends StatefulWidget {
  const GradeSelectionScreen({super.key});

  @override
  _GradeSelectionScreenState createState() => _GradeSelectionScreenState();
}

class _GradeSelectionScreenState extends State<GradeSelectionScreen> {
  int selectedGrade = 1; // 默认选择1年级
  List<int> grades = [1, 2, 3, 4, 5, 6];
  final ErrorPronePractice errorPronePractice = ErrorPronePractice();  // 创建 ErrorPronePractice 实例

  String gradeToChinese(int grade) {
    const gradeNames = {
      1: '一年级',
      2: '二年级',
      3: '三年级',
      4: '四年级',
      5: '五年级',
      6: '六年级',
    };
    return gradeNames[grade] ?? '$grade年级';  // 默认返回原年级
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("数学练习系统", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          // 顶部背景图部分
          Container(
            height: 200.0, // 背景图片的高度
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/背景.jpg'), // 使用本地图片作为背景
                fit: BoxFit.cover, // 背景图覆盖整个容器
              ),
            ),
          ),

          // 主体内容部分
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.white, Colors.lightBlueAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "选择难度",
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.purpleAccent),
                      ),
                      // 下拉框
                      Container(
                        width: 110, // 设置固定宽度，控制下拉框的大小
                        child: InputDecorator(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.blue[50],
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                          ),
                          child: DropdownButton<int>(
                            value: selectedGrade,
                            onChanged: (int? newGrade) {
                              setState(() {
                                selectedGrade = newGrade!;  // 更新选择的年级
                              });
                            },
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                            items: grades.map<DropdownMenuItem<int>>((int grade) {
                              return DropdownMenuItem<int>(
                                value: grade,
                                child: Text(
                                  gradeToChinese(grade), // 使用中文显示年级
                                  style: const TextStyle(fontSize: 18, color: Colors.black),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
                      // 开始练习按钮
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MathPracticeScreen(grade: selectedGrade, errorPronePractice: errorPronePractice),  // 传递实例
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          elevation: 10,
                          shadowColor: Colors.blueGrey,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.play_arrow, size: 28), // 添加图标
                            SizedBox(width: 8),
                            Text('开始练习', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // 导入导出习题按钮
                      ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ImportExportScreen()),
                          );
                        },
                        icon: Icon(Icons.import_export),
                        label: Text('导入/导出习题', style: TextStyle(fontSize: 20)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 限时练习按钮
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TimedPracticeScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.timer, size: 28),
                            SizedBox(width: 8),
                            Text('限时在线练习', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 结果分析按钮
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResultAnalysisScreen()),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.lightGreen,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.analytics, size: 28),
                            SizedBox(width: 8),
                            Text('练习结果分析', style: TextStyle(fontSize: 20)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
