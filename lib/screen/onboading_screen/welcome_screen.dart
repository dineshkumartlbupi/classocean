import 'package:classocean/dashBoard/dashBoard_screen.dart';
import 'package:classocean/login/login_screen.dart';
import 'package:classocean/registration/registration_screen.dart';
import 'package:classocean/screen/uihelper.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      backgroundColor: Colors.teal,
      body: ListView(
        children: [
          Column(
            children: [
              SizedBox(height: _mediaQuery.size.height * 0.5),
              UiHelper.CustomImage(imgurl: "Welcome to Ocean classes.png"),
              SizedBox(height: _mediaQuery.size.height * 0.01),
              Text(
                "Best educators App",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: _mediaQuery.size.height * 0.09),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegistrationScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5DCCFC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                    bottom: 10,
                    top: 10,
                  ),
                ),
                child: Text(
                  "CREATE AN ACCOUNT",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff5DCCFC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: 0,
                  padding: EdgeInsets.only(
                    left: 120,
                    bottom: 10,
                    right: 120,
                    top: 10,
                  ),
                ),
                child: Text(
                  "LOGIN",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
              SizedBox(height: _mediaQuery.size.height * 0.01),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => DashboardScreen()),
                  );
                },
                child: Text(
                  "Continue as Guest",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
