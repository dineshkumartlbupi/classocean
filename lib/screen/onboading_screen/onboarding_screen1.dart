import 'dart:async';

import 'package:classocean/dashBoard/dashBoard_screen.dart';
import 'package:classocean/login/login_screen.dart';
import 'package:classocean/screen/onboading_screen/onboarding_screen2.dart';
import 'package:classocean/screen/uihelper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen1 extends StatefulWidget {
  const OnboardingScreen1({super.key});
  State<OnboardingScreen1> createState() => _OnboardingScreen1State();
}

class _OnboardingScreen1State extends State<OnboardingScreen1> {

  //static const String KEYLOGIN = "login";
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 600),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> OnboardingScreen2()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff5DCCFC),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UiHelper.CustomImage(imgurl: "Group 5.png"),
            SizedBox(height: 20),
            UiHelper.CustomImage(imgurl: "Text.png"),
          ],
        ),
      ),
    );
  }
  /*void whereToGo() async{
    var sharedPref = await SharedPreferences.getInstance();
     var isLoggedIn = sharedPref.getBool(KEYLOGIN);
    Timer(Duration(seconds: 2),(){
      if(isLoggedIn!=null){
        if(isLoggedIn){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DashboardScreen()));
        } else{
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
        }
      } else {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
      }
     // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
    });
  }*/

 }




