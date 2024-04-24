import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../theams/custom_theam.dart';
import 'HomeScreen.dart';

final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();

Future<void> _login(BuildContext context) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    );
    Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
  } catch (e) {
    // Handle login errors
    print('Login failed: $e');
    // Display error message to the user
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: $e')),
    );
  }
}

class LoginScreen extends StatelessWidget {
  Widget build(BuildContext context) {
    final _formSignInkey = GlobalKey<FormState>();
    bool RememberPassword = true;

    return CutomsScreen(
      child: Column(
        children: [
          Expanded(
              flex: 1,
              child: SizedBox(
                height: 10,
              )),
          Expanded(
              flex: 7,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formSignInkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "Welcome back",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            color: Colors.grey,
                            fontSize: 40,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _emailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Email",
                                hintText: "Enter Email",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black12,
                                ))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please Enter Password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                labelText: "Password",
                                hintText: "Enter Password",
                                hintStyle: TextStyle(
                                  color: Colors.black26,
                                ),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black12,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black12,
                                ))),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: RememberPassword,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      RememberPassword = false;
                                    });
                                  },
                                  activeColor: Colors.lightBlue,
                                ),
                                Text(
                                  'Rember me',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ],
                            ),
                            InkWell(
                                child: Text(
                                  "Forget Password ?",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline,
                                      fontWeight: FontWeight.bold),
                                ),
                                onTap: () {
                                  // Navigator.push(context, MaterialPageRoute(builder: (context)=>));
                                })
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 350, // Set the width of the button
                              child: ElevatedButton(
                                onPressed: ()=>_login(context),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.blue,
                                  // Background color
                                  backgroundColor: Colors.white,
                                  // Text color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 40, vertical: 20),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  elevation: 3, // Shadow elevation
                                ),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
    throw UnimplementedError();
  }

  void setState(Null Function() param0) {}
}
