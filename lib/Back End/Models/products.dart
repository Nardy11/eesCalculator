
class Products {
   String id;
   String code;
   String productDescription;
   double wireDiameter;
   int numberOfEnds;
   double numberOfMeters;
   double materialWeight; // Dynamic weight (copper or aluminum)
   double twistingCostPerKg;
   double materialCost; // Dynamic cost (copper or aluminum)
   double coilWeight;
   double plasticWeight;
   double plasticCost;
   double rawMaterialCost;
   double manufacturingCost;
   double coilPrice;
   double coilPriceInvoice;
   String materialType; // "copper" or "aluminum"

  Products({
    required this.id,
    required this.code,
    required this.productDescription,
    required this.wireDiameter,
    required this.numberOfEnds,
    required this.numberOfMeters,
    required this.twistingCostPerKg,
    required this.coilWeight,
    required this.plasticWeight,
    required this.plasticCost,
    required this.rawMaterialCost,
    required this.manufacturingCost,
    required this.coilPrice,
    required this.coilPriceInvoice,
    required this.materialType, // Specify the material type
    required this.materialWeight, // The weight will depend on the material type
    required this.materialCost,   // The cost will also depend on the material type
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'productDescription': productDescription,
      'wireDiameter': wireDiameter,
      'numberOfEnds': numberOfEnds,
      'numberOfMeters': numberOfMeters,
      'materialWeight': materialWeight,
      'twistingCostPerKg': twistingCostPerKg,
      'materialCost': materialCost,
      'coilWeight': coilWeight,
      'plasticWeight': plasticWeight,
      'plasticCost': plasticCost,
      'rawMaterialCost': rawMaterialCost,
      'manufacturingCost': manufacturingCost,
      'coilPrice': coilPrice,
      'coilPriceInvoice': coilPriceInvoice,
      'materialType': materialType,
    };
  }
  
  // Method to update the material type (and adjust the cost and weight)
  void updateMaterial(String newMaterialType, double newMaterialWeight, double newMaterialCost) {
    materialType = newMaterialType;
    materialWeight = newMaterialWeight;
    materialCost = newMaterialCost;
  }

  factory Products.fromMap(Map<String, dynamic> data, String documentId) {
    return Products(
      id: documentId,
      productDescription: data['productDescription'] ?? '',
      code: data['code'] ?? '',
      numberOfEnds: data['numberOfEnds'] ?? 0,
      numberOfMeters: (data['numberOfMeters'] ?? 0).toDouble(),
      wireDiameter: (data['wireDiameter'] ?? 0).toDouble(),
      coilWeight: (data['coilWeight'] ?? 0).toDouble(),
      plasticWeight: (data['plasticWeight'] ?? 0).toDouble(),
      twistingCostPerKg: (data['twistingCostPerKg'] ?? 0).toDouble(),
      materialType: data['materialType'] ?? 'copper',
      plasticCost: data['plasticCost']??0,
      rawMaterialCost: data['rawMaterialCost']??0,
      manufacturingCost: data['manufacturingCost']??0,
      coilPrice: data['coilPrice']??0,
      coilPriceInvoice: data['coilPriceInvoice']??0,
      materialCost: data['materialCost']??0,
      materialWeight: data['materialWeight']??0
    );
  }
}
 