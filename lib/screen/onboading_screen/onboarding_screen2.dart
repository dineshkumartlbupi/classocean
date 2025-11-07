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
            UiHelper.CustomText(text: "Track with Ease", fontsize: 18,fontfamily: "bold",fontweight: FontWeight.bold,color: Color(0xff625D5D)),
            Text("Mark attendance quickly and generate",style: TextStyle(fontSize: 18,color: Color(0xff625D5D),fontWeight: FontWeight.bold),),
            Text("automated reports from better insights",style: TextStyle(fontSize: 18,color: Color(0xff625D5D)),),
            SizedBox(height: 240,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5DCCFC),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.only(left: 120,right: 120,top: 13,bottom: 13),

                shape: RoundedRectangleBorder(

                ),
              ),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnboardingScreen3()));
              },
              child: Text(
                "NEXT",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
