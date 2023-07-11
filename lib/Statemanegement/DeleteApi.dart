import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DeleteApi extends ChangeNotifier {

  Future<bool> deleteapi(  {required int id}) async {

    final Dio dio =Dio();
    final uri = 'https://sahil-flutter.vercel.app/api/v1/users/';

    try{
      Response response = await dio.delete(uri+"$id");
      log("code${response.statusCode}");
      if(response.statusCode == 200)
        {
          notifyListeners();
          return true;

        }
      else
        {
          notifyListeners();
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