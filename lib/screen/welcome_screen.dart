import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import '../theme_provider.dart';
import 'home_screen.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  File? _avatarImage;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _avatarImage = File(pickedFile.path);
      });
    }
  }

  bool _areFieldsValid() {
    return _nameController.text.isNotEmpty &&
        _ageController.text.isNotEmpty &&
        _weightController.text.isNotEmpty &&
        _heightController.text.isNotEmpty &&
        _avatarImage != null;
  }

  Future<void> _continue() async {
    if (_areFieldsValid()) {
      // Сохранение данных
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('name', _nameController.text);
      await prefs.setInt('age', int.parse(_ageController.text));
      await prefs.setInt('weight', int.parse(_weightController.text));
      await prefs.setInt('height', int.parse(_heightController.text));

      // Сохранение аватара
      if (_avatarImage != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = '${directory.path}/avatar.jpg';
        await _avatarImage!.copy(imagePath);
        await prefs.setString('avatar_path', imagePath);
      }

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      _showErrorDialog();
    }
  }

  void _showErrorDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('Please fill in all fields and select an avatar.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeProvider.getBackgroundImage()),
                fit: BoxFit.cover,
              ),
            ),
            padding: EdgeInsets.all(16.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey,
                      backgroundImage:
                      _avatarImage != null ? FileImage(_avatarImage!) : null,
                      child: _avatarImage == null
                          ? Icon(Icons.person, size: 50, color: Colors.white)
                          : null,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      filled: true,
                      fillColor: Colors.grey[800]?.withOpacity(0.7),
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _ageController,
                    decoration: InputDecoration(
                      labelText: 'Age',
                      filled: true,
                      fillColor: Colors.grey[800]?.withOpacity(0.7),
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _weightController,
                    decoration: InputDecoration(
                      labelText: 'Weight',
                      filled: true,
                      fillColor: Colors.grey[800]?.withOpacity(0.7),
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  TextField(
                    controller: _heightController,
                    decoration: InputDecoration(
                      labelText: 'Height',
                      filled: true,
                      fillColor: Colors.grey[800]?.withOpacity(0.7),
                      labelStyle: TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.number,
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: _continue,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
