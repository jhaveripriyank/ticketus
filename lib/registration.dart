import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'authentication.dart';
import 'home_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  String _confirmPassword = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TicketUs.'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/register.jpg'),
            fit: BoxFit.cover,

          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(100.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value ?? '';
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter your email';
                      }
                      if (!value!.contains('@')) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value ?? '';
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter a password';
                      }
                      if (value!.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
                      _password = value;
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Confirm Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value?.isEmpty == true) {
                        return 'Please enter confirm password';
                      }
                      if (value != _password && _password.isNotEmpty) {
                        return 'Passwords do not match';
                      }
                      _confirmPassword = value!;
                      return null;
                    },
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(onPressed: () {
                    if (_formKey.currentState?.validate() == false) {
                      _formKey.currentState?.save();
                      // Submit registration form
                      // Here you can call your API or database to register the user
                      // After successful registration, navigate to the authentication page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AuthenticationPage(),
                        ),
                      ).then((value) {
                        if (value == true) {
                          // User successfully logged in, navigate to home page
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          );
                        }
                      });
                    }
                  },
                      child: Text('Login')),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState?.validate() == true) {
                        _formKey.currentState?.save();
                        // Submit registration form
                        // Here you can call your API or database to register the user
                        // After successful registration, navigate to the authentication page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AuthenticationPage(),
                          ),
                        ).then((value) {
                          if (value == true) {
                            // User successfully logged in, navigate to home page
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomePage(),
                              ),
                            );
                          }
                        });
                      }
                    },
                    child: Text('Register'),
                  ),
      SizedBox(height: 16.0),
      Text(
      'Or register with',
      style: TextStyle(fontSize: 16.0),
      ),
      SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const FaIcon(FontAwesomeIcons.google),
              onPressed: () {
                // Handle Google registration here
              },
            ),
            IconButton(
              icon: Icon(Icons.facebook),
              onPressed: () {
            // Handle Facebook registration here
              },
                ),
              ],
            ),
          ],
          ),
          ),
          ),
        ),
      ),
    );
  }
}






