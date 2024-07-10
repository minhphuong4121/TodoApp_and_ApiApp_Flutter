import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  //for storage data in cloud fireStore
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;
  //for authentication data in cloud fireStore
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<String> signUpUser(
      {required String name,
      required String email,
      required String password}) async {
    String except = 'Some errors';
    try {
      if (email.isNotEmpty || password.isNotEmpty || name.isNotEmpty) {
        //for register user in firebase auth with email and password
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
            email: email, password: password);

        //for add user to our cloud firestore
        await _fireStore.collection("users").doc(credential.user!.uid).set({
          'name': name,
          'email': email,
          'uid': credential.user!.uid,
          //We can't store user's password in our cloud firestore
        });
        except = 'Successfully added';
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }

    return except;
  }

  //For Login Page
  Future<String> loginUser(
      {required String email, required String password}) async {
    String except = 'Some errors';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        except = 'Successfully logged in';
      } else {
        except = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
    return except;
  }

  //For Logout
  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  //For Google LogOut
  Future<bool> googleSignOut() async {
    try {
      await _googleSignIn.disconnect();
      await _googleSignIn.signOut();
      await _auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }

  //For Google login
  Future<String> googleLogin() async {
    String except = "Some errors";
    try {
      //begin interactive sign in process
      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

      //obtain auth details from request
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;

      //create a new credentials for user
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      await FirebaseAuth.instance.signInWithCredential(credential);
      except = "Successfully Google logged in";
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
    return except;
  }

  //For password reset
  Future<String> resetPassword({required String email}) async {
    String except = "Some errors";

    try {
      if (email.isNotEmpty) {
        await _auth.sendPasswordResetEmail(email: email);

        except = "Successfully reset password";
      } else {
        except = "Please enter email!";
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }

    return except;
  }
}
