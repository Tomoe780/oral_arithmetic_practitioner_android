import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:csv/csv.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

// 问题模型
class Problem {
  final int? id; // SQLite中的主键
  final String question; // 题目
  final String answer; // 答案

  Problem({this.id, required this.question, required this.answer});

  // 将模型类转换为Map，以便插入到SQLite中
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
    };
  }

  // 从Map中创建一个Problem对象
  factory Problem.fromMap(Map<String, dynamic> map) {
    return Problem(
      id: map['id'],
      question: map['question'],
      answer: map['answer'],
    );
  }
}

// 导入导出页面
class ImportExportScreen extends StatefulWidget {
  @override
  _ImportExportScreenState createState() => _ImportExportScreenState();
}

class _ImportExportScreenState extends State<ImportExportScreen> {
  List<Problem> _problems = [];
  Database? _database;

  @override
  void initState() {
    super.initState();
    _initializeDatabase();
  }

  // 初始化数据库
  Future<void> _initializeDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = '${directory.path}/problems.db';

    _database = await openDatabase(path, version: 1, onCreate: (db, version) {
      return db.execute(
        'CREATE TABLE problems(id INTEGER PRIMARY KEY, question TEXT, answer TEXT)',
      );
    });
  }

  // 导入习题
  void _importProblems() async {
    // 选择CSV文件
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['csv'],
    );

    if (result != null) {
      String path = result.files.single.path!; // 获取文件路径
      List<List<dynamic>> csvData = await _parseCSV(path); // 解析CSV文件

      // 转换为 Problem 对象
      List<Problem> problems = csvData.map((problem) {
        return Problem(question: problem[0].toString(), answer: problem[1].toString());
      }).toList();

      // 更新问题数据
      setState(() {
        _problems = problems;
      });

      // 将CSV数据保存到数据库
      await _saveProblemsToDatabase(problems);

      // 导入后跳转到做题页面
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => ImportExportPracticeScreen(
              problems: problems, // 传递 List<Problem> 到做题页面
            )),
      );
    }
  }

  // 解析CSV文件
  Future<List<List<dynamic>>> _parseCSV(String path) async {
    final input = File(path).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(CsvToListConverter())
        .toList();
    return fields;
  }

  // 将题目保存到数据库
  Future<void> _saveProblemsToDatabase(List<Problem> problems) async {
    // 清空数据库中的旧数据
    await _database?.delete('problems');

    // 保存新数据，最多保存10道题
    for (int i = 0; i < problems.length && i < 10; i++) {
      await _database?.insert('problems', problems[i].toMap());
    }
  }

  // 导出习题
  void _exportProblems() async {
    // 从数据库中获取问题
    final List<Map<String, dynamic>> problems = await _database?.query('problems') ?? [];

    // 创建CSV内容
    List<List<String>> rows = [
      ['Problem', 'Answer'],
      ...problems.map((e) => [
        e['question'].toString(),  // 确保转换为 String 类型
        e['answer'].toString()     // 确保转换为 String 类型
      ]).toList(),
    ];

    String csv = const ListToCsvConverter().convert(rows); // 转换为CSV格式

    // 获取保存路径
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/exported_problems.csv');

    // 保存CSV文件
    await file.writeAsString(csv);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("文件导出成功！"),
    ));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("导入/导出题目")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // 导入数据按钮
            ElevatedButton(
              onPressed: _importProblems,
              child: Text('导入题目'),
            ),
            SizedBox(height: 20),
            // 导出数据按钮
            ElevatedButton(
              onPressed: _exportProblems,
              child: Text('导出题目'),
            ),
            SizedBox(height: 20),
            // 显示导入的CSV数据
            Expanded(
              child: ListView.builder(
                itemCount: _problems.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text("${_problems[index].question} = ?"),
                    subtitle: Text('Answer: ${_problems[index].answer}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 做题页面
class ImportExportPracticeScreen extends StatelessWidget {
  final List<Problem> problems;

  ImportExportPracticeScreen({required this.problems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("数学口算练习")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: problems.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text("${index + 1}. ${problems[index].question} = ?"),
            );
          },
        ),
      ),
    );
  }
}
