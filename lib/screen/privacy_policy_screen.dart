import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_provider.dart';

class PrivacyPolicyScreen extends StatelessWidget {
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
            title: Text('Privacy Policy'),
          ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(themeProvider.getBackgroundImage()),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Text(
                  'Privacy Policy',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Massa odio rhoncus augue nam malesuada sed. Consequat in elit nulla '
                      'pretium platea leo. Mauris molestie et porttitor venenatis adipiscing '
                      'bibendum. Ullamcorper augue volutpat sagittis. Lorem ipsum dolor sit amet, '
                      'consectetur adipiscing elit. Massa odio rhoncus augue nam malesuada sed. '
                      'Consequat in elit nulla pretium platea leo. Mauris molestie et porttitor '
                      'venenatis adipiscing bibendum. Ullamcorper augue volutpat sagittis.\n\n'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa odio rhoncus '
                      'augue nam malesuada sed. Consequat in elit nulla pretium platea leo. Mauris '
                      'molestie et porttitor venenatis adipiscing bibendum. Ullamcorper augue '
                      'volutpat sagittis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Massa odio rhoncus augue nam malesuada sed. Consequat in elit nulla pretium '
                      'platea leo. Mauris molestie et porttitor venenatis adipiscing bibendum. '
                      'Ullamcorper augue volutpat sagittis.\n\n'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa odio rhoncus '
                      'augue nam malesuada sed. Consequat in elit nulla pretium platea leo. Mauris '
                      'molestie et porttitor venenatis adipiscing bibendum. Ullamcorper augue '
                      'volutpat sagittis. Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                      'Massa odio rhoncus augue nam malesuada sed. Consequat in elit nulla pretium '
                      'platea leo. Mauris molestie et porttitor venenatis adipiscing bibendum. '
                      'Ullamcorper augue volutpat sagittis.\n\n'
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Massa odio rhoncus '
                      'augue nam malesuada sed. Consequat in elit nulla pretium platea leo. Mauris '
                      'molestie et porttitor venenatis adipiscing bibendum. Ullamcorper augue '
                      'volutpat sagittis.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    height: 1.5,
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
