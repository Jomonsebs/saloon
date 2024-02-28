//AppFonts,AppColors,AppStyles,AppStrings,iconsList,iconTitleList,settingsList,settingsListIcon

import 'dart:ui';

import 'package:estilo_salon/utils/image_strings.dart';
import 'package:estilo_salon/widgets/appbar.dart';
import 'package:flutter/material.dart';

class AppFonts {
  static String nunito = "nunito", nunitoBold = "nunito_bold";
}

class AppSizes {
  static const size12 = 12,
               size14 = 14,
               size16 = 16,
               size18 = 18,
               size20 = 20;

}


class AppColors {
  static Color primaryColor = Color(0xff2A7FBA),
  yellowColor = Color(0xffFF9F00),
  bgColor = Color(0xffF5F5F5),
  textColor = Colors.black,
  bgDarkColor = Color(0xffECECEC);
}


class AppStyles {
  static normal({String? title, Color? color, double? size}) {
    return Text(title ?? '', style: TextStyle(color: color ?? Colors.black,
    fontSize: size,
    ),
    );

    //return title.text.size(size).color(color).make();
  }
  static bold({String? title, Color? color, double? size}) {
    return Text(title ?? '',style: TextStyle(color: color ?? Colors.black,fontSize: size,fontFamily: AppFonts.nunitoBold,
    ),
    );

   // return title.text.size(size).color(color).fontFamily(AppFonts.nunitoBold).make();
  }
}

class AppStrings {
 static String category = "Category",
                 doctor = "Doctor Login",
                settings = "Settings",
                 body = "Body",
                  ear = "Ear",
                clipper = "Clipper",
             scissoricon = "Scissoricon",

      changepassword = "Change Password",
      termsconditions = "Terms & Conditions",
      signout = "Signout";
}

var iconsList = [
  TImages.scissoricon,
  TImages.clipper,
  TImages.scissoricon,
  TImages.clipper,
  TImages.scissoricon,
  TImages.clipper,
  TImages.scissoricon,
  TImages.clipper,
  TImages.scissoricon,
  TImages.clipper,
];

var iconsTitleList = [
  AppStrings.body,
  AppStrings.clipper,
  AppStrings.scissoricon,
  AppStrings.clipper,
  AppStrings.body,
  AppStrings.ear,
  AppStrings.clipper,
  AppStrings.scissoricon,
  AppStrings.clipper,
  AppStrings.clipper,
];

var settingsList = [
  AppStrings.changepassword,
  AppStrings.termsconditions,
  AppStrings.signout,
];

var settingsListIcon = [
  Icons.lock,
  Icons.note,
  Icons.logout,
];

