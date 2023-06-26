import 'package:dev_challenge/constants.dart';
import 'package:dev_challenge/models/api_response.dart';
import 'package:dev_challenge/models/user.dart';
import 'package:dev_challenge/screens/finance_home.dart';
import 'package:dev_challenge/screens/general_home.dart';
import 'package:dev_challenge/screens/login.dart';
import 'package:dev_challenge/screens/project_home.dart';
import 'package:dev_challenge/services/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Load extends StatefulWidget {
  const Load({super.key});

  @override
  State<Load> createState() => _LoadState();
}

class _LoadState extends State<Load> {
  void getUserInfo() async {
    String token = await getToken();
    if (token == '') {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => Login(),
        ),
        (route) => false,
      );
    } else {
      ApiResponse response = await getUserDetails();
      if (response.error == null) {
        User user = response.data as User;
        if (user.role == "project") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => ProjectHome(),
              ),
              (route) => false);
        } else if (user.role == "finance") {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => FinanceHome(),
              ),
              (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => GeneralHome(),
              ),
              (route) => false);
        }
      } else if (response.error == unauthorized) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => Login(),
          ),
          (route) => false,
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${response.error}'),
          ),
        );
      }
    }
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Center(
        child: SpinKitCircle(
          color: primaryColor,
          size: 100,
        ),
      ),
    );
  }
}
