import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Intro Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Large square for text
            Container(
              width: 600, // Adjust size as needed
              height: 300, // Adjust size as needed
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Hej Jan!',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 10), // Add some space between sections
                    Text(
                      'For at hjælpe din fysioterapeut med at målrette din behandlingsindsats, skal vi have dig til at besvare nogle spørgsmål omhandlende din problematik og grunden til at du er her.',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30), // Spacer
            // Pressable button
            ElevatedButton(
              onPressed: () {
                // Handle button press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                minimumSize: Size(450, 50),
              ),
              child: Text(
                'Start',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
