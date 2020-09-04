import 'package:firebase_auth_problem_reproduction/auth_service.dart';
import 'package:flutter/material.dart';

class ConnectedScreen extends StatelessWidget {
  final String uid;
  ConnectedScreen({@required this.uid});
  @override
  Widget build(BuildContext context) {
    AuthService _auth = AuthService();

    void _logout() async {
      await _auth.logOut();
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 300,
                  child: Text(
              'You Are Connected with userId:\n $uid',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          RaisedButton(onPressed: _logout, child: Text('Log out'))
        ],
      ),
    );
  }
}
