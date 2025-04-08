import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ees_calculator/Back%20End/Models/user.dart' as user;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<user.User?> signInWithEmailPassword(BuildContext context, String email, String password) async {
    try {
      // Sign in with email and password
      final UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if userCredential is null (additional safety check)
      if (userCredential.user == null) {
        return null; // Handle if the user is not signed in
      }

      // Fetch user data from Firestore
      QuerySnapshot querySnapshot = await _firestore
          .collection('User')
          .where('email', isEqualTo: email)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Assuming user data is in the first document
        Map<String, dynamic> userData = querySnapshot.docs[0].data() as Map<String, dynamic>;

        // Create User object from Firestore data
        final user.User currentUser = user.User.fromMap(
          userData,
          querySnapshot.docs[0].id, // Use the document ID as user ID
        );
        return currentUser; // Return the current user object
      } else {
        // No user data found in Firestore for this email
        return null;
      }
    } on FirebaseAuthException catch (e) {
      print("Error signing in: ${e.message}");
      // You can handle different errors here and display appropriate messages to the user
      return null;
    }
  }

  // Sign out method
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      print("User signed out successfully.");
    } catch (e) {
      print("Error signing out: $e");
      // Handle sign out errors
    }
  }
}
