
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

import '../API/GetAPI/GetAPImodel.dart';
import '../API/Responsclass.dart';

class getapimanege extends ChangeNotifier{

bool isloding = false;
List<getapimodel>? users;
List<getapimodel> fast3user = [];
  Future<Responsivclass<List<getapimodel>>?> getapi() async {

     final uri  =  'https://userprofle.onrender.com/users/getProfile';

     final Dio dio = Dio();

    Responsivclass<List<getapimodel>> responsivclass = Responsivclass(sucsse: false, smsg: 'APi Colling');

     try{
       isloding = true;
       notifyListeners();
       Response response = await dio.get(uri, options: Options(validateStatus: (status){
         return status == 200 || status == 400 || status == 404||status == 500;},  ));
       debugPrint("response  ${response.statusCode}");

       if(response.statusCode == 200)
         {
           responsivclass.sucsse = true;
           responsivclass.smsg= response.data['message'];
           debugPrint("API DATA REALURI : ${response.realUri}");
           debugPrint("API DATA : ${response.requestOptions.uri}");
           responsivclass.data = List<getapimodel>.from(response.data['data'].map((e)=> getapimodel.fromJson(e)));
           isloding = false;
           users = responsivclass.data;
           notifyListeners();
           return responsivclass;
         }
       else
         {
           users = [];
           isloding = false;
           notifyListeners();
           return responsivclass;
         }

     } on DioException catch (e){
       isloding = false;
       notifyListeners();
       users = [];
       debugPrint("DioError ${e}");
       return responsivclass;
     }

     catch(e){
       isloding = false;
       users = [];
       notifyListeners();
       debugPrint("Error ${e}");
       return responsivclass;
     }

  }

}