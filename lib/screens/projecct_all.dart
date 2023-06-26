import 'dart:convert';
import 'dart:ffi';

import 'package:dev_challenge/constants.dart';
import 'package:dev_challenge/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;

class ProjectAll extends StatefulWidget {
  const ProjectAll({super.key});

  @override
  State<ProjectAll> createState() => _ProjectAllState();
}

class _ProjectAllState extends State<ProjectAll> {
  bool _loading = false;
  List<Map<String, dynamic>> _allPackages = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    String token = await getToken();
    final response = await http.get(Uri.parse(projectListURL), headers: {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    });

    if (response.statusCode == 200) {
      final decodedResponse = json.decode(response.body);
      final List<Map<String, dynamic>> allPackages =
          List<Map<String, dynamic>>.from(decodedResponse['data']);

      setState(() {
        _allPackages = allPackages;
        _loading = false;
      });
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  Future<void> deleteTool(String id) async {
    String token = await getToken();
    final response = await http.get(Uri.parse(projectDeleteURL + '$id'),
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
                      itemCount: _allPackages.length,
                      itemBuilder: (context, index) => Card(
                        key: ValueKey(_allPackages[index]["id"]),
                        elevation: 0,
                        margin: const EdgeInsets.symmetric(vertical: 6),
                        child: Column(
                          children: [
                            ListTile(
                              title: Text(
                                _allPackages[index]['name'],
                                textAlign: TextAlign.justify,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              contentPadding: const EdgeInsets.all(16),
                              subtitle: Column(
                                children: [
                                  Row(
                                    children: [
                                      const Text('Price/U: '),
                                      Text(_allPackages[index]["price_unity"]
                                          .toString()),
                                      const Text('Rwf'),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Units: '),
                                      Text(_allPackages[index]["unity"]
                                          .toString()),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      const Text('Total: '),
                                      Text(_allPackages[index]['total']
                                          .toString()),
                                      const Text('Rwf'),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 70,
                                    decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Center(
                                      child: const Text(
                                        'Pending',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      deleteTool(
                                          _allPackages[index]['id'].toString());
                                    },
                                    child: Container(
                                      height: 30,
                                      width: 70,
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Center(
                                        child: const Text(
                                          'Delete',
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
