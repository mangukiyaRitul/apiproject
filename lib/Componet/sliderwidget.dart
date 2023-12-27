import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Statemanegement/getapimanega.dart';

class sliderwidget extends StatefulWidget {
  List userlist ;
   sliderwidget({super.key ,required this.userlist });

  @override
  State<sliderwidget> createState() => _sliderwidgetState();
}

class _sliderwidgetState extends State<sliderwidget> {

  TextStyle textStyle = const TextStyle(
      fontSize: 18,
      color: Colors.black
  );
  final PageController _pageController = PageController(
    initialPage:0,);

  late Timer _timer;
  final ValueNotifier<int> _userindex = ValueNotifier(0);
  int userlength = 5;

  @override
  void initState() {
    super.initState();

    _timer =Timer.periodic(Duration(seconds: 3), (timer)
    {
      if (_userindex.value < context.read<getapimanege>().users!.length -1 ) {
        _userindex.value++;
        debugPrint('${_userindex.value}');
      }
      else {
        _userindex.value = 0;
        debugPrint('Else ${_userindex.value}');
      }
      if (_pageController.hasClients) {
        debugPrint('pageani ${_userindex.value}');
        _pageController.animateToPage(_userindex.value, duration: Duration(milliseconds: 1000), curve: Curves.easeIn);
    }
    });
  }
  @override
  void dispose() {
    super.dispose();
    _userindex.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    final provaider = context.watch<getapimanege>();
    return  SizedBox(
      height: 150,
      width: double.infinity,
      child: PageView.builder(
        controller: _pageController,
        clipBehavior: Clip.antiAlias,
        physics: const BouncingScrollPhysics(
          decelerationRate: ScrollDecelerationRate.fast,
        ),
        scrollDirection: Axis.horizontal,
        itemCount: provaider.users!.length,
        onPageChanged: (changeIndex){
          _userindex.value = changeIndex;
          debugPrint('OnPageChanged ${_userindex.value}');
        },
        itemBuilder: (context, index) {
          final  user = provaider.users![index];
          return AnimatedContainer(
            duration: Duration(milliseconds: 500),
            child: Container(
              // padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(10),
              height: 150,
              width: 375,
              decoration: BoxDecoration(
                  color: Colors.blueGrey.shade200,
                  borderRadius: BorderRadius.circular(10)
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Name  :  ${user.Name}",style: textStyle),
                  Text("Phone :  ${user.Phone}",style: textStyle),
                  Text("Email  : ${user.Email}",style: textStyle),
                ],
              ),
            ),
          );
        },),
    );
  }
}
