import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../API/Responsclass.dart';

class Postapi extends ChangeNotifier {

  bool ispostloding = false;
  Future<Responsivclass> postapi(  {required Map<String,dynamic> json}) async {

    final Dio dio =Dio();
    Responsivclass responsivclass = Responsivclass(sucsse: false, smsg: 'APi Colling');

    final uri = 'https://sahil-flutter.vercel.app/api/v1/users';

    try{
      ispostloding = true;
      notifyListeners();
      log("data ${json}");
       Response response = await dio.post(uri,data: json,);
      log("response $response");
      log("code${response.statusCode}");
      if(response.statusCode == 201)
      {
        log("ok");
        ispostloding = false;
        responsivclass.sucsse = true;
        notifyListeners();
        notifyListeners();
        return responsivclass;

      }
      else
      {
        ispostloding = false;
        responsivclass.sucsse = false;
        notifyListeners();
        log("else error");
        return responsivclass;
      }

    }
    on DioException catch(e){
      log("Dio Error $e");
      responsivclass.sucsse = false;
      ispostloding = false;
      notifyListeners();
      return responsivclass;
    }
    catch(e){
      log("catch $e");
      responsivclass.sucsse = false;
      ispostloding = false;
      notifyListeners();
      return responsivclass;
    }

  }

}