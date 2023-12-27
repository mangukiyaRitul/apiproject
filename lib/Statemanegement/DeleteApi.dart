import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../API/Responsclass.dart';

class DeleteApi extends ChangeNotifier {

  bool isloding = false;
  Future<Responsivclass> deleteapi(  {required String id}) async {

    Responsivclass responsivclass = Responsivclass(sucsse: false, smsg: 'APi Colling');

    final Dio dio =Dio();
    final uri = 'https://userprofle.onrender.com/users/deleteProfile/';



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
          debugPrint("API DATA REALURI : ${response.realUri}");
          debugPrint("API DATA : ${response.requestOptions.uri}");
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