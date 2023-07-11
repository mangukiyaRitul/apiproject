import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Postapi extends ChangeNotifier {

  Future<bool> postapi(  {required Map<String,dynamic> json}) async {

    final Dio dio =Dio();
    final uri = 'https://sahil-flutter.vercel.app/api/v1/users';

    try{
      log("data ${json}");
       Response response = await dio.post(uri,data: json,);
      log("response $response");
      log("code${response.statusCode}");
      if(response.statusCode == 201)
      {
        log("ok");
        notifyListeners();
        return true;

      }
      else
      {
        notifyListeners();
        log("else error");
        return false;
      }

    }
    on DioException catch(e){
      log("Dio Error $e");
      notifyListeners();
      return false;
    }
    catch(e){
      log("catch $e");
      notifyListeners();
      return false;
    }

  }

}