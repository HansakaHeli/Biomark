import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/firebase_service.dart';

class UnsubscribeScreen extends StatefulWidget {
  @override
  _UnsubscribeScreenState createState() => _UnsubscribeScreenState();
}

class _UnsubscribeScreenState extends State<UnsubscribeScreen>{

  bool _isLoading = false;

  Future<void> _unsubscribe() async{

    setState(() {
      _isLoading = true;
    });

    try{

      // Confirm the user's decision to unsubscribe
      bool confirmed = await _showUnsubscribeDialog();

      if (!confirmed) {
        setState(() {
          _isLoading = false;
        });
        return;
      }

      // Remove user's profile data from Firebase
      await FirebaseService().deleteUserProfile();

      //Log out the user from Firebase Authentication
      await AuthService().logout();

      // Show success message and navigate to home screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You have been successfully unsubscribed.')),
      );

      // Navigate to home screen
      Navigator.pushReplacementNamed(context, '/');

    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: Could not unsubscribe. Please try again.')),
      );
    }

    setState(() {
      _isLoading = false;
    });

  }

  Future<bool> _showUnsubscribeDialog() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Unsubscribe from Biomark'),
          content: Text('Are you sure you want to unsubscribe? This will delete all your data and cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text('Confirm'),
            ),
          ],
        );
      },
    ) ?? false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Unsubscribe'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'By unsubscribing, your profile data will be permanently deleted from the Biomark program.',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _unsubscribe,
              child: Text('Unsubscribe'),
            ),
          ],
        ),
      ),
    );
  }




}