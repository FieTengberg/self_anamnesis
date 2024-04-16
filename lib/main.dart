import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/intro_screen.dart';
import 'package:flutter_application_test/app_colors.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Self-anamnesis',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.backgroundColor,
        useMaterial3: true,),
       home: const LogInScreen(),
    );
  }
}

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 500.0,
          height: 300.0,
          alignment: Alignment.bottomCenter, 
        
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'Indtast dit navn',
                ),
              ),
              const SizedBox(
                  height: 30), 
              ElevatedButton(
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => IntroScreen()),
                    //playAudio();
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.btnColor,
                  minimumSize: const Size(450, 50),
                ),
                child: Text(
                  'Log ind',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
