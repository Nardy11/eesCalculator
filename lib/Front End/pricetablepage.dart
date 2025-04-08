import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ees_calculator/Back%20End/Models/products.dart';
import 'package:ees_calculator/Front%20End/priceenteringpage.dart';
import 'package:flutter/material.dart';

class PriceTablePage extends StatefulWidget {
  final double itemPrice;
  final double plasticPrice;
  final String itemname;
  final String username;

  const PriceTablePage({
    super.key,
    required this.itemPrice,
    required this.plasticPrice,
    required this.itemname,
    required this.username,
  });

  @override
  _PriceTablePageState createState() => _PriceTablePageState();
}

class _PriceTablePageState extends State<PriceTablePage> {
  List<Products> products = [];

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection('Products').get();
    List<Products> loaded = snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      return Products.fromMap(data, doc.id);
    }).toList();

    setState(() {
      products = loaded;
    });
  }

  double calculateMaterialWeight(Products p) {
    double density = p.materialType == "copper" ? 0.7:0.7; // g/cm³ edit
    return p.numberOfMeters * p.numberOfEnds * density * p.wireDiameter * p.wireDiameter;
  }

  TableRow buildProductRow(Products p, int index) {
    double materialWeight = calculateMaterialWeight(p);
    double materialCost = materialWeight * widget.itemPrice;
    double plasticCost = p.plasticWeight * widget.plasticPrice;
    double rawMaterialCost = materialCost + plasticCost;
    double manufacturingCost = materialWeight * p.twistingCostPerKg;
    double coilPrice = rawMaterialCost + manufacturingCost;
    double coilPriceInvoice = coilPrice * 1.14;

    return TableRow(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
      ),
      children: [
        _buildTableCell(coilPriceInvoice.toStringAsFixed(2)),
        _buildTableCell(coilPrice.toStringAsFixed(2)),
        _buildTableCell(manufacturingCost.toStringAsFixed(2)),
        _buildTableCell(rawMaterialCost.toStringAsFixed(2)),
        _buildTableCell(plasticCost.toStringAsFixed(2)),
        _buildTableCell(p.plasticWeight.toStringAsFixed(2)),
        _buildTableCell(p.coilWeight.toStringAsFixed(2)),
        _buildTableCell(materialCost.toStringAsFixed(2)),
        _buildTableCell(p.twistingCostPerKg.toStringAsFixed(2)),
        _buildTableCell(materialWeight.toStringAsFixed(2)),
        _buildTableCell(p.numberOfMeters.toString()),
        _buildTableCell(p.numberOfEnds.toString()),
        _buildTableCell(p.wireDiameter.toStringAsFixed(2)),
        _buildTableCell(p.productDescription),
        _buildTableCell(p.code),
      ],
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
                Image.asset("assets/logo.png", width: 300),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "سعر البلاستيك: ${widget.plasticPrice.toStringAsFixed(2)} جنيه",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "سعر ${widget.itemname}: ${widget.itemPrice.toStringAsFixed(2)} جنيه",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
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
                            decoration: BoxDecoration(color: Colors.white.withOpacity(0.8)),
                            children: [
                              _buildTableHeader('ثمن اللفة بالفاتورة'),
                              _buildTableHeader('ثمن اللفة'),
                              _buildTableHeader('مصنعية'),
                              _buildTableHeader('تكلفة الخامات'),
                              _buildTableHeader('تكلفة البلاستيك'),
                              _buildTableHeader('وزن البلاستيك'),
                              _buildTableHeader('وزن اللفة بالكيلو'),
                              _buildTableHeader('تكلفة ${widget.itemname}'),
                              _buildTableHeader('تكلفة الجدل للكيلو'),
                              _buildTableHeader('وزن ${widget.itemname} بالكيلو'),
                              _buildTableHeader('عدد الامتار'),
                              _buildTableHeader('عدد الاطراف'),
                              _buildTableHeader('قطر السلك'),
                              _buildTableHeader('وصف الصنف'),
                              _buildTableHeader('كود'),
                            ],
                          ),
                          ...products.asMap().entries.map((entry) => buildProductRow(entry.value, entry.key)).toList(),
                        ],
                      ),
                    ),
                  ),
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
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black),
        ),
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 14, color: Colors.black),
        ),
      ),
    );
  }
}
