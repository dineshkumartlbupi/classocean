import 'package:classocean/dashBoard/dashBoard_screen.dart';
import 'package:classocean/login/forgot_password_screen.dart';
import 'package:classocean/screen/onboading_screen/welcome_screen.dart';
import 'package:classocean/screen/uihelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  bool _islogin = true;
  bool _isloading = false;

  Future<void> _submitAuthForm() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();
    if (email.isEmpty || password.isEmpty) {
      _showError("Please fill in all fields ");
      return;
    }
    setState(() => _isloading = true);

    try {
      UserCredential userCredential;
      if (_islogin) {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      }
      if (userCredential.user != null) {
        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => DashboardScreen()),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user not found') {
        _showError("No user found for that email");
      } else if (e.code == 'wrong password') {
        _showError("Wrong password. Please try again");
      } else if (e.code == 'email already in use ') {
        _showError("This email is already registered.");
      } else if (e.code == 'weak password') {
        _showError("Password should be at least 6 characters");
      } else {
        _showError("Authentication failed : ${e.message}");
      }
    } catch (e) {
      _showError("Something went wrong. Try again");
    }
    setState(() => _isloading = false);
  }

  void _showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    var _mediaQuery = MediaQuery.of(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: _mediaQuery.size.height * 0.02),
                  Row(
                    children: [
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
                          color: Color(0xff5DCCFC),
                          size: 40,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: _mediaQuery.size.width * 0.02),
                      UiHelper.CustomText(
                        text: "Welcome Back!",
                        fontsize: 20,
                        color: Color(0xff5DCCFC),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: _mediaQuery.size.width * 0.02),
                      Text(
                        "Please fill in email password to ",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff625D5D),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(width: _mediaQuery.size.width * 0.02),
                      Text(
                        "account",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xff625D5D),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: _mediaQuery.size.height * 0.05),

                  // Email Field
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                    },
                  ),

                  SizedBox(height: _mediaQuery.size.height * 0.04),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(
                      labelText: "password",
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) =>
                        value!.length < 6 ? 'Please enter Password' : null,
                  ),
                  Row(
                    children: [
                      SizedBox(width: _mediaQuery.size.width * 0.5),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Forgot Password",
                          style: TextStyle(color: Color(0xff625D5D)),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: _mediaQuery.size.height * 0.02),
                  _isloading
                      ? Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.only(left: 50, right: 50),
                            shape: RoundedRectangleBorder(),

                            backgroundColor: Color(0xff5DCCFC),
                          ),
                          onPressed: _submitAuthForm,

                          child: Text(
                            "Login",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  Row(
                    children: [
                      SizedBox(width: _mediaQuery.size.width * 0.2),
                      Text(
                        "Don't have an account?",
                        style: TextStyle(color: Color(0xff625D5D)),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          "Sign up",
                          style: TextStyle(
                            color: Color(0xff5DCCFC),
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
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
