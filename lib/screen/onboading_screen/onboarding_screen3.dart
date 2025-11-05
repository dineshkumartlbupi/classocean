import 'package:classocean/screen/onboading_screen/onboading_screen4.dart';
import 'package:classocean/screen/uihelper.dart';
import 'package:flutter/material.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 150,),
            UiHelper.CustomImage(imgurl: "Group 3.png"),
            SizedBox(height: 50 ,),
            UiHelper.CustomImage(imgurl: "Student Management.png"),
            SizedBox(height: 20,),
            UiHelper.CustomImage(imgurl: "Organize Efficiently.png"),
            SizedBox(height: 10,),
            Text("Manage student records,"),
            Text("enrollment, and academic progress all iin "),
            Text("one place"),
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboadingScreen4()));
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
