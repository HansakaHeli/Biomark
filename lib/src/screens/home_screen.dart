import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biomark'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // App Logo/Title
            Text(
              'Welcome to Biomark',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            // Tagline/Description
            Text(
              'Predictive Health Insights for a Better Future',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40),

            // Register Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),

              child: Text('Register'),
            ),
            SizedBox(height: 20),

            // Login Button
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Login'),
            ),
            SizedBox(height: 40),

            // Optional: About Biomark Section
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'About Biomark',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Biomark is a volunteer-based health app designed to '
                          'collect and analyze health data for predictive insights '
                          'through machine learning models. Your contribution helps '
                          'advance medical research and future healthcare solutions.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
