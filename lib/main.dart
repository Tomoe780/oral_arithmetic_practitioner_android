import 'package:flutter/material.dart';
import 'grade_selection_screen.dart';  // 导入主页面

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '数学练习系统',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),  // 启动时进入登录页面
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

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
                      const Text(
                        "登录",
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                      ),

                      const SizedBox(height: 50),

                      // 用户名输入框
                      Container(
                        width: 200,
                        child: TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: '用户名',
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.blue[50],
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),

                      // 密码输入框
                      Container(
                        width: 200,
                        child: TextField(
                          controller: _passwordController,
                          obscureText: !_isPasswordVisible,
                          decoration: InputDecoration(
                            labelText: '密码',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            filled: true,
                            fillColor: Colors.blue[50],
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),

                      // 登录按钮
                      ElevatedButton(
                        onPressed: () {
                          // 登录成功后跳转到主页面
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => GradeSelectionScreen()), // 跳转到主页面
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
                            Icon(Icons.login, size: 28), // 添加图标
                            SizedBox(width: 8),
                            Text('登录', style: TextStyle(fontSize: 20)),
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
