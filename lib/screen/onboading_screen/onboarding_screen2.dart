import 'package:classocean/screen/onboading_screen/onboarding_screen3.dart';
import 'package:classocean/screen/uihelper.dart';
import 'package:flutter/material.dart';

class OnboardingScreen2 extends StatefulWidget {
  const OnboardingScreen2({super.key});

  @override
  State<OnboardingScreen2> createState() => _OnboardingScreen2State();
}

class _OnboardingScreen2State extends State<OnboardingScreen2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            UiHelper.CustomImage(imgurl: "Group 3.png"),
            SizedBox(height: 30),
            UiHelper.CustomImage(imgurl: "Smart Attendance.png"),
            SizedBox(height: 15),
            Text("Track with Ease", style: TextStyle(fontSize: 15)),
            Text("Mark attendance quickly and generate"),
            Text("automated reports from better insights"),
            SizedBox(height: 300,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.symmetric(horizontal: 32, vertical: 14),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen3()));
              },
              child: Text(
                "NEXT",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
