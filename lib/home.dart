import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:session/Login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          appBar: AppBar(
            title: Center(child: Text('HOME PAGE')),
          ),
          backgroundColor: Colors.white,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.18,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("images/dsc.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Container(
                  height: 45.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: ElevatedButton(
                    onPressed: () {
                      _signOut();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.yellow[800],
                    ),
                    child:
                        Text('LOGOUT', style: TextStyle(color: Colors.white)),
                  )),
            ],
          )),
    );
  }
}
