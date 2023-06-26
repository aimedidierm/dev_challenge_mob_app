import 'dart:ffi';

import 'package:dev_challenge/constants.dart';
import 'package:dev_challenge/models/api_response.dart';
import 'package:dev_challenge/services/packages.dart';
import 'package:flutter/material.dart';

class ProjectRequest extends StatefulWidget {
  const ProjectRequest({super.key});

  @override
  State<ProjectRequest> createState() => _ProjectRequestState();
}

class _ProjectRequestState extends State<ProjectRequest> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController units = TextEditingController();

  void sendRequest() async {
    ApiResponse response = await sendPackageRequest(
      name.text,
      price.text,
      units.text,
    );
    if (response.error == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Request send'),
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Text(
                        "Send request",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: secondaryColor,
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
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
                                val!.isEmpty ? 'Names are required' : null,
                            decoration: InputDecoration(
                              labelText: 'Enter names',
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(width: 1, color: primaryColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: price,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Price is required';
                              }
                              if (double.tryParse(val) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Price per unit',
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: units,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Units are required';
                              }
                              if (double.tryParse(val) == null) {
                                return 'Please enter a valid number';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              labelText: 'Units',
                              contentPadding: const EdgeInsets.all(8.0),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  width: 1,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                            onPressed: () {
                              if (formkey.currentState!.validate()) {
                                sendRequest();
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                (states) => secondaryColor,
                              ),
                              padding: MaterialStateProperty.resolveWith(
                                (states) =>
                                    const EdgeInsets.symmetric(vertical: 10),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                'Send request',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
