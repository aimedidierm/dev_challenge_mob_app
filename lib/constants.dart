import 'package:flutter/material.dart';

//Endpoints
const baseURL = 'http://192.168.43.83:8000/api';
const loginURL = '$baseURL/login';
const registerURL = '$baseURL/register';
const profileURL = '$baseURL/profile';

const categoryRequestURL = '$baseURL/project/request';
const projectListURL = '$baseURL/project/all';
const projectDeleteURL = '$baseURL/project/all/';

const financeListURL = '$baseURL/finance/all';
const financeRejectURL = '$baseURL/finance/all/reject/';
const financeApproveURL = '$baseURL/finance/all/approve/';

const generalListToolsURL = '$baseURL/general/all';
const generalApproveURL = '$baseURL/general/all/approve/';
const generalRejectURL = '$baseURL/general/all/reject/';
const generalListURL = '$baseURL/general/user';
const generalApproveUserURL = '$baseURL/general/user/approve/';
const generalRejectUserURL = '$baseURL/general/user/reject/';

// Application colors
Color primaryColor = Color(0xFF012267);
Color secondaryColor = Color(0xFFFD8902);
MaterialColor themColor = const MaterialColor(0xFF1C658C, {
  50: Color(0xFFE6F1F8),
  100: Color(0xFFB3D9EE),
  200: Color(0xFF80C1E4),
  300: Color(0xFF4DAADB),
  400: Color(0xFF2692D1),
  500: Color(0xFF1C658C),
  600: Color(0xFF1E5582),
  700: Color(0xFF204676),
  800: Color(0xFF223C6B),
  900: Color(0xFF243261),
});

//Errors
const serverError = 'Internal system error';
const unauthorized = 'You are not allowed';
const somethingWentWrong = 'Something went wrong';
const userPending = 'Your account is pending';
