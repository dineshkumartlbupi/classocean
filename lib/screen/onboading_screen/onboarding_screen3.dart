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
            SizedBox(height: 140,),
            UiHelper.CustomImage(imgurl: "Group 3.png"),
            SizedBox(height: 45 ,),
           Text("Student Management ",style: TextStyle(fontSize: 30,color: Color(0xff625D5D)),),
            SizedBox(height: 16,),
            Text("Organize Efficiently",style: TextStyle(fontSize: 20,color: Color(0xff625D5D)),),
            SizedBox(height: 10,),
            Text(" Manage students records,",style: TextStyle(fontSize: 20,color: Color(0xff625D5D)),),
            Text("enrollment, and academic progress ",style: TextStyle(fontSize: 17,color: Color(0xff625D5D)),),
           Text("all in one place",style: TextStyle(color: Color(0xff625D5D),fontSize: 17),),
            SizedBox(height: 210,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5DCCFC),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.only(left: 120,right: 120,bottom: 11,top: 11),

                shape: RoundedRectangleBorder(

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
