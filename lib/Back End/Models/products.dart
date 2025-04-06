
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
}
 