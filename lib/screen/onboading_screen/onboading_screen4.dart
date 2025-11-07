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
             Text("Ready to Start?",style: TextStyle(fontSize: 32,color: Color(0xff625D5D),fontWeight: FontWeight.bold),),
            SizedBox(height: 20),
            Text(
              "Join of thousands of Schools",
              style: TextStyle(fontSize: 20,color: Color(0xff625D5D)),
            ),
            SizedBox(height: 10),
            Text(
              "Experience the Future of school ",
              style: TextStyle(fontSize: 20,color: Color(0xff625D5D)),
            ),
            Text("management with ClassOcean", style: TextStyle(fontSize: 20,color: Color(0xff625D5D))),
            SizedBox(height: 220,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff5DCCFC),
                foregroundColor: Colors.white,
                elevation: 0,
                padding: EdgeInsets.only(left: 70,right: 70,bottom: 11,top: 11),

                shape: RoundedRectangleBorder(

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
