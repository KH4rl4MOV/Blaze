import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';
import 'add_goal_screen.dart';

class UserGoalsScreen extends StatefulWidget {
  @override
  _UserGoalsScreenState createState() => _UserGoalsScreenState();
}

class _UserGoalsScreenState extends State<UserGoalsScreen> {
  List<String> _userGoals = [];

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userGoals = prefs.getStringList('user_goals') ?? [];
    });
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
            title: Text("User's Goals"),
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
                  title: Text('New Goal', style: TextStyle(color: Colors.white)),
                  trailing: IconButton(
                    icon: Icon(Icons.add_circle_outline, color: Colors.red),
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => AddGoalScreen()),
                      );
                      _loadGoals(); // Обновляем список после возврата с экрана добавления цели
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _userGoals.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(_userGoals[index], style: TextStyle(color: Colors.white)),
                        trailing: IconButton(
                          icon: Icon(Icons.edit, color: Colors.grey),
                          onPressed: () {
                            // Открыть экран редактирования цели
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
