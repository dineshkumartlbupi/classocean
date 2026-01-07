import 'package:classocean/screen/onboading_screen/onboarding_screen4.dart';
import 'package:classocean/screen/uihelper.dart';
import 'package:flutter/material.dart';

class OnboardingScreen3 extends StatelessWidget {
  const OnboardingScreen3({super.key});

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            SizedBox(height: _mediaQuery.size.height * 0.2),
            UiHelper.CustomImage(imgurl: "Group 3.png"),
            SizedBox(height: _mediaQuery.size.height * 0.045),
            Text(
              "Student Management ",
              style: TextStyle(fontSize: 30, color: Color(0xff625D5D)),
            ),
            SizedBox(height: _mediaQuery.size.height * 0.025),
            Text(
              "Organize Efficiently",
              style: TextStyle(fontSize: 20, color: Color(0xff625D5D)),
            ),
            SizedBox(height: _mediaQuery.size.height * 0.015),
            Text(
              " Manage students records,",
              style: TextStyle(fontSize: 20, color: Color(0xff625D5D)),
            ),
            Text(
              "enrollment, and academic progress ",
              style: TextStyle(fontSize: 17, color: Color(0xff625D5D)),
            ),
            Text(
              "all in one place",
              style: TextStyle(color: Color(0xff625D5D), fontSize: 17),
            ),
            SizedBox(height: _mediaQuery.size.height * 0.25),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5DCCFC),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.only(
                  left: 120,
                  right: 120,
                  bottom: 11,
                  top: 11,
                ),

                shape: RoundedRectangleBorder(),
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => OnboadingScreen4()),
                );
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
