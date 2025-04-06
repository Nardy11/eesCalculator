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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "سعر البلاستيك: ${widget.plasticPrice.toStringAsFixed(2)} جنيه",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Text(
                      "سعر ${widget.itemname}: ${widget.itemPrice.toStringAsFixed(2)} جنيه",
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
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
                          0: FixedColumnWidth(68),
                          1: FixedColumnWidth(68),
                          2: FixedColumnWidth(68),
                          3: FixedColumnWidth(68),
                          4: FixedColumnWidth(68),
                          5: FixedColumnWidth(68),
                          6: FixedColumnWidth(68),
                          7: FixedColumnWidth(68),
                          8: FixedColumnWidth(68),
                          9: FixedColumnWidth(68),
                          10: FixedColumnWidth(68),
                          11: FixedColumnWidth(68),
                          12: FixedColumnWidth(68),
                          13: FixedColumnWidth(80*4),
                          14: FixedColumnWidth(50),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.8)),
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
                              _buildTableHeader(
                                  'وزن ${widget.itemname} بالكيلو'),
                              _buildTableHeader('عدد الامتار'),
                              _buildTableHeader('عدد الاطراف'),
                              _buildTableHeader('قطر السلك'),
                              _buildTableHeader('وصف الصنف'),
                              _buildTableHeader('كود'),
                            ],
                          ),
                          ...generateTableRows(15),
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

  List<TableRow> generateTableRows(int numRows) {
    return List.generate(numRows, (rowIndex) {
      return TableRow(
        decoration: BoxDecoration(
          color: rowIndex % 2 == 0
              ? Colors.grey.withOpacity(0.2)
              : Colors.white.withOpacity(0.8),
        ),
        children: List.generate(
          15,
          (colIndex) => _buildTableCell('${colIndex + rowIndex * 5}'),
        ),
      );
    });
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

  Widget _buildTableCell(String text) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
