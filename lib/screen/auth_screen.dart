import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/auth_form.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthUser(
      String email, String password, String username, bool isLogin) async {
    UserCredential credential;

    try {
      setState(() {
        _isLoading = true;
      });
      if (isLogin) {
        credential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        credential = await auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        await FirebaseFirestore.instance
            .collection('users')
            .doc(credential.user?.uid)
            .set({
          'email': email,
          'username': username,
        });
      }

      setState(() {
        _isLoading = false;
      });
    } on FirebaseAuthException catch (err) {
      setState(() {
        _isLoading = false;
      });
      var message = 'An error accurred, please check your credential';
      if (err.code == 'user-not-found') {
        message = 'User not found for that email!';
      } else if (err.code == 'wrong-password') {
        message = 'Invalid password for that user';
      } else if (err.code == 'weak-password') {
        message = 'The password provided is too weak.';
      } else if (err.code == 'email-already-in-use') {
        message = 'The account already exists for that email.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            message,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Something missing!',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: AuthForm(_submitAuthUser, _isLoading),
    );
  }
}
