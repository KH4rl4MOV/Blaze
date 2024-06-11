import 'package:flutter/material.dart';
import 'profile_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://example.com/user-photo.jpg'), // Реальный URL изображения
            ),
            SizedBox(height: 16),
            Text(
              'Hello Kaitriona', // Приветствие
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 32),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuItem(
                    context,
                    icon: Icons.person,
                    text: 'Profile',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileScreen(
                          userName: 'Kaitriona',
                          age: 21,
                          weight: 65,
                          height: 160,
                          profileImageUrl: 'https://example.com/user-photo.jpg',
                        )),
                      );
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.fitness_center,
                    text: 'Workout',
                    onTap: () {
                      // Перейти на экран тренировок
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.note,
                    text: 'Notebook',
                    onTap: () {
                      // Перейти на экран блокнота
                    },
                  ),
                  _buildMenuItem(
                    context,
                    icon: Icons.settings,
                    text: 'Settings',
                    onTap: () {
                      // Перейти на экран настроек
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Privacy Policy',
              style: TextStyle(color: Colors.white, fontSize: 16, decoration: TextDecoration.underline),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {required IconData icon, required String text, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[900],
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.red, size: 40),
            SizedBox(height: 8),
            Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
