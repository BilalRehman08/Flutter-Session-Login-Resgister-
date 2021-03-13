import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:session/Register.dart';
import 'package:session/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _email;
  String _password;
  bool loginacc = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Future<void> signIn() async {
    final formState = _formKey.currentState;
    if (formState.validate()) {
      formState.save();
      print("valid");
      try {
        await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home()));
      } on FirebaseAuthException catch (e) {
        setState(() {
          loginacc = true;
        });
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('LOGIN PAGE')),
        ),
        backgroundColor: Colors.white,
        body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0.0),
            child: SingleChildScrollView(
              child: Column(children: <Widget>[
                SizedBox(
                  height: 50,
                ),
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
                SizedBox(
                  height: 30,
                ),
                Material(
                  elevation: 4,
                  child: TextFormField(
                      decoration: InputDecoration(
                        errorText: loginacc ? 'User not found' : null,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        prefixIcon: Icon(Icons.person),
                        hintText: 'Email',
                      ),
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter some text';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _email = value.trim();
                        });
                      }),
                ),
                SizedBox(height: 20.0),
                Material(
                  elevation: 4,
                  child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        errorText: loginacc ? 'Invalid Password' : null,
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey[300]),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        prefixIcon: Icon(Icons.lock),
                        hintText: 'Password',
                      ),
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter some text';
                        return null;
                      },
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      }),
                ),
                SizedBox(height: 20.0),
                Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        signIn();
                      },
                      // SignIn,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                      ),

                      child:
                          Text('LOGIN', style: TextStyle(color: Colors.white)),
                    )),
                SizedBox(height: 20.0),
                Container(
                    height: 45.0,
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Register()));
                      },
                      // SignIn,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.yellow[800],
                      ),

                      child: Text('REGISTER',
                          style: TextStyle(color: Colors.white)),
                    )),
                Divider(height: 40.0, thickness: 0.70, color: Colors.green),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
