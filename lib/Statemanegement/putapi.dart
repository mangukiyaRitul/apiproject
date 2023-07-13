import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../API/Responsclass.dart';

class Putapi extends ChangeNotifier{
bool isputloding = false;

  Future<Responsivclass> putapi({required int id,required Map<String,dynamic> json}) async {
    final uri  =  'https://sahil-flutter.vercel.app/api/v1/users/';
   final dio = Dio();

   Responsivclass responseclass = Responsivclass(
       sucsse: false,
       smsg: 'updeting',
   );
   try{
     isputloding = true;
     notifyListeners();
     Response response = await dio.put(uri+'$id',data: json);
     log("putpi: code ${response.statusCode}");

     if(response.statusCode == 200)
       {

         responseclass.sucsse = true;
         isputloding = false;
         notifyListeners();
         return responseclass;
       }
     else{
       isputloding = false;
       notifyListeners();
       return responseclass;
     }
     return responseclass;
   }on DioException catch(e){
     log("putapi: Dio catch Error $e");
     isputloding = false;
     notifyListeners();
     return responseclass;
   }catch(e){
     log('putapi:catch Error $e');
     isputloding = false;
     notifyListeners();
     return responseclass;
   }


  }

}