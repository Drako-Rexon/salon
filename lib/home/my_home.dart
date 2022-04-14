import 'dart:convert';
import 'dart:core';
import 'package:dropdownfield2/dropdownfield2.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

// ! The below are the packages of app for widgets
import 'package:salon/components/colors_used.dart';
import 'package:salon/home/components/big_card.dart';
import 'package:salon/home/components/bottom_nav_bar.dart';
import 'package:salon/home/components/card_heading.dart';
import 'package:salon/home/components/input_conf_pass.dart';
import 'package:salon/home/components/input_dob.dart';
import 'package:salon/home/components/input_email.dart';
import 'package:salon/home/components/input_fname.dart';
import 'package:salon/home/components/input_pass.dart';
import 'package:salon/home/components/nav_container.dart';
import 'package:salon/home/components/small_card.dart';
import 'package:salon/home/components/upload_image.dart';

String? fName, eMail, pass, confPass, gender;

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  String defGender = "";
  List<String> selectGender = ["Male", "Female"];
  Map responseMap = {"test": "pass"};
  final genderSelected = TextEditingController();
  Future apiCallHttp() async {
    http.Response responseGet;
    responseGet =
        await http.get(Uri.parse('https://anaajapp.com/api/categories'));
    if (responseGet.statusCode == 200) {
      setState(() {
        // responseString = responseGet.body;
        responseMap = json.decode(responseGet.body);
      });
      // print(responseString);
    } else {
      print(responseGet.statusCode);
      // responseString = 'No response form API';
    }
    // var response = await http.get(Uri.https('anaajapp.com', '/api/categories'));
    // if (response.statusCode == 200) {
    //   var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
    //   itemCount = jsonResponse['message'];
    //   print('Number of books about http: $itemCount.');
    // } else {
    //   print('Request failed with status: ${response.statusCode}.');
    // }
  }
  // var response ='';
  // void apiCallHttp() async {
  //   try {
  //     response = await Dio().get('https://anaajapp.com/api/categories');
  //     print(response);
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  void initState() {
    apiCallHttp();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List navIcons = [
      Icons.home,
      Icons.calendar_month,
      Icons.location_on,
      Icons.message,
      Icons.account_circle
    ];
    List navIconName = [
      "Home",
      "Bookings",
      "Nearby",
      "Message",
      "Account",
    ];
    var devSize = MediaQuery.of(context).size;
    int show = 0;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              NavConatiner(),
              CardHeading(title: 'Highest Rated'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: BigCardWidget(),
              ),
              CardHeading(title: 'Services'),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: SmallCard(),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 30,
                  bottom: 30,
                  left: 24,
                  right: 24,
                ),
                child: Divider(
                  thickness: 2,
                  height: 2,
                  color: AppColors.lightergrey,
                ),
              ),
              // From Here the form has started
              UploadImage(),
              InputFieldFName(
                title: "Full Name",
              ),
              InputFieldEMail(
                title: "Email ID",
              ),
              InputFieldCPass(
                title: "Create Password",
                obs: true,
              ),
              InputFieldConfPass(
                title: "Confirm Password",
                obs: true,
              ),

              Container(
                margin: EdgeInsets.only(top: 10, bottom: 20),
                width: (devSize.width - 60),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    border: Border.all(
                      width: 2,
                      color: AppColors.lightGrey,
                    )),
                child: DropDownField(
                  controller: genderSelected,
                  hintText: "Select Gender",
                  enabled: true,
                  itemsVisibleInDropdown: 2,
                  items: selectGender,
                  
                  hintStyle: TextStyle(
                    fontFamily: 'PoppinsReg',
                    color: AppColors.lightGrey,
                    fontSize: 15,
                  ),
                  onValueChanged: (value) {
                    setState(() {
                      defGender = value;
                    });
                  },
                ),
              ),
              InputFieldDoB(title: 'Date of Birth'),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavBar(
          navIcons: navIcons,
          navIconName: navIconName,
        ),
      ),
    );
  }
}