import 'dart:async';
import 'package:flutter/material.dart';
import 'Sencondpage.dart';
import 'json.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyHomePage(title: 'TREESTAR'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _showPassword = false;
  bool private=false;
  int _counter = 0;
  Color _color = const Color.fromARGB(255, 63, 178, 67);
  Color _color2 = Colors.white;
  Color _color3 = Colors.black;
  // final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+@gmail\.com$');
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z0-9\s]+@gmail\.com$');
  final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  // final RegExp passwordRegExp = RegExp(r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$');
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();


  void _incrementCounter() {
    setState(() {
      print( _nameController.text);
      print( _passwordController.text);

      if (_nameController.text.isEmpty || _passwordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vui lòng nhập đầy đủ thông tin')),
        );
        return;
      }

      if (!nameRegExp.hasMatch(_nameController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('email không hợp lệ')),
        );
        _nameController.clear();
        return;
        
      }

      if (!passwordRegExp.hasMatch(_passwordController.text)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Mật khẩu không hợp lệ')),
         
        );
        _passwordController.clear();
        return;
      }
      if(nameRegExp.hasMatch(_nameController.text) && passwordRegExp.hasMatch(_passwordController.text)){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đăng nhập thành công')),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SecondPage()),
        );
      }
      
  
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        
        backgroundColor: _color,
        
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          height: 500,
          width: 500,
          margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.circular(50),
              border: Border.all(color: _color, width: 2),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: _color2,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: _color,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.all(20),

                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      hintText: 'nhập email của bạn',
                      filled: true,
                      fillColor: _color2,
                      labelStyle: TextStyle(color: _color3),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: _color2, width: 2),
                      ),
                    ),
                  )
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: !private,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: TextStyle(color: _color3),
                      filled: true,
                      fillColor: _color2,
                      hintText: 'nhập mật khẩu của bạn',
                      
                      prefixIcon: IconButton(
                       
                        icon: Icon(
                          _showPassword ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          
                          setState(() {
                            
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: _color2, width: 2),
                      ),
                    ),
                  )
                ),
                ElevatedButton(
                  onPressed: (){
                    _incrementCounter();
                    
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _color2,
                    foregroundColor: _color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text('Đăng nhập'),
                ),
              ],
            ),
          ),
        ),
    );
      
    
    
  }
}



