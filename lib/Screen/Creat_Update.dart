import 'package:apiproject/API/GetAPI/GetAPImodel.dart';
import 'package:apiproject/Color_Fonts_Error/Color-const.dart';
import 'package:apiproject/Function/Validation.dart';
import 'package:apiproject/Statemanegement/getapimanega.dart';
import 'package:apiproject/Statemanegement/putapi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../Color_Fonts_Error/Fonts.dart';
import '../Componet/My_inputTextFild.dart';
import '../Componet/UserIfo.dart';
import '../Statemanegement/PostApi.dart';

class CreatUpdate extends StatefulWidget {
  getapimodel? json;
   CreatUpdate({super.key ,this.json});

  @override
  State<CreatUpdate> createState() => _CreatUpdateState();
}

class _CreatUpdateState extends State<CreatUpdate> {
  TextEditingController namecontroller = TextEditingController();
  TextEditingController phonecontroller = TextEditingController();
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController agecontroller = TextEditingController();
  TextEditingController addresscontroller = TextEditingController();
  TextEditingController urlcontroller = TextEditingController();

  final phoneFocus = FocusNode();
  final emailFocus = FocusNode();
  final ageFocus = FocusNode();
  final addressFocus = FocusNode();
  final urlFocus = FocusNode();

  String name = '';
  String phone = '';
  String email = '';
  String  age = '';
  String  address = '';
  String  url = '';

  bool  imagecheck = false;
  bool  Update = false;

  final _key = GlobalKey<FormState>();

  @override
  void dispose() {
    namecontroller.dispose();
    phonecontroller.dispose();
    emailcontroller.dispose();
    agecontroller.dispose();
    addresscontroller.dispose();
    urlcontroller.dispose();

    phoneFocus.dispose();
    emailFocus.dispose();
    ageFocus.dispose();
    addressFocus.dispose();
    urlFocus.dispose();

    super.dispose();
  }

  void nextFocus(FocusNode node) => node.requestFocus();


  @override
  void initState() {
    if(widget.json != null)
      {
        Update = true;
        namecontroller = TextEditingController( text:widget.json!.Name);
        namecontroller.text =widget.json!.Name;
        phonecontroller.text =widget.json!.Phone;
        emailcontroller.text =widget.json!.Email;
        if(widget.json!.Age != null && widget.json!.Age != '' ) agecontroller.text=widget.json!.Age.toString();
        if(widget.json!.Url != null && widget.json!.Url != '' ){ imagecheck = true; urlcontroller.text=widget.json!.Url!;}
        if(widget.json!.Address != null && widget.json!.Address != '' )  addresscontroller.text=widget.json!.Address!;
      }
    super.initState();
  }

  Future<void> onSave() async {
    bool validimage = true;
    if(urlcontroller.text.trim().isNotEmpty)
    {
      final image = await urlValidation(url: urlcontroller.text.trim());
      validimage = image;
      imagecheck = true;
      setState(() {});
      print(imagecheck);
      if(image == false)
      {
        Fluttertoast.showToast(msg: "Invalid Image link");
        imagecheck = false;
      }
    }
    if (_key.currentState != null && _key.currentState!.validate() && validimage) {
      //Todo:ApiColling

      Map<String,dynamic> json = {
        "Name": "${namecontroller.text.trim()}",
        "Phone": "${phonecontroller.text.trim()}",
        "Email": "${emailcontroller.text.trim()}",
        if(urlcontroller.text.trim() != '')  "Url":   "${urlcontroller.text.trim()}",
        if(agecontroller.text.trim().isNotEmpty)  "Age":   int.parse(agecontroller.text.trim()),
        if(addresscontroller.text.trim() != '')  "Address": '${addresscontroller.text.trim()}',
      };

      if(widget.json != null)
      {
        context.read<Putapi>().putapi(id: widget.json!.id!, json: json).then((value) async {
          await context.read<getapimanege>().getapi();
          Fluttertoast.showToast(msg: "successful update  ");
          Navigator.pop(context);
        });


      }
      else{
         context.read<Postapi>().postapi(json: json).then((value) async {
          if(value.sucsse)
          {
            // await Future.delayed(Duration(seconds: 10));
            await context.read<getapimanege>().getapi();
            Fluttertoast.showToast(msg: "success Creat");
            Navigator.pop(context);

          }
        });

      }
    }
  }

  @override
  Widget build(BuildContext context) {
   final postprovaider = context.watch<Postapi>();
   final isloding = Update ? context.watch<Putapi>().isputloding : postprovaider.ispostloding;
    return Scaffold(
      appBar: AppBar(
        title: Text(Update ? "Update": "Creat"),
      ),
      floatingActionButton: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppPrimary,
        ),
        onPressed: onSave,
        child:  isloding? SizedBox(
            width: 36,
            child: CupertinoActivityIndicator(color: Colors.white,)) : SizedBox(
          width: 36,
          // height: 25,
          child: Text("Save",
              style: MyTextStyle.medium.copyWith(
                color: Colors.white,
                fontSize: 15,
              )),
        ),
      ),
      body: Form(
        key: _key,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Container(
            // height: 500,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SingleChildScrollView(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black26),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        color: Colors.blueGrey.shade200,
                      ),
                      height: 225,
                      // width: 500,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                imagecheck == false? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white70,
                                  ),
                                  height: 120,
                                  width: 100,
                                  child: Image.asset("assets/images/avatar-default-symbolic-icon-512x488-rddkk3u9.png",fit: BoxFit.fill),
                                ):Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white70,
                                    image: DecorationImage(image: AssetImage("assets/images/avatar-default-symbolic-icon-512x488-rddkk3u9.png"),
                                    fit: BoxFit.fill
                                    )
                                  ),
                                  height: 120,
                                  width: 100,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.asset("assets/images/check-tick-icon-14166.png",fit: BoxFit.fill),
                                  ),
                                ),
                                SizedBox(
                                  width: 15,
                                ),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      if(widget.json!=null)
                                        ...{
                                           Userdetiles( color: AppPrimary , title: widget.json!.Name.isNotEmpty? "${namecontroller.text.trim()}" : name.isEmpty ? "Name": '$name', SvgPath: 'assets/icons/user.svg',),
                                          SizedBox(height: 5,),
                                          Userdetiles( color: AppPrimary ,title: widget.json!.Phone.isNotEmpty ?"${phonecontroller.text.trim()}":  phone.isEmpty ? "Phone": '$phone', SvgPath: 'assets/icons/phone.svg',),
                                          // Userdetiles(color: AppPrimary,title: '$phone', SvgPath: 'assets/icons/phone.svg',),
                                          SizedBox(height: 5,),
                                          Userdetiles( color: AppPrimary ,title: widget.json!.Email.isNotEmpty ? '${emailcontroller.text.trim()}': email.isEmpty ? "Email": '$email', SvgPath: 'assets/icons/envelope.svg',),
                                          SizedBox(height: 5,),
                                          Userdetiles(color: AppPrimary,title: widget.json!.Age != null && widget.json!.Age !='' ? '${agecontroller.text.trim()}' :age.isEmpty ? "Age": '$age', SvgPath: 'assets/icons/calendar.svg',),

                                        }
                                      else...{
                                        Userdetiles( color: AppPrimary , title: name.isEmpty ? "Name": '$name', SvgPath: 'assets/icons/user.svg',),

                                        // Userdetiles(color: AppPrimary,title: '$name', SvgPath: 'assets/icons/user.svg',),
                                        SizedBox(height: 5,),
                                        Userdetiles( color: AppPrimary ,title:  phone.isEmpty ? "Phone": '$phone', SvgPath: 'assets/icons/phone.svg',),

                                        // Userdetiles(color: AppPrimary,title: '$phone', SvgPath: 'assets/icons/phone.svg',),
                                        SizedBox(height: 5,),
                                        Userdetiles( color: AppPrimary ,title:  email.isEmpty ? "Email": '$email', SvgPath: 'assets/icons/envelope.svg',),
                                        //SizedBox(height: 5,),
                                        Userdetiles(color: AppPrimary,title: age.isEmpty ? "Age": '$age', SvgPath: 'assets/icons/calendar.svg',),

                                      },

                                    ],),
                                )
                              ],
                            ),
                            if(widget.json != null)...{
                              SizedBox(
                                height: 15,),
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
                                       widget.json!.Address != null && address != ""?  "$address":'Address',
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
                            }else...{
                              SizedBox(
                                height: 15,

                              ),
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
                                      address != ""?  "$address":'Address',
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
                            },

                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black45.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Container(
                        padding: EdgeInsets.only(top: 65),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: 200,
                                // height:30,

                                // color: Colors.blueGrey,
                                child: My_TextFormField2(
                                  label: "Name",
                                  hinttext: "Enter Name",
                                  onChanged: (name1) {
                                    name = name1;
                                    setState(() {});
                                  },
                                  controller: namecontroller,
                                  onFieldSubmitted: (p0) => nextFocus(phoneFocus),
                                  textInputAction: TextInputAction.done,

                                  validator: (name) {
                                    if (name != null && name.trim().isNotEmpty)
                                      return null;
                                    return "Please enter name";
                                  },
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 200,
                                // height:3

                                // color: Colors.blueGrey,
                                child: My_TextFormField2(
                                  label: "Phone",
                                  onFieldSubmitted: (p0) => nextFocus(emailFocus),
                                  hinttext: 'Enter Number',
                                  onChanged: (phone1) {
                                    phone = phone1;
                                    setState(() {});

                                  },
                                  controller: phonecontroller,
                                  validator: mobileValidate,
                                  focusNode: phoneFocus,
                                  keyboardType: TextInputType.number,
                                  maxlenght: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'))
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),

                              // age and Email
                              Row(
                                children: [
                                  Container(
                                    width: 200,
                                    // height:30,

                                    // color: Colors.blueGrey,
                                    child: My_TextFormField2(
                                      label: "Email",
                                      onChanged: (email1) {
                                        email = email1;
                                        setState(() {});
                                      },
                                      onFieldSubmitted: (p0) =>
                                          nextFocus(ageFocus),
                                      focusNode: emailFocus,
                                      hinttext: "Enter Email",
                                      controller: emailcontroller,
                                      validator: emailValidator,
                                      keyboardType: TextInputType.emailAddress,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Container(
                                    width: 100,
                                    // height:30,

                                    // color: Colors.blueGrey,
                                    child: My_TextFormField2(
                                      label: "Age",
                                      hinttext: "Enter Age",
                                      onChanged: (age1) {
                                        age = age1;
                                        setState(() {});
                                      },
                                      focusNode: ageFocus,
                                      controller: agecontroller,
                                      keyboardType: TextInputType.number,
                                      validator: ageValidation,
                                      onFieldSubmitted: (p0) =>
                                          nextFocus(addressFocus),
                                      inputFormatters: [
                                        FilteringTextInputFormatter.allow(
                                            RegExp('[0-9]'))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              // Address
                              Container(
                                child: My_TextFormField2(
                                  label: "Addrese",
                                  hinttext: "Enter Addrese",
                                  focusNode: addressFocus,
                                  onChanged: (address1) {
                                    address = address1;
                                    setState(() {});
                                  },
                                  onFieldSubmitted: (p0) => nextFocus(urlFocus),
                                  keyboardType: TextInputType.streetAddress,
                                  controller: addresscontroller,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Container(
                                // width: 350,
                                // height:30,
                                // color: Colors.blueGrey,
                                child: My_TextFormField2(
                                  label: "Url",
                                  onChanged: (url1) {
                                    url = url1;
                                  },
                                  hinttext: "Enter image Link",
                                  focusNode: urlFocus,
                                  onFieldSubmitted: (p0) => onSave(),
                                  keyboardType: TextInputType.url,
                                  controller: urlcontroller,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
