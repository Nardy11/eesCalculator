import 'dart:ui';

import 'package:ees_calculator/Front%20End/pricesenteringpage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomerRequestpage extends StatefulWidget {
  final double copperPrice;
  final double plasticPrice;
  final double aluminumPrice;
  final String username;
  final String selectedMaterial;
  const CustomerRequestpage(
      {super.key,
      required this.copperPrice,
      required this.plasticPrice,
      required this.aluminumPrice,
      required this.username,
      required this.selectedMaterial});

  @override
  _CustomerRequestpageState createState() => _CustomerRequestpageState();
}

class _CustomerRequestpageState extends State<CustomerRequestpage> {
  List<List<TextEditingController>> controllers = List.generate(
      10, (_) => List.generate(12, (_) => TextEditingController()));

  double wireWeight = 0.0;
  double plasticWeight = 100.0; // example values
  double aluminumWeight = 50.0; // example values
  double copperWeight = 75.0; // example values

  double plasticCost = 0.0; // Calculated based on plastic price
  double aluminumCost = 0.0; // Calculated based on aluminum price
  double copperCost = 0.0; // Calculated based on copper price

  void calculateWireWeight() {
    setState(() {
      // Example calculations (these can be changed based on your logic)
      plasticCost = plasticWeight * widget.plasticPrice;
      aluminumCost = aluminumWeight * widget.aluminumPrice;
      copperCost = copperWeight * widget.copperPrice;
    });
  }

  void addRow() {
    setState(() {
      controllers.add(List.generate(12, (_) => TextEditingController()));
    });
    showSnackbar("تم اضافه صف جديد بنجاح", Colors.green,500);
  }

  void validateAndSubmit() {
    bool allFieldsFilled = true;
    bool validNumbers = true;

    for (var row in controllers) {
      for (int j = 0; j < 12; j++) {
        String value = row[j].text.trim();
        if (value.isEmpty) {
          allFieldsFilled = false;
        } else if (j != 10 && double.tryParse(value) == null) {
          validNumbers = false;
        }
      }
    }

    if (!allFieldsFilled) {
      showSnackbar("يجب ملء جميع الحقول", Colors.red,1000);
    } else if (!validNumbers) {
      showSnackbar(
          "يجب إدخال أرقام فقط في جميع الحقول ماعدا وصف الصنف", Colors.red,1000);
    } else {
      showSnackbar("تم اضافه المنتج بنجاح", Colors.green,1000);
    }
  }

  void showSnackbar(String message, Color color,int duration) {
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
        duration:Duration(milliseconds: duration),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    calculateWireWeight(); // Calculate when the page is built

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PricesEnteringPage(
                      selectedMaterial: widget.selectedMaterial,
                      username: widget.username,
                    )),
          ),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 100),
                _buildHeaderWithTextBorder(
                    "برجاء ادخال مواصفات المنتج في الاماكن المخصصه لها", 25),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                        sigmaX: 0.4,
                        sigmaY: 0.4), // Adjust the blur level as needed
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              _buildHeaderWithTextBorder("وزن البلاستيك", 15),
                              _buildHeaderWithTextBorder(
                                  plasticWeight.toStringAsFixed(2), 12),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              _buildHeaderWithTextBorder(":وزن الومنيوم", 15),
                              _buildHeaderWithTextBorder(
                                  aluminumWeight.toStringAsFixed(2), 12),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              _buildHeaderWithTextBorder(":وزن النحاس", 15),
                              _buildHeaderWithTextBorder(
                                  copperWeight.toStringAsFixed(2), 12),
                            ],
                          ),
                          Column(
                            children: [
                              _buildHeaderWithTextBorder(
                                  ":تكلفه البلاستيك", 15),
                              _buildHeaderWithTextBorder(
                                  plasticCost.toStringAsFixed(2), 12),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              _buildHeaderWithTextBorder(":تكلفه الومنيوم", 15),
                              _buildHeaderWithTextBorder(
                                  aluminumCost.toStringAsFixed(2), 12),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              _buildHeaderWithTextBorder(":تكلفه النحاس", 15),
                              _buildHeaderWithTextBorder(
                                  copperCost.toStringAsFixed(2), 12),
                            ],
                          ),
                          const SizedBox(width: 20),
                          Column(
                            children: [
                              _buildHeaderWithTextBorder(":تكلفه الاوردر", 15),
                              _buildHeaderWithTextBorder(
                                  copperCost.toStringAsFixed(2), 12),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.white, width: 2),
                        columnWidths: const {
                          0: FixedColumnWidth(90),
                          1: FixedColumnWidth(80),
                          2: FixedColumnWidth(80),
                          3: FixedColumnWidth(80),
                          4: FixedColumnWidth(90),
                          5: FixedColumnWidth(90),
                          6: FixedColumnWidth(90),
                          7: FixedColumnWidth(90),
                          8: FixedColumnWidth(90),
                          9: FixedColumnWidth(80),
                          10: FixedColumnWidth(80*4),
                          11: FixedColumnWidth(50),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8)),
                            children: [
                              for (var header in [
                                'تكلفة البلاستيك',
                                'كافه البلاستيك',
                                'وزن البلاستيك',
                                'تكلفة النحاس',
                                'كثافه النحاس',
                                'وزن النحاس',
                                'تكلفة الالومينيوم',
                                'كثافه الالومينيوم',
                                'وزن الالومينيوم',
                                'الكميه',
                                'وصف الصنف',
                                'كود'
                              ])
                                _buildTableHeader(header),
                            ],
                          ),
                          for (var i = 0; i < controllers.length; i++)
                            TableRow(
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.5)),
                              children: [
                                for (var j = 0; j < 12; j++)
                                  _buildTableField(controllers[i][j], j),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: addRow,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("اضافة صف جديد",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF273156))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderWithTextBorder(String text, double size) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: size,
              color: Colors.white,
              fontWeight: FontWeight.bold,
              shadows: [
                Shadow(
                  blurRadius: 5.0,
                  color: Colors.black.withOpacity(0.5),
                  offset: Offset(3.5, 3.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableHeader(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _buildTableField(TextEditingController controller, int col) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: const InputDecoration(border: OutlineInputBorder()),
        onChanged: (value) => calculateWireWeight(),
      ),
    );
  }
}
