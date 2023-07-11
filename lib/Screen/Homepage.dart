import 'dart:developer';

import 'package:apiproject/API/GetAPI/GetAPImodel.dart';
import 'package:apiproject/Color_Fonts_Error/Color-const.dart';
import 'package:apiproject/Statemanegement/DeleteApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../Color_Fonts_Error/Fonts.dart';
import '../Componet/UserIfo.dart';
import '../Statemanegement/getapimanega.dart';
import 'Creat_Update.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<getapimodel>? users;
  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     context.read<getapimanege>().getapi().then((value) {

       if(value!.sucsse && value.data != null)
         {
           users = value.data;
           setState(() {});

         }
     });
   });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provaider = context.watch<getapimanege>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Users",style: TextStyle(color: Colors.black)),
      ),
      floatingActionButton: ElevatedButton.icon(onPressed: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => CreatUpdate(),));
      }, icon: Icon(Icons.add), label: Text("Add")),
      body: SafeArea(
          child:   provaider.isloding ==false ? users != null? ListView.builder(
            shrinkWrap: true,
            itemCount: users!.length,
              itemBuilder: (context, index) {
            final user = users!.elementAt(index);
                return Slidable(
                  startActionPane: ActionPane(
                      motion: ScrollMotion(),

                      children: [

                        SlidableAction(onPressed: (context) {
                          final Delete = context.read<DeleteApi>().deleteapi(id:  user.id!);
                          users!.removeAt(index);
                          log("delete ${Delete} $index ${user.id}");
                        }, icon: Icons.delete_outline,
                          backgroundColor: Colors.red,
                        ),
                        // Expanded(
                        //     child: InkWell(
                        //       onTap: (){
                        //
                        //        final Delete = context.read<DeleteApi>().deleteapi(id:  user.id!);
                        //        users!.removeAt(index);
                        //        log(" Delet $Delete");
                        //         setState(() {});
                        //
                        //       },
                        //   child: Container(
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(2),
                        //       color: Colors.red,
                        //     ),
                        //    height: MediaQuery.of(context).size.height*0.24,
                        //     child: Padding(
                        //       padding: const EdgeInsets.all(30),
                        //       child: SvgPicture.asset("assets/icons/trash.svg"),
                        //     ),
                        //   ),
                        // )),
                        // Expanded(
                        //     child: InkWell(
                        //       onTap: (){},
                        //       child: Container(
                        //         height: MediaQuery.of(context).size.height*0.24,
                        //         decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(2),
                        //           color: Colors.green,
                        //         ),
                        //   child: Padding(
                        //       padding: const EdgeInsets.all(30),
                        //       child: SvgPicture.asset("assets/icons/Vector.svg"),
                        //   ),
                        // ),
                        //     )),
                      ]),
                  endActionPane: ActionPane(motion: ScrollMotion(), children: [
                    Expanded(
                        child: InkWell(
                          onTap: (){},
                          child: Container(
                            height: MediaQuery.of(context).size.height*0.24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(2),
                              color: Colors.green,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(70),
                              child: SvgPicture.asset("assets/icons/pen.svg"),
                            ),
                          ),
                        ))

                  ]),


                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueGrey.shade200,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color:AppPrimary.withOpacity(0.7),)
                      ),
                      height: 200,
                      width: double.infinity,
                      // color: AppPrimary.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 120,
                                  width: 100,
                                  child: user.image != null?  Image.network("${user.image}",fit: BoxFit.fill,): Image.asset("assets/images/avatar-default-symbolic-icon-512x488-rddkk3u9.png"),
                                ),
                                SizedBox(width: 15,),
                               Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                 Userdetiles(color: AppPrimary,title: '${user.name}', SvgPath: 'assets/icons/user.svg',),
                                 SizedBox(height: 5,),
                                 Userdetiles(color: AppPrimary,title: '${user.mobile}', SvgPath: 'assets/icons/phone.svg',),
                                 SizedBox(height: 5,),
                                 Userdetiles( color: AppPrimary ,title: '${user.email}', SvgPath: 'assets/icons/envelope.svg',),
                                 //SizedBox(height: 5,),
                                   Userdetiles(color: AppPrimary,   title:user.age!=null? '${user.age}':'-', SvgPath: 'assets/icons/calendar.svg',),
                               ],)
                              ],),
                            SizedBox(height: 10,),
                            Row(
                              // mainAxisSize:MainAxisSize.min
                              children: [
                                SvgPicture.asset("assets/icons/location-pin.svg",
                                  width: 20,
                                  height: 20,
                                  color: AppPrimary,
                                ),
                                SizedBox(width: 10,),
                                Expanded(
                                  child: Text(
                                   user.address !=null ? "${user.address}":'-',
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: MyTextStyle.medium.copyWith(
                                      fontSize: 14.5,
                                      color: Colors.black,
                                    ),),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },): Center(child: Text("Error"),):Center(child: CupertinoActivityIndicator()),
      ),

    );
  }
}
