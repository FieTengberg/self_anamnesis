import 'package:flutter/material.dart';
import 'package:flutter_application_test/screens/intro_screen.dart';
import 'package:flutter_application_test/CustomizedClasses/app_colors.dart';
import 'package:flutter_application_test/CustomizedClasses/logo_display.dart';

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
        useMaterial3: true,
      ),
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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 20.0),
          decoration: BoxDecoration(
            color: AppColors.backgroundColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo.png',
                width: 350,
                height: 350,
              ),
              TextField(
                decoration: InputDecoration(
                    labelText: 'Indtast dit navn',
                    contentPadding: EdgeInsets.symmetric(
                        horizontal: 550.0, vertical: 15.0)),
              ),
              const SizedBox(height: 30),
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
              SizedBox(height: 170)
            ],
          ),
        ),
      ),
    );
  }
}
