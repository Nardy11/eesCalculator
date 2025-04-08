import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ees_calculator/Back%20End/Models/products.dart';

class ProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionName = 'Products';

  // Add a new product to Firestore
  static Future<void> createProduct(Products product) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final String collectionName = 'Products';
    try {
      await _firestore
          .collection(collectionName)
          .doc(product.id)
          .set(product.toMap());
    } catch (e) {
      print("Error creating product: $e");
      rethrow;
    }
  }

  // Retrieve a product by ID
  Future<Products?> getProductById(String productId) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection(collectionName).doc(productId).get();
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Products(
          id: doc.id,
          code: data['code'],
          productDescription: data['productDescription'],
          wireDiameter: data['wireDiameter'],
          numberOfEnds: data['numberOfEnds'],
          numberOfMeters: data['numberOfMeters'],
          twistingCostPerKg: data['twistingCostPerKg'],
          coilWeight: data['coilWeight'],
          plasticWeight: data['plasticWeight'],
          plasticCost: data['plasticCost'],
          rawMaterialCost: data['rawMaterialCost'],
          manufacturingCost: data['manufacturingCost'],
          coilPrice: data['coilPrice'],
          coilPriceInvoice: data['coilPriceInvoice'],
          materialType: data['materialType'],
          materialWeight: data['materialWeight'],
          materialCost: data['materialCost'],
        );
      } else {
        return null;
      }
    } catch (e) {
      print("Error retrieving product: $e");
      return null;
    }
  }

  // Retrieve all products
  Future<List<Products>> getAllProducts() async {
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection(collectionName).get();
      return querySnapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Products(
          id: doc.id,
          code: data['code'],
          productDescription: data['productDescription'],
          wireDiameter: data['wireDiameter'],
          numberOfEnds: data['numberOfEnds'],
          numberOfMeters: data['numberOfMeters'],
          twistingCostPerKg: data['twistingCostPerKg'],
          coilWeight: data['coilWeight'],
          plasticWeight: data['plasticWeight'],
          plasticCost: data['plasticCost'],
          rawMaterialCost: data['rawMaterialCost'],
          manufacturingCost: data['manufacturingCost'],
          coilPrice: data['coilPrice'],
          coilPriceInvoice: data['coilPriceInvoice'],
          materialType: data['materialType'],
          materialWeight: data['materialWeight'],
          materialCost: data['materialCost'],
        );
      }).toList();
    } catch (e) {
      print("Error retrieving all products: $e");
      return [];
    }
  }
}
