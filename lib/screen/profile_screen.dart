import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'notebook_screen.dart';
import 'user_goals_screen.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _userName = 'User';
  int _age = 0;
  int _weight = 0;
  int _height = 0;
  File? _avatarImage;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('name') ?? 'User';
      _age = prefs.getInt('age') ?? 0;
      _weight = prefs.getInt('weight') ?? 0;
      _height = prefs.getInt('height') ?? 0;
      String? avatarPath = prefs.getString('avatar_path');
      if (avatarPath != null) {
        _avatarImage = File(avatarPath);
      }
    });
  }

  Future<void> _updateAvatar() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final newImagePath = '${directory.path}/avatar.jpg';
      final newImage = File(pickedFile.path);
      await newImage.copy(newImagePath);

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('avatar_path', newImagePath);

      setState(() {
        _avatarImage = File(newImagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Profile'),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeProvider.getBackgroundImage()),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: _updateAvatar,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _avatarImage != null ? FileImage(_avatarImage!) : null,
                    backgroundColor: Colors.grey,
                    child: _avatarImage == null ? Icon(Icons.person, size: 50, color: Colors.white) : null,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  _userName,
                  style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 32),
                _buildInfoRow('Name:', _userName),
                _buildInfoRow('Age:', '$_age Years Old'),
                _buildInfoRow('Weight:', '$_weight Kg'),
                _buildInfoRow('Height:', '$_height Cm'),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => UserGoalsScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    "User's Goals",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotebookScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Text(
                    'Notebook',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: Colors.grey, fontSize: 16),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Icon(Icons.edit, color: Colors.grey), // Иконка редактирования
        ],
      ),
    );
  }
}
