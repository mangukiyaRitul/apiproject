import 'package:apiproject/Color_Fonts_Error/Color-const.dart';
import 'package:apiproject/Color_Fonts_Error/Fonts.dart';
import 'package:apiproject/Statemanegement/DeleteApi.dart';
import 'package:apiproject/Statemanegement/PostApi.dart';
import 'package:apiproject/Statemanegement/putapi.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screen/Homepage.dart';
import 'Statemanegement/getapimanega.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) =>  getapimanege()),
        ChangeNotifierProvider(create: (context) =>  DeleteApi()),
        ChangeNotifierProvider(create: (context) =>  Postapi()),
        ChangeNotifierProvider(create: (context) =>  Putapi()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppPrimary),
        primarySwatch: MaterialColor(0xff5F6F94,swatch),
        appBarTheme: AppBarTheme(
          elevation: 0.0,
          backgroundColor: AppPrimary,
          centerTitle: true,
          titleTextStyle: MyTextStyle.semiBold.copyWith(fontSize: 19),
        ),
        useMaterial3: true,
      ),


      home:  HomePage(),
      // home: const CreatUpdate(),
    );
  }
}