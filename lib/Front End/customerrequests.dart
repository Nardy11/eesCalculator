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

  // Default densities, these should be updated based on your backend data
  final double copperDensity = 0.7; // Example density (in g/cm³)
  final double aluminumDensity = 2.70; // Example density (in g/cm³)
  final double plasticDensity = 1.20; // Example density (in g/cm³)

  double plasticWeight = 0.0;
  double aluminumWeight = 0.0;
  double copperWeight = 0.0;

  double plasticCost = 0.0;
  double aluminumCost = 0.0;
  double copperCost = 0.0;

  double totalOrderCost = 0.0;

  void calculateWireWeight() {
    setState(() {
      // Reset totals
      plasticWeight = 0.0;
      copperWeight = 0.0;
      aluminumWeight = 0.0;

      plasticCost = 0.0;
      copperCost = 0.0;
      aluminumCost = 0.0;

      totalOrderCost = 0.0;

      for (var row in controllers) {
        // Parse quantity
        double quantity = double.tryParse(row[9].text) ?? 0.0;

        // Parse user-entered weights per unit
        double plasticPerUnit = double.tryParse(row[2].text) ?? 0.0;
        double copperPerUnit = double.tryParse(row[5].text) ?? 0.0;
        double aluminumPerUnit = double.tryParse(row[8].text) ?? 0.0;

        // Total weight for each material (per row)
        double totalPlasticWeight = plasticPerUnit * quantity;
        double totalCopperWeight = copperPerUnit * quantity;
        double totalAluminumWeight = aluminumPerUnit * quantity;

        // Costs per material (per row)
        double plasticRowCost = totalPlasticWeight * widget.plasticPrice;
        double copperRowCost = totalCopperWeight * widget.copperPrice;
        double aluminumRowCost = totalAluminumWeight * widget.aluminumPrice;

        // Update row fields
        row[0].text = plasticRowCost.toStringAsFixed(2); // plastic cost
        row[1].text = plasticDensity.toString(); // plastic density (constant)

        row[3].text = copperRowCost.toStringAsFixed(2); // copper cost
        row[4].text = copperDensity.toString(); // copper density (constant)

        row[6].text = aluminumRowCost.toStringAsFixed(2); // aluminum cost
        row[7].text = aluminumDensity.toString(); // aluminum density (constant)

        // Update totals
        plasticWeight += totalPlasticWeight;
        copperWeight += totalCopperWeight;
        aluminumWeight += totalAluminumWeight;

        plasticCost += plasticRowCost;
        copperCost += copperRowCost;
        aluminumCost += aluminumRowCost;
      }

      totalOrderCost = plasticCost + copperCost + aluminumCost;
    });
  }

  void addRow() {
    setState(() {
      controllers.add(List.generate(12, (_) => TextEditingController()));
    });
    showSnackbar("تم اضافه صف جديد بنجاح", Colors.green, 500);
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
      showSnackbar("يجب ملء جميع الحقول", Colors.red, 1000);
    } else if (!validNumbers) {
      showSnackbar("يجب إدخال أرقام فقط في جميع الحقول ماعدا وصف الصنف",
          Colors.red, 1000);
    } else {
      showSnackbar("تم اضافه المنتج بنجاح", Colors.green, 1000);
    }
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

  @override
  Widget build(BuildContext context) {
    calculateWireWeight();

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
          Positioned.fill(
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(
                  sigmaX: 5, sigmaY: 2), // Adjust blur strength
              child: Image.asset(
                "assets/background.png",
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
                    filter: ImageFilter.blur(sigmaX: 0.4, sigmaY: 0.4),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildMaterialInfoColumn(
                              "وزن البلاستيك", plasticWeight),
                          _buildMaterialInfoColumn(
                              "وزن الومنيوم", aluminumWeight),
                          _buildMaterialInfoColumn("وزن النحاس", copperWeight),
                          _buildMaterialInfoColumn(
                              "تكلفه البلاستيك", plasticCost),
                          _buildMaterialInfoColumn(
                              "تكلفه الومنيوم", aluminumCost),
                          _buildMaterialInfoColumn("تكلفه النحاس", copperCost),
                          _buildMaterialInfoColumn(
                              "تكلفه الاوردر", totalOrderCost),
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
                          1: FixedColumnWidth(90),
                          2: FixedColumnWidth(90),
                          3: FixedColumnWidth(80),
                          4: FixedColumnWidth(90),
                          5: FixedColumnWidth(90),
                          6: FixedColumnWidth(95),
                          7: FixedColumnWidth(90),
                          8: FixedColumnWidth(95),
                          9: FixedColumnWidth(80),
                          10: FixedColumnWidth(80 * 4),
                          11: FixedColumnWidth(50),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8)),
                            children: [
                              for (var header in [
                                'تكلفة البلاستيك',
                                'كثافه البلاستيك',
                                'وزن البلاستيك',
                                'تكلفة النحاس',
                                'كثافه النحاس',
                                'وزن النحاس',
                                'تكلفة الالومينيوم',
                                'كثافه الومنيوم',
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

  Widget _buildMaterialInfoColumn(String title, dynamic value) {
    return Column(
      children: [
        _buildHeaderWithTextBorder(title, 20),
        _buildHeaderWithTextBorder(value.toStringAsFixed(2), 17),
      ],
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
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          enabled: col != 1 &&
              col != 4 &&
              col != 7 &&
              col != 0 &&
              col != 3 &&
              col != 6, // Disable density fields
        ),
        onChanged: (value) => calculateWireWeight(),
      ),
    );
  }

// Helper method to create headers with border directly on the text
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
