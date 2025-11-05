import 'package:classocean/screen/onboading_screen/welcome_screen.dart';
import 'package:classocean/screen/uihelper.dart';
import 'package:flutter/material.dart';

class OnboadingScreen4 extends StatelessWidget {
  const OnboadingScreen4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150),
            UiHelper.CustomImage(imgurl: "Group 3.png"),
            SizedBox(height: 50),
            UiHelper.CustomImage(imgurl: "Ready to Start_.png"),
            SizedBox(height: 20),
            Text(
              "Join of thousands of Schools",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 12),
            Text(
              "Experience the Future of school ",
              style: TextStyle(fontSize: 20),
            ),
            Text("management with ClassOcean", style: TextStyle(fontSize: 20)),
            SizedBox(height: 250,),
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
                Navigator.push(context, MaterialPageRoute(builder: (context)=>WelcomeScreen()));
              },
              child: Text(
                "GET STARTED ",
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
