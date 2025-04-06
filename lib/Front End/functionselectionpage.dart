import 'package:ees_calculator/Front%20End/priceenteringpage.dart';
import 'package:ees_calculator/Front%20End/pricesenteringpage.dart';
import 'package:ees_calculator/Front%20End/selectionpage.dart';
import 'package:flutter/material.dart';
import 'dart:ui'; // For BackdropFilter

class FunctionSelectionPage extends StatefulWidget {
  final String username;
  final String selectedMaterial;

  const FunctionSelectionPage(
      {super.key, required this.selectedMaterial, required this.username});

  @override
  _FunctionSelectionPageState createState() => _FunctionSelectionPageState();
}

class _FunctionSelectionPageState extends State<FunctionSelectionPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isSmallScreen = size.width < 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent, // AppBar background transparent
        elevation: 0, // Remove shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white), // Back arrow
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SelectionPage(
                      username: widget.username,
                    )),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Background Image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    "assets/background.png"), // Ensure this asset is in your project
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
                    // Logo at the top center with larger size
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/logo.png", // Ensure this asset is in your project
                        width:
                            isSmallScreen ? size.width * 0.7 : size.width * 0.4,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Greeting Message under the logo
                    _buildHeaderWithTextBorder('مرحبا'),
                    _buildHeaderWithTextBorder('كيف يمكنني مساعدتك اليوم؟'),

                    const SizedBox(height: 40),

                    // Button for "عرض/اضافه منتجات"
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PriceEnteringPage(
                                      selectedMaterial: widget.selectedMaterial,
                                      username: widget.username,
                                    )),
                          );
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
                          'عرض/اضافه منتجات',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF273156)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Button for "طلبات العميل "
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PricesEnteringPage(
                                      selectedMaterial: widget.selectedMaterial,
                                      username: widget.username,
                                    )),
                          );
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
                          'طلبات العميل',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF273156)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Helper method to create headers with border directly on the text
Widget _buildHeaderWithTextBorder(String text) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    child: Stack(
      alignment: Alignment.center,
      children: [
        // Text with border
        Text(
          text,
          style: TextStyle(
            fontSize: 25,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            shadows: [
              Shadow(
                blurRadius: 5.0,
                color: Colors.black.withOpacity(0.5),
                offset: Offset(2.0, 2.0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
