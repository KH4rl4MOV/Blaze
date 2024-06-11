import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class ChatScreen extends StatelessWidget {
  final String workoutTitle;

  ChatScreen({required this.workoutTitle});

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
            title: Text(workoutTitle),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeProvider.getBackgroundImage()),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.all(16.0),
                    children: [
                      _buildChatMessage('You', workoutTitle),
                      _buildChatMessage('Trainer', 'Warm-up: Start with a 5-10 minute dynamic warm-up to get your heart rate up and loosen up your muscles.'),
                      _buildChatMessage('Trainer', 'HIIT Circuit: Perform a circuit of high-intensity interval training exercises. Do each exercise for 30 seconds, followed by a 10-second rest. Repeat the circuit 3-4 times.'),
                      _buildChatMessage('Trainer', 'Strength Training: Incorporate strength training exercises to build lean muscle mass and boost your metabolism. Do 3 sets of 12-15 reps of the following exercises:\n- Squats\n- Lunges\n- Push-ups'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Ask anything...',
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: Colors.grey[800]?.withOpacity(0.7),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.send, color: Colors.red),
                        onPressed: () {
                          // Логика отправки сообщения
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildChatMessage(String sender, String message) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: Align(
        alignment: sender == 'You' ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: sender == 'You' ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: sender == 'You' ? Colors.red : Colors.grey[800]?.withOpacity(0.7),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            SizedBox(height: 4),
            Text(
              sender == 'You' ? '01:40 PM' : '01:41 PM',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
