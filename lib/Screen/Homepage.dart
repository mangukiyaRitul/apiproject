import 'package:apiproject/Color_Fonts_Error/Color-const.dart';
import 'package:apiproject/Statemanegement/DeleteApi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../API/GetAPI/GetAPImodel.dart';
import '../Color_Fonts_Error/Fonts.dart';
import '../Componet/UserIfo.dart';
import '../Statemanegement/getapimanega.dart';
import 'Creat_Update.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>   {
  bool search = false;
  List<getapimodel> searshempty = [] ;
  int i =0;
  TextEditingController _controllar =TextEditingController();

  @override
  void initState() {
   WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     context.read<getapimanege>().getapi();
   });
  }

  @override
  Widget build(BuildContext context)  {
    final provaider = context.watch<getapimanege>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Users", style: TextStyle(color: Colors.black)),
        actions: [
         AnimatedContainer(
           duration:Duration(milliseconds: 100),
           curve: Curves.easeOut,
           child: Padding(
             padding: const EdgeInsets.only(left: 0, right: 8,top: 8,bottom: 8),
             child: AnimatedCrossFade(
                 firstChild: Material(
                   color: AppPrimary,
                   child: IconButton(onPressed: (){
                     setState(() {
                       search = true;
                     });
                   }, icon: Icon(Icons.search)),
                 ),
                 secondChild:   SizedBox(
                     width: 280,
                     child: CupertinoSearchTextField(
                       controller: _controllar,
                       onChanged: (value) {
                         final search=_controllar.text.trim();
                         searshempty.clear();
                         if(search.isNotEmpty){
                           for(int i=0 ; i<provaider.users!.length; i++){
                             if(provaider.users!.elementAt(i).name.toLowerCase().contains(search.toLowerCase())){
                               searshempty.add(provaider.users!.elementAt(i));
                               print("selected List : $searshempty");
                             }
                           }
                         } else {
                           print("Something went wrong");
                         }
                         print("search Controller : ${_controllar.text}");
                         setState(() {});
                       },
                       suffixIcon: Icon(Icons.close,size: search ? 25 :17,),
                       suffixMode: OverlayVisibilityMode.always,
                       onSuffixTap: () {
                         setState(() {
                           search = false;
                         });
                       },

                       decoration: BoxDecoration(
                         color: Colors.white60,
                         borderRadius: BorderRadius.circular(30)
                       ),
                     )),
                 crossFadeState: search ? CrossFadeState.showSecond : CrossFadeState.showFirst,
                 duration: Duration(milliseconds: 100)),
           ),
         ),

        ],
      ),
      floatingActionButton: ElevatedButton.icon(onPressed: (){
        Navigator.push(context, CupertinoPageRoute(builder: (context) => CreatUpdate(),));
      }, icon: Icon(Icons.add), label: Text("Add")),
      body: SafeArea(
          child:   provaider.isloding ==false ? provaider.users != null? RefreshIndicator(
           onRefresh: () async {await provaider.getapi();} ,
            child: Column(

              children: [
                Expanded(
                  child: searshempty.isNotEmpty ?  ListView.builder(
                    shrinkWrap: true,
                    itemCount:   searshempty.isNotEmpty ? searshempty.length: provaider.users!.length,
                    itemBuilder: (context, index) {
                    // final user =  provaider.users!.elementAt(index);
                    final user = searshempty.isNotEmpty ? searshempty.elementAt(index) : provaider.users!.elementAt(index);
                        return Slidable(
                          startActionPane: ActionPane(
                              motion: ScrollMotion(),
                              children: [
                                SlidableAction(
                                  onPressed: (context) async{
                                  final Delete = context.read<DeleteApi>().deleteapi(id:  user.id!);
                                  provaider.users!.removeAt(index);
                                  await context.read<getapimanege>().getapi();
                                  print("delete ${Delete} $index ${user.id}");
                                }, icon: Icons.delete_outline,
                                  backgroundColor: Colors.red,
                                  ),
                              ]),
                          endActionPane: ActionPane(motion: ScrollMotion(), children: [
                            Expanded(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => CreatUpdate(json: user,),));
                                  },
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
                                )),
                          ]),


                          child:   Padding(
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
                                          child: user.image == null || user.image == "" ? Image.asset("assets/images/avatar-default-symbolic-icon-512x488-rddkk3u9.png") :Image.network("${user.image}",fit: BoxFit.fill,),
                                        ),
                                        SizedBox(width: 15,),
                                       Flexible(
                                         child: Column(
                                           crossAxisAlignment: CrossAxisAlignment.start,
                                           children: [
                                           Userdetiles(color: AppPrimary,title: '${user.name}', SvgPath: 'assets/icons/user.svg',),
                                           SizedBox(height: 5,),
                                           Userdetiles(color: AppPrimary,title: '${user.mobile}', SvgPath: 'assets/icons/phone.svg',),
                                           SizedBox(height: 5,),
                                           Userdetiles( color: AppPrimary ,title: '${user.email}', SvgPath: 'assets/icons/envelope.svg',),
                                           //SizedBox(height: 5,),
                                             Userdetiles(color: AppPrimary,   title:user.age!= null && user.age != "" ? '${user.age}':'-', SvgPath: 'assets/icons/calendar.svg',),
                                         ],),
                                       )
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
                                           user.address !=null && user.address != '' ? "${user.address}":'-',
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
                      },) : _controllar.text.trim().isEmpty ? ListView.builder(
                    shrinkWrap: true,
                    itemCount:    provaider.users!.length,
                    itemBuilder: (context, index) {
                      // final user =  provaider.users!.elementAt(index);
                      final user = provaider.users!.elementAt(index);
                      return Slidable(
                        startActionPane: ActionPane(
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) async{
                                  final Delete = context.read<DeleteApi>().deleteapi(id:  user.id!);
                                  provaider.users!.removeAt(index);
                                  await context.read<getapimanege>().getapi();
                                  print("delete ${Delete} $index ${user.id}");
                                }, icon: Icons.delete_outline,
                                backgroundColor: Colors.red,
                              ),
                            ]),
                        endActionPane: ActionPane(motion: ScrollMotion(), children: [
                          Expanded(
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, CupertinoPageRoute(builder: (context) => CreatUpdate(json: user,),));
                                },
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


                        child:   Padding(
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
                                        child: user.image == null || user.image == "" ? Image.asset("assets/images/avatar-default-symbolic-icon-512x488-rddkk3u9.png") :Image.network("${user.image}",fit: BoxFit.fill,),
                                      ),
                                      SizedBox(width: 15,),
                                      Flexible(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Userdetiles(color: AppPrimary,title: '${user.name}', SvgPath: 'assets/icons/user.svg',),
                                            SizedBox(height: 5,),
                                            Userdetiles(color: AppPrimary,title: '${user.mobile}', SvgPath: 'assets/icons/phone.svg',),
                                            SizedBox(height: 5,),
                                            Userdetiles( color: AppPrimary ,title: '${user.email}', SvgPath: 'assets/icons/envelope.svg',),
                                            //SizedBox(height: 5,),
                                            Userdetiles(color: AppPrimary,   title:user.age!= null && user.age != "" ? '${user.age}':'-', SvgPath: 'assets/icons/calendar.svg',),
                                          ],),
                                      )
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
                                          user.address !=null && user.address != '' ? "${user.address}":'-',
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
                    },) : const Center(child: Text("User Not Found"),),
                ),
              ],
            ),
          ): Center(child: Text("Error"),):Center(child: CupertinoActivityIndicator()),
      ),

    );
  }
}
