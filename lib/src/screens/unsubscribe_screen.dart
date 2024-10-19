// import 'package:flutter/material.dart';
// import 'firebase_service.dart';
//
// class UnsubscribeScreen extends StatefulWidget {
//   @override
//   _UnsubscribeScreenState createState() => _UnsubscribeScreenState();
// }
//
// class _UnsubscribeScreenState extends State<UnsubscribeScreen> {
//   final FirebaseService _firebaseService = FirebaseService();
//
//   // Handle account unsubscription (delete account)
//   void _unsubscribe() async {
//     String uid = "some_user_id";  // You will typically get this from Firebase Auth
//     await _firebaseService.deleteVolunteerProfile(uid);
//     // Optionally navigate to a goodbye or main screen
//     Navigator.pushReplacementNamed(context, '/goodbye');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Unsubscribe')),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             Text('Are you sure you want to unsubscribe and delete your account?'),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: _unsubscribe,
//               child: Text('Confirm Unsubscribe'),
//               style: ElevatedButton.styleFrom(primary: Colors.red),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
