
import 'dart:developer';

import 'package:dio/dio.dart';

String? emailValidator(String? email) {

  if (email == null || email.trim().isEmpty) {
    return "Please enter email";
  } else {
    Pattern pattern =
        r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
    RegExp regexp = RegExp(pattern.toString());
    if (regexp.hasMatch(email.trim())) {
      return null;
    } else {
      return "Please enter valid email";
    }
  }
}

String? mobileValidate(String? mobile) {
  if (mobile == null || mobile.trim().isEmpty) {
    return "Please enter mobile number";
  } else {
    if (mobile.trim().length != 10) {
      return "Invalid number";
    } else {
      return null;
    }
  }
}

String? ageValidation(String? age) {
  if (age == null || age.trim().isEmpty) {
    return null;
  } else {
    final i = int.parse(age);
    if (i == 0 || i >= 150) {
      return "Invalid age";
    } else {
      return null;
    }
  }
}

Future<bool> urlValidation({required String url}) async {

  final Type = [
    "image/jpeg",
    "image/jpg",
    "image/png",
  ];
  final Dio dio = Dio();

try{

  Response response = await dio.head(url);
  log("Type : ${response.headers["content-type"]?[0]}");
  log("statuscode  ${response.statusCode}");

  if(response.statusCode == 200)
  {
    final image = response.headers["content-type"]![0];
    final res = Type.any((e) => e == image.toLowerCase());
    print("res $res");
    return res;
  }
  else
  {
    return false;
  }
} on DioException catch(e){
  log("DioCatch : $e");
  return false;
}
  catch(e){
    log("Catch : $e");
    return false;
  }
}
