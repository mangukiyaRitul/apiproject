import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../API/Responsclass.dart';

class Putapi extends ChangeNotifier{
bool isputloding = false;

  Future<Responsivclass> putapi({required String id,required Map<String,dynamic> json}) async {
    final uri  =  'https://userprofle.onrender.com/users/updateProfile/';
   final dio = Dio();

   Responsivclass responseclass = Responsivclass(
       sucsse: false,
       smsg: 'updeting',
   );
   try{
     isputloding = true;
     notifyListeners();
     Response response = await dio.put(uri+'$id',data: json);
     debugPrint("putpi: code ${response.statusCode}");

     if(response.statusCode == 200)
       {

         responseclass.sucsse = true;
         isputloding = false;
         notifyListeners();
         debugPrint("API DATA REALURI : ${response.realUri}");
         debugPrint("API DATA : ${response.requestOptions.uri}");

         return responseclass;
       }
     else{
       isputloding = false;
       notifyListeners();
       return responseclass;
     }
     return responseclass;
   }on DioException catch(e){
     debugPrint("putapi: Dio catch Error $e");
     isputloding = false;
     notifyListeners();
     return responseclass;
   }catch(e){
     debugPrint('putapi:catch Error $e');
     isputloding = false;
     notifyListeners();
     return responseclass;
   }


  }

}