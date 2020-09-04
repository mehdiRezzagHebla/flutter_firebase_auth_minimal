import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'auth_service.dart';
import 'connected_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _pwController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<AuthService>(
      create: (context) => AuthService(),
      child: Consumer<AuthService>(
        builder: (context, authClass, _) => Scaffold(
          appBar: AppBar(
            title: Text('Firebase Auth Testing'),
          ),
          body: StreamBuilder<CustomUser>(
              stream: authClass.onAuthchanged(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              TextField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  labelText: 'Email',
                                ),
                              ),
                              TextField(
                                controller: _pwController,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                ),
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  await authClass.logIn(_emailController.text,
                                      _pwController.text, context);
                                },
                                child: Text('Login'),
                              ),
                              RaisedButton(
                                onPressed: () async {
                                  await authClass.register(
                                      _emailController.text,
                                      _pwController.text,
                                      context);
                                },
                                child: Text('Register'),
                              )
                            ],
                          ),
                        ),
                      );}
                else if(snapshot.hasData){
                     return ConnectedScreen(uid: snapshot.data.uid);}
                else{
                  return CircularProgressIndicator();
                }
              }),
        ),
      ),
    );
  }
}
