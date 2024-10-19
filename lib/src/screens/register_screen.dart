import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/constants.dart';
import '../models/volunteer.dart';
import '../services/firebase_service.dart';
import '../utils/hashing.dart';
import '../utils/validators.dart';
import '../providers/auth_provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey = GlobalKey<FormState>();

  // Controllers for form fields
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _mothersMaidenNameController = TextEditingController();
  final TextEditingController _childhoodBestFriendsNameController = TextEditingController();
  final TextEditingController _childhoodPetsNameController = TextEditingController();

  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dateOfBirthController.dispose();
    _mothersMaidenNameController.dispose();
    _childhoodBestFriendsNameController.dispose();
    _childhoodPetsNameController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize Firebase when the screen is first created
    print("Call ininstate");
    initFirebase();
  }

  // Initialize Firebase
  void initFirebase()  async{
    print("calling initFirebase");
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: 'AIzaSyBsryiFfG10b7CyHlP872MDgJ6tgigBZhY',
            appId: '1:104597272607:android:fa0524cacb94dcd3effd2a',
            messagingSenderId: '104597272607',
            projectId: 'biomark-9669a'
          // storageBucket: 'myapp-b9yt18.appspot.com',
          // These are come form gogle-services.json file
          // look -> https://www.youtube.com/watch?v=_M-GLwuWfoM
        )
    );
  }

  //Implement the Registration Logic
  Future<void> _register() async {

    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
        _errorMessage = '';
      });

      final authProvider = Provider.of<AuthsProvider>(context, listen: false);

      try {
        // Register the user using AuthProvider
        final user = await authProvider.register(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );

        if (user != null) {
          // Hash the security answers
          final hashedFullname = HashingUtils.hashData(_fullNameController.text.trim());
          final hashedemail = HashingUtils.hashData(_emailController.text.trim());
          final hashedPassword = HashingUtils.hashData(_passwordController.text.trim());
          final hasheddateOfBirth = HashingUtils.hashData(_dateOfBirthController.text.trim());
          final hashedmothersMaidenName = HashingUtils.hashData(_mothersMaidenNameController.text.trim());
          final hashedchildhoodBestFriendsName = HashingUtils.hashData(_childhoodBestFriendsNameController.text.trim());
          final hashedchildhoodPetsName = HashingUtils.hashData(_childhoodPetsNameController.text.trim());

          // Create a Volunteer object
          Volunteer volunteer = Volunteer(
            fullName: hashedFullname,
            email: hashedemail,
            password: hashedPassword,
            dateOfBirth: hasheddateOfBirth,
            mothersMaidenName: hashedmothersMaidenName,
            childhoodBestFriendsName: hashedchildhoodBestFriendsName,
            childhoodPetsName: hashedchildhoodPetsName
          );

          // Save volunteer data to Firebase
          await FirebaseService().saveVolunteerData(user.uid, volunteer.toMap());

          // Optionally, save recovery info locally in SQLite
          // await SQLiteService().saveRecoveryInfo(volunteer.securityQuestion1, volunteer.securityAnswer1);
          // await SQLiteService().saveRecoveryInfo(volunteer.securityQuestion2, volunteer.securityAnswer2);
          // await SQLiteService().saveRecoveryInfo(volunteer.securityQuestion3, volunteer.securityAnswer3);

          // Navigate to Profile Setup Screen
          Navigator.pushReplacementNamed(context, '/profile_setup');
        } else {
          setState(() {
            _errorMessage = 'Registration failed. Please try again.';
          });
        }
      } catch (e) {
        setState(() {
          _errorMessage = 'An error occurred: ${e.toString()}';
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }


  // Build the UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.appName),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(AppConstants.defaultPadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Full Name
              TextFormField(
                controller: _fullNameController,
                decoration: InputDecoration(labelText: 'Full Name'),
                validator: (value) => Validators.validateName(value!),
              ),
              SizedBox(height: 10),

              // Email Address
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email Address'),
                keyboardType: TextInputType.emailAddress,
                validator: (value) => Validators.validateEmail(value!),
              ),
              SizedBox(height: 10),

              // Password
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) => Validators.validatePassword(value!),
              ),
              SizedBox(height: 20),

              // Date of Birth
              TextFormField(
                controller: _dateOfBirthController,
                decoration: InputDecoration(labelText: 'Data of Birth'),
                obscureText: true,
                validator: (value) => Validators.validateDate(value!),
              ),
              SizedBox(height: 20),

              // Security Questions
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Security Questions",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 10),

              // Security Question 1
              TextFormField(
                controller: _mothersMaidenNameController,
                decoration: InputDecoration(labelText: "Mother's Maiden Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please answer this security question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Security Question 2
              TextFormField(
                controller: _childhoodBestFriendsNameController,
                decoration: InputDecoration(labelText: "Childhood Best Friend's Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please answer this security question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Security Question 3
              TextFormField(
                controller: _childhoodPetsNameController,
                decoration: InputDecoration(labelText: "Childhood Pet's Name"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please answer this security question';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Error Message
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                ),

              // Register Button
              _isLoading
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),

              // Navigate to Login Screen
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Already have an account? Login here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}






