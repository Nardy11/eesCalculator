import 'package:ees_calculator/Back%20End/Controllers/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:ees_calculator/Front%20End/selectionpage.dart';
import 'dart:ui'; // For BackdropFilter

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/logo.png",
                        width:
                            isSmallScreen ? size.width * 0.7 : size.width * 0.4,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Email Field
                    _buildHeaderWithTextBorder('ادخل البريد الإلكتروني'),
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: TextFormField(
                        controller: emailController,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'example@email.com',
                          errorStyle: const TextStyle(
                            fontSize: 20,
                            color: Colors.red,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ادخل البريد الإلكتروني';
                          } else if (!_isValidEmail(value)) {
                            return 'البريد الإلكتروني غير صالح';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Password Field
                    _buildHeaderWithTextBorder('ادخل كلمة السر'),
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: TextFormField(
                        controller: passwordController,
                        textAlign: TextAlign.center,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.8),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          hintText: 'ادخل كلمة السر',
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                           errorStyle:const TextStyle(
                            fontSize: 20, 
                            color: Colors.red,

                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ادخل كلمة السر';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Login Button
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            String email = emailController.text;
                            String password = passwordController.text;
                            try {
                              var user = await AuthService()
                                  .signInWithEmailPassword(
                                      context, email, password);

                              if (user != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        SelectionPage(username: user.name),
                                  ),
                                );
                              } else {
                                showSnackbar(
                                    'البريد الإلكتروني أو كلمة السر غير صحيحة',
                                    Colors.red,
                                    1000);
                              }
                            } catch (e) {
                              // Handle any errors from Firebase Auth (incorrect email/password)
                              showSnackbar(
                                  'حدث خطأ أثناء تسجيل الدخول. حاول مرة أخرى.',
                                  Colors.red,
                                  1000);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white.withOpacity(0.8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          elevation: 20,
                        ),
                        child: const Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF273156),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Header Text with Shadow Effect
  Widget _buildHeaderWithTextBorder(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 25,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              blurRadius: 5.0,
              color: Colors.black.withOpacity(0.5),
              offset: const Offset(2.0, 2.0),
            ),
          ],
        ),
      ),
    );
  }

  void showSnackbar(String message, Color color, int duration) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        duration: Duration(milliseconds: duration),
      ),
    );
  }
}
