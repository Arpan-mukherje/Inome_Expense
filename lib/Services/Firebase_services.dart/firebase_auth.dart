import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  static Future<UserCredential> signup(
      String name, String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //******************************************************/
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user?.uid)
          .set({
        'name': name,
        'password': password,
        'email': email,
      });
      //*******************************************************/
      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      rethrow;
    } catch (e) {
      log("From signup ->   $e");
      rethrow;
    }
  }

  static Future<UserCredential?> login(String email, String password) async {
    try {
      final auth = FirebaseAuth.instance;
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final userId = userCredential.user?.uid;
      await _getAndStoreUserDetails(userId.toString());

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        log('Invalid email or password');
        return null;
      } else {
        log('Firebase Authentication Error: ${e.message}');
      }
    } catch (e) {
      log("Error during login: $e");
      rethrow;
    }
  }

  static Future<void> signOut() async {
    try {
      final auth = FirebaseAuth.instance;
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
      rethrow;
    } catch (e) {
      log("From signout ->   $e");
      rethrow;
    }
  }

  static Future<void> _getAndStoreUserDetails(String userId) async {
    try {
      final docSnap = await FirebaseFirestore.instance
          .collection("users")
          .doc(userId)
          .collection("user-details")
          .doc(userId)
          .get();
      if (docSnap.exists) {
        final userDetails = docSnap.data() as Map<String, dynamic>;
      } else {
        log("not esist");
      }
    } catch (e) {
      log("From _getAndStoreUserDetails ->   $e");
    }
  }
}
