import 'package:flutter/material.dart';
import 'add_entry_screen.dart';

class NotebookScreen extends StatelessWidget {
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
        title: Text('Notebook'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  // Здесь будут отображаться записи пользователя
                  ListTile(
                    title: Text('New Entry', style: TextStyle(color: Colors.white)),
                    trailing: IconButton(
                      icon: Icon(Icons.add_circle_outline, color: Colors.red),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddEntryScreen()),
                        );
                      },
                    ),
                  ),
                  // Пример записи
                  ListTile(
                    title: Text('Meeting Notes', style: TextStyle(color: Colors.white)),
                    trailing: IconButton(
                      icon: Icon(Icons.edit, color: Colors.grey),
                      onPressed: () {
                        // Открыть экран редактирования записи
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