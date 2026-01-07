import 'package:classocean/design/bottomnavscreen/bottom_nav_screen.dart';
import 'package:classocean/screen/onboading_screen/welcome_screen.dart';
import 'package:classocean/screen/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isLoding = false;
  Future<void> register() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoding = true);
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Registered Successfully")));
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNavScreen()),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Registration Failed")));
      } finally {
        setState(() => isLoding);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(width: 0),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.arrow_back,
                      size: 40,
                      color: Color(0xff3FBDF1),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  SizedBox(width: 8),
                  UiHelper.CustomText(
                    text: "Create your Account",
                    fontsize: 20,
                    color: Color(0xff5DCCFC),
                  ),
                ],
              ),
              Row(
                children: [
                  SizedBox(width: 8),
                  Text("Please fill in your details to create your "),
                ],
              ),
              Row(children: [SizedBox(width: 8), Text("account")]),

              SizedBox(height: _mediaQuery.size.height * 0.05),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Full Name",
                ),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: _mediaQuery.size.height * 0.04),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Email',
                ),

                validator: (value) => value!.isEmpty || !value.contains('@')
                    ? 'Enter a valid email'
                    : null,
              ),
              SizedBox(height: _mediaQuery.size.height * 0.04),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
                obscureText: true,
                validator: (value) => value!.length < 6
                    ? 'Password must be at least 6 characters'
                    : null,
              ),
              SizedBox(height: _mediaQuery.size.height * 0.04),
              TextFormField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Confirm Password",
                ),
                obscureText: true,
                validator: (value) => value != passwordController.text
                    ? 'Password do not match'
                    : null,
              ),
              SizedBox(height: _mediaQuery.size.height * 0.06),
              isLoding
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff5DCCFC),
                        shape: RoundedRectangleBorder(),
                        padding: EdgeInsets.only(left: 50, right: 50),
                      ),
                      onPressed: register,

                      child: Text(
                        "CREATE AN ACCOUNT",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
              Row(
                children: [
                  SizedBox(width: _mediaQuery.size.width * 0.2),
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Color(0xff625D5D)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Sign in",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  /*Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),*/
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
