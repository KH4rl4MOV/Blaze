import 'package:flutter/material.dart';
import 'add_goal_screen.dart';

class UserGoalsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        title: Text("User's Goals"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Здесь будут отображаться цели пользователя
                  ListTile(
                    title: Text('New Goal', style: TextStyle(color: Colors.white)),
                    trailing: IconButton(
                      icon: Icon(Icons.add_circle_outline, color: Colors.red),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddGoalScreen()),
                        );
                      },
                    ),
                  ),
                  // Пример цели
                  ListTile(
                    title: Text('Lose 5 Kg', style: TextStyle(color: Colors.white)),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.grey),
                      onPressed: () {
                        // Открыть экран редактирования цели
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
