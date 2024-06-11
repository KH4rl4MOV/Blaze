import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'add_entry_screen.dart';

class NotebookScreen extends StatefulWidget {
  @override
  _NotebookScreenState createState() => _NotebookScreenState();
}

class _NotebookScreenState extends State<NotebookScreen> {
  List<String> _userEntries = [];

  @override
  void initState() {
    super.initState();
    _loadEntries();
  }

  Future<void> _loadEntries() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userEntries = prefs.getStringList('user_entries') ?? [];
    });
  }

  Future<void> _deleteEntry(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> entries = prefs.getStringList('user_entries') ?? [];
    if (index < entries.length) {
      entries.removeAt(index);
      await prefs.setStringList('user_entries', entries);
      setState(() {
        _userEntries = entries;
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
            title: Text('Notebook'),
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
                ListTile(
                  title: Text('New Entry', style: TextStyle(color: Colors.white)),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_outline, color: Colors.red),
                    onPressed: () async {
                      bool result = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddEntryScreen()),
                      );
                      if (result == true) {
                        _loadEntries(); // Обновляем список после возврата с экрана добавления записи
                      }
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _userEntries.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_userEntries[index], style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.grey),
                          onPressed: () {
                            _deleteEntry(index);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
