import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../services/firebase_service.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  User? _currentUser;
  Map<String, dynamic>? _profileData;
  final FirebaseService _firebaseService = FirebaseService(); // Instance of the service

  @override
  void initState() {
    super.initState();
    _currentUser = FirebaseAuth.instance.currentUser;
    _fetchProfileData();
  }

  Future<void> _fetchProfileData() async {

    if (_currentUser != null) {
      Map<String, dynamic>? data = await _firebaseService.fetchProfileData(_currentUser!.uid);
      setState(() {
        _profileData = data;
      });
    }

  }

  // Future<void> _signOut() async {
  //   await AuthHelper.signOut();
  //   Navigator.pushReplacementNamed(context, LOGIN_SCREEN);
  // }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.logout),
          //   onPressed: _signOut,
          // ),
        ],
      ),
      body: _profileData == null
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 50,
              //backgroundImage: NetworkImage(_currentUser?.photoURL ?? DEFAULT_AVATAR),
            ),
            SizedBox(height: 16),
            Text(
              'Name: ${_profileData!['fullName'] ?? 'No Name'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Email: ${_currentUser?.email ?? 'No Email'}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Divider(),
            // Personal data from ProfileSetupScreen
            Text(
              'Date of Birth: ${_profileData!['dob'] ?? 'Not set'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Time of Birth: ${_profileData!['timeOfBirth'] ?? 'Not set'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Location of Birth: ${_profileData!['locationOfBirth'] ?? 'Not set'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Blood Group: ${_profileData!['bloodGroup'] ?? 'Not set'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Sex: ${_profileData!['sex'] ?? 'Not set'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Height: ${_profileData!['height'] ?? 'Not set'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Ethnicity: ${_profileData!['ethnicity'] ?? 'Not set'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Eye Colour: ${_profileData!['eyeColor'] ?? 'Not set'}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => EditProfileScreen()),
                // );
              },
              child: Text('Edit Profile'),
            ),
          ],
        ),
      ),
    );
  }




}