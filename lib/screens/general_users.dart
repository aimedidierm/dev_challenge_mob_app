import 'dart:convert';

import 'package:dev_challenge/constants.dart';
import 'package:dev_challenge/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class GeneralUsers extends StatefulWidget {
  const GeneralUsers({super.key});

  @override
  State<GeneralUsers> createState() => _GeneralUsersState();
}

class _GeneralUsersState extends State<GeneralUsers> {
  bool _loading = false;
  List<Map<String, dynamic>> _allUsers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(generalListURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<Map<String, dynamic>> allUsers =
          List<Map<String, dynamic>>.from(decodedResponse['data']);

      setState(() {
        _allUsers = allUsers;
        _loading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> rejectUser(String id) async {
    String token = await getToken();
    final response = await http.get(Uri.parse(generalRejectUserURL + '$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });
    if (response.statusCode == 200) {
      setState(() {
        fetchData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> approveUser(String id) async {
    String token = await getToken();
    final response = await http.get(Uri.parse(generalApproveUserURL + '$id'),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        });

    if (response.statusCode == 200) {
      setState(() {
        fetchData();
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: _loading
            ? Center(
                child: SpinKitCircle(
                  color: primaryColor,
                  size: 100,
                ),
              )
            : Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: _allUsers.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_allUsers[index]["id"]),
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                _allUsers[index]['name'],
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                          _allUsers[index]["email"].toString()),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      approveUser(
                                          _allUsers[index]['id'].toString());
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: const Text(
                                          'Approve',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      rejectUser(
                                          _allUsers[index]['id'].toString());
                                    },
                                    child: Container(
                                      height: 20,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: const Text(
                                          'Reject',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
