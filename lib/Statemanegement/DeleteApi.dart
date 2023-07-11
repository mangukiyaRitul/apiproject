import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../API/GetAPI/GetAPImodel.dart';
import '../API/Responsclass.dart';

class DeleteApi extends ChangeNotifier {

  bool isloding = false;
  Future<Responsivclass> deleteapi(  {required int id}) async {

    Responsivclass responsivclass = Responsivclass(sucsse: false, smsg: 'APi Colling');

    final Dio dio =Dio();
    final uri = 'https://sahil-flutter.vercel.app/api/v1/users/';



    try{
      isloding =true;
      notifyListeners();
      Response response = await dio.delete(uri+"$id");
      log("code${response.statusCode}");
      if(response.statusCode == 200)
        {

          isloding =false;
          responsivclass.sucsse = true;
          notifyListeners();
          return responsivclass;

        }
      else
        {
          isloding =false;
          notifyListeners();
          responsivclass.sucsse = true;
          return responsivclass;
        }

    }
    on DioException catch(e){
      log("Dio Error $e");
      isloding =false;
      responsivclass.sucsse = true;
      notifyListeners();
      return responsivclass;
    }
    catch(e){
      log("catch $e");
      isloding =false;
      responsivclass.sucsse = true;
      notifyListeners();
      return responsivclass;
    }

  }

}