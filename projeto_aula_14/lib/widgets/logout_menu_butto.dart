import 'package:flutter/material.dart';
import 'package:projeto_as/services/firebase/auth/firebase_service_auth.dart';

class LogoutMenuButton extends StatelessWidget {
  const LogoutMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseAuthService _auth = FirebaseAuthService();

    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'logout') {
          await _auth.signOut();
        }
      },
      itemBuilder: (BuildContext context) {
        return const [
          PopupMenuItem<String>(value: 'logout', child: Text('Logout')),
        ];
      },
    );
  }
}
