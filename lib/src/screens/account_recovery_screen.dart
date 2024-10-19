import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/account_recovery_service.dart';

class AccountRecoveryScreen extends StatefulWidget {
  @override
  _AccountRecoveryScreenState createState() => _AccountRecoveryScreenState();
}

class _AccountRecoveryScreenState extends State<AccountRecoveryScreen> {

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController childhoodPetsName = TextEditingController();
  final TextEditingController childhoodBestFriendsName = TextEditingController();

  final AccountRecoveryService _accountRecoveryService = AccountRecoveryService();

  bool _isLoading = false;

  Future<void> _recoverAccount() async {

    setState(() {
      _isLoading = true;
    });

    bool verified = await _accountRecoveryService.verifyAccount(
      fullName: _fullNameController.text,
      dob: _dobController.text,
      childhoodPetsName: childhoodPetsName.text,
      childhoodBestFriendsName: childhoodBestFriendsName.text,
    );

    if (verified) {
      Navigator.pushNamed(context, '/reset_password'); // Route to password reset screen
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Verification failed. Please try again.')),
      );
    }

    setState(() {
      _isLoading = false;
    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Recovery'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _fullNameController,
              decoration: InputDecoration(labelText: 'Full Name'),
            ),
            TextField(
              controller: _dobController,
              decoration: InputDecoration(labelText: 'Date of Birth'),
            ),
            TextField(
              controller: childhoodPetsName,
              decoration: InputDecoration(labelText: 'Your Childhood Pet\'s Name'),
            ),
            TextField(
              controller: childhoodBestFriendsName,
              decoration: InputDecoration(labelText: 'Your Best Friend\'s Name'),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _recoverAccount,
              child: Text('Recover Account'),
            ),
          ],
        ),
      ),
    );
  }



}