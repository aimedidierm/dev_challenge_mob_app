import 'package:dev_challenge/constants.dart';
import 'package:dev_challenge/models/api_response.dart';
import 'package:dev_challenge/screens/login.dart';
import 'package:dev_challenge/services/user.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  String? _role;

  void registerUser() async {
    ApiResponse response =
        await register(name.text, email.text, password.text, _role);
    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account creation is pending!'),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${response.error}'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Create your account",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
              Form(
                key: formkey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: name,
                        validator: (val) =>
                            val!.isEmpty ? 'Your names are required' : null,
                        decoration: const InputDecoration(
                          hintText: 'Enter your names',
                          labelText: 'names',
                        ),
                      ),
                      TextFormField(
                        validator: (val) {
                          RegExp regex = RegExp(r'\w+@\w+\.\w+');
                          if (val!.isEmpty) {
                            return 'Email is required';
                          } else if (!regex.hasMatch(val)) {
                            return 'Enter a valid email';
                          } else {
                            return null;
                          }
                        },
                        controller: email,
                        decoration: const InputDecoration(
                          hintText: 'Enter email',
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        controller: password,
                        obscureText: true,
                        validator: (val) =>
                            val!.isEmpty ? 'Password is required' : null,
                        decoration: const InputDecoration(
                          hintText: 'Enter password',
                          labelText: 'Password',
                        ),
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val) {
                          if (val!.isEmpty) {
                            return 'You must confirm password';
                          } else if (val != password.text) {
                            return 'Passwords not match';
                          } else {
                            return null;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: 'Enter password',
                          labelText: 'Confirm password',
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        validator: (val) => val?.isEmpty ?? true
                            ? 'Please select a role'
                            : null,
                        value: _role,
                        onChanged: (value) {
                          setState(() {
                            _role = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Select your role',
                        ),
                        items: [
                          DropdownMenuItem<String>(
                            value: 'project',
                            child: Text('Project'),
                          ),
                          DropdownMenuItem<String>(
                            value: 'finance',
                            child: Text('Finance'),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          if (formkey.currentState!.validate()) {
                            registerUser();
                          }
                        },
                        child: const Text(
                          '   Create account   ',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) => primaryColor),
                          padding: MaterialStateProperty.resolveWith(
                            (states) => EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("You have account? "),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      );
                    },
                    child: Text(
                      " Login",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                          color: primaryColor),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 80,
              )
            ],
          ),
        ],
      ),
    );
  }
}
