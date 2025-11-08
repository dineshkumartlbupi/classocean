import 'package:classocean/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: ListView(
        children: [
          Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Icon(
                  Icons.arrow_back,
                  size: 40,
                  color: Color(0xff5DCCFC),
                ),
              ),
            ],
          ),
          Column(
            children: [
              SizedBox(height: 200),
              SizedBox(
                height: _mediaQuery.size.height * 0.2,
                width: _mediaQuery.size.width* 0.95,
                child: TextFormField(

                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: "Email",


                    prefixIcon: Icon(Icons.email_outlined),

                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
