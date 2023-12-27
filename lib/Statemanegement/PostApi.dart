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

    final uri = 'https://userprofle.onrender.com/users/createProfile';

    try{
      ispostloding = true;
      notifyListeners();
      debugPrint("data ${json}");
       Response response = await dio.post(uri,data: json,);
      debugPrint("response $response");
      debugPrint("code${response.statusCode}");
      if(response.statusCode == 201)
      {
        debugPrint("ok");
        ispostloding = false;
        responsivclass.sucsse = true;
        debugPrint("API DATA REALURI : ${response.realUri}");
        debugPrint("API DATA : ${response.requestOptions.uri}");
        notifyListeners();
        return responsivclass;

      }
      else
      {
        ispostloding = false;
        responsivclass.sucsse = false;
        notifyListeners();
        debugPrint("else error");
        return responsivclass;
      }

    }
    on DioException catch(e){
      debugPrint("Dio Error $e");
      responsivclass.sucsse = false;
      ispostloding = false;
      notifyListeners();
      return responsivclass;
    }
    catch(e){
      debugPrint("catch $e");
      responsivclass.sucsse = false;
      ispostloding = false;
      notifyListeners();
      return responsivclass;
    }

  }

}