import 'package:classocean/dashBoard/dashBoard_screen.dart';
import 'package:classocean/login/login_screen.dart';
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
          MaterialPageRoute(builder: (context) => DashboardScreen()),
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
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Row(
                children: [
                  SizedBox(width: 10),
                  Icon(Icons.arrow_back, color: Color(0xff3FBDF1)),
                ],
              ),
              SizedBox(height: 15),
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

              SizedBox(height: 50),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Full Name",
                ),
                validator: (value) => value!.isEmpty ? 'Enter your name' : null,
              ),
              SizedBox(height: 30),
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
              SizedBox(height: 30),
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
              SizedBox(height: 30),
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
              const SizedBox(height: 70),
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
                  SizedBox(width: 80),
                  Text(
                    "Already have an account?",
                    style: TextStyle(color: Color(0xff625D5D)),
                  ),
                  Text(
                    "Sign in",
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
