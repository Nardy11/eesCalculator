import 'package:ees_calculator/Front%20End/functionselectionpage.dart';
import 'package:ees_calculator/Front%20End/pricetablepage.dart';
import 'package:ees_calculator/Front%20End/productaddingpage.dart';
import 'package:flutter/material.dart';
import 'dart:ui'; // For BackdropFilter

class PriceEnteringPage extends StatefulWidget {
  final String selectedMaterial;
  final String username;

  const PriceEnteringPage(
      {super.key, required this.selectedMaterial, required this.username});

  @override
  _PriceEnteringPageState createState() => _PriceEnteringPageState();
}

class _PriceEnteringPageState extends State<PriceEnteringPage> {
  final TextEditingController itemPriceController = TextEditingController();
  final TextEditingController plasticPriceController = TextEditingController();
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
                builder: (context) => FunctionSelectionPage(
                      selectedMaterial: widget.selectedMaterial,
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
                    // Logo at the top center with larger size
                    Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        "assets/logo.png", // Ensure this asset is in your project
                        width:
                            isSmallScreen ? size.width * 0.7 : size.width * 0.4,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Display the selected material in the header text
                    _buildHeaderWithTextBorder(
                        ' ادخل سعر ${widget.selectedMaterial} '),

                    // Item price input field
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: itemPriceController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.8),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              hintText: '10 EGP/Kilo',
                              errorStyle: const TextStyle(
                                fontSize: 20, // Customize error text size
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Plastic price header
                    _buildHeaderWithTextBorder('ادخل سعر البلاستيك'),

                    // Plastic price input field
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: plasticPriceController,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.8),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                hintText: '10 EGP/Kilo'),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 'احسب' button
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PriceTablePage(
                                      username: widget.username,
                                      plasticPrice: double.tryParse(
                                              plasticPriceController.text) ??
                                          0.0,
                                      itemPrice: double.tryParse(
                                              itemPriceController.text) ??
                                          0.0,
                                      itemname: widget.selectedMaterial,
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
                          'احسب',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF273156)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // 'صمم منتج جديد' button
                    SizedBox(
                      width:
                          isSmallScreen ? size.width * 0.85 : size.width * 0.5,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Productaddingpage(
                                      plasticPrice: double.tryParse(
                                              plasticPriceController.text) ??
                                          0.0,
                                      username: widget.username,
                                      itemname: widget.selectedMaterial,
                                      itemPrice: double.tryParse(
                                              itemPriceController.text) ??
                                          0.0,
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
                          'صمم منتج جديد',
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF273156)),
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
}
