import 'package:ees_calculator/Back%20End/Models/products.dart';
import 'package:ees_calculator/Back%20End/Controllers/product_controller.dart';
import 'package:ees_calculator/Front%20End/priceenteringpage.dart';
import 'package:flutter/material.dart';

class Productaddingpage extends StatefulWidget {
  final double itemPrice;
  final double plasticPrice;
  final String itemname;
  final String username;

  const Productaddingpage(
      {super.key,
      required this.itemPrice,
      required this.plasticPrice,
      required this.itemname,
      required this.username});

  @override
  _ProductaddingpageState createState() => _ProductaddingpageState();
}

class _ProductaddingpageState extends State<Productaddingpage> {
  List<List<TextEditingController>> controllers = List.generate(
      10, (_) => List.generate(15, (_) => TextEditingController()));

  double wireWeight = 0.0;

  void calculateWireWeight() {
    setState(() {
      try {
        // Ensure all required fields are filled and are valid numbers
        double numberOfMeters = double.parse(controllers[0][10].text.trim());
        int numberOfEnds = int.parse(controllers[0][11].text.trim());
        double wireDiameter = double.parse(controllers[0][12].text.trim());

        // Calculate wire weight
        wireWeight =
            numberOfMeters * numberOfEnds * 0.7 * wireDiameter * wireDiameter;
      } catch (e) {
        wireWeight =
            0.0; // Reset wireWeight in case of any error (invalid input)
      }
    });
  }

  void validateAndSubmit() async {
    bool allFieldsFilled = true;
    bool validNumbers = true;

    for (int j = 0; j < 15; j++) {
      String value = controllers[0][j].text.trim();
      if (value.isEmpty) {
        allFieldsFilled = false;
      } else if (j != 13 && double.tryParse(value) == null && j != 14) {
        validNumbers = false;
      }
    }

    if (!allFieldsFilled) {
      showSnackbar("يجب ملء جميع الحقول", Colors.red);
      return;
    }

    if (!validNumbers) {
      showSnackbar(
          "يجب إدخال أرقام فقط في جميع الحقول ماعدا وصف الصنف", Colors.red);
      return;
    }

    try {
      double numberOfMeters = double.parse(controllers[0][10].text.trim());
      int numberOfEnds = int.parse(controllers[0][11].text.trim());
      double wireDiameter = double.parse(controllers[0][12].text.trim());

      // Weight calculation
      double materialWeight =
          numberOfMeters * numberOfEnds * 0.7 * wireDiameter * wireDiameter;

      // Creating product object
      double twistingCostPerKg = double.parse(controllers[0][8].text.trim());
      double plasticWeight = double.parse(controllers[0][5].text.trim());

      double materialCost = materialWeight * widget.itemPrice;
      double plasticCost = plasticWeight * widget.plasticPrice;
      double rawMaterialCost = materialCost + plasticCost;
      double manufacturingCost = materialWeight * twistingCostPerKg;
      double coilPrice = rawMaterialCost + manufacturingCost;
      double coilPriceInvoice = coilPrice * 1.14;

      Products newProduct = Products(
        id: controllers[0][14].text.trim(),
        code: controllers[0][14].text.trim(),
        productDescription: controllers[0][13].text.trim(),
        numberOfMeters: numberOfMeters,
        numberOfEnds: numberOfEnds,
        wireDiameter: wireDiameter,
        coilWeight: double.parse(controllers[0][6].text.trim()),
        plasticWeight: plasticWeight,
        twistingCostPerKg: twistingCostPerKg,
        materialType: widget.itemname,
        materialWeight: materialWeight,
        materialCost: materialCost,
        plasticCost: plasticCost,
        rawMaterialCost: rawMaterialCost,
        manufacturingCost: manufacturingCost,
        coilPrice: coilPrice,
        coilPriceInvoice: coilPriceInvoice,
      );

      await ProductService.createProduct(newProduct);
      showSnackbar("تم اضافه المنتج بنجاح", Colors.green);

      // Clear all the fields after submission
      controllers
          .forEach((list) => list.forEach((controller) => controller.clear()));

      // Optionally, reset the wire weight after clearing the fields
      setState(() {
        wireWeight = 0.0;
      });
    } catch (e) {
      showSnackbar("حدث خطأ أثناء الحفظ: $e", Colors.red);
    }
  }

  void showSnackbar(String message, Color color) {
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
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => PriceEnteringPage(
                      selectedMaterial: widget.itemname,
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
                const SizedBox(height: 30),
                Image.asset(
                  "assets/logo.png",
                  width: 300,
                ),
                const SizedBox(height: 50),
                _buildHeaderWithTextBorder(
                    "برجاء ادخال مواصفات المنتج في الاماكن المخصصه لها"),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildHeaderWithTextBorder(
                        "سعر البلاستيك: ${widget.plasticPrice.toStringAsFixed(2)} جنيه"),
                    const SizedBox(width: 20),
                    _buildHeaderWithTextBorder(
                        "سعر ${widget.itemname}: ${widget.itemPrice.toStringAsFixed(2)} جنيه"),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: SingleChildScrollView(
                      child: Table(
                        border: TableBorder.all(color: Colors.white, width: 2),
                        columnWidths: const {
                          0: FixedColumnWidth(120),
                          1: FixedColumnWidth(68),
                          2: FixedColumnWidth(80),
                          3: FixedColumnWidth(90),
                          4: FixedColumnWidth(90),
                          5: FixedColumnWidth(90),
                          6: FixedColumnWidth(90),
                          7: FixedColumnWidth(100),
                          8: FixedColumnWidth(120),
                          9: FixedColumnWidth(85),
                          10: FixedColumnWidth(68),
                          11: FixedColumnWidth(74),
                          12: FixedColumnWidth(68),
                          13: FixedColumnWidth(80 * 4),
                          14: FixedColumnWidth(50),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8)),
                            children: [
                              for (var header in [
                                'ثمن اللفة بالفاتورة',
                                'ثمن اللفة',
                                'مصنعية',
                                'تكلفة الخامات',
                                'تكلفة البلاستيك',
                                'وزن البلاستيك',
                                'وزن اللفة بالكيلو',
                                'تكلفة ${widget.itemname}',
                                'تكلفة الجدل للكيلو',
                                'وزن ${widget.itemname} بالكيلو',
                                'عدد الامتار',
                                'عدد الاطراف',
                                'قطر السلك',
                                'وصف الصنف',
                                'كود'
                              ])
                                _buildTableHeader(header),
                            ],
                          ),
                          TableRow(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5)),
                            children: [
                              for (int j = 0; j < 15; j++)
                                _buildTableField(0, j),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  "وزن السلك: ${wireWeight.toStringAsFixed(2)} كيلو",
                  style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: validateAndSubmit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text("اضف منتج جديد",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF273156))),
                ),
                const SizedBox(height: 70),
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

  Widget _buildTableField(int row, int col) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextField(
        controller: controllers[row][col],
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, color: Colors.black),
        decoration: const InputDecoration(border: OutlineInputBorder()),
        onChanged: (value) => calculateWireWeight(),
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
                  offset: Offset(3.5, 3.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
