// Import Flutter material package
import 'package:flutter/material.dart';
import 'package:bethesda_2/constants/colors.dart'; // Adjust the import path as necessary
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenBreakpoints {
  static const double mobile = 600.0;  // Mobile breakpoint (e.g., width < 600 for small devices)
  static const double tablet = 768.0;  // Tablet breakpoint
  static const double desktop = 1024.0; // Desktop breakpoint
}
// Define MyTextStyles class
class MyTextStyles {

  static TextStyle bekezdes(BuildContext context) {
    // Get current screen width from the MediaQuery
    //double screenWidth =;
    // Decide on the font size based on the screen width
    //double fontSize =

    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize:  MediaQuery.of(context).size.width < ScreenBreakpoints.mobile ? 10.sp : 16.sp,
      fontStyle: FontStyle.italic,

      color: AppColors.darkshade,
    );
  }
  static TextStyle nagybekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 20.sp,  // This scales based on the screen width
      color: AppColors.darkshade, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle bluebekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 16.sp,  // This scales based on the screen width
      color: AppColors.blueish, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle huszonkettobekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 22.sp,  // This scales based on the screen width
      color: AppColors.darkshade, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle huszonegybekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 21.sp,  // This scales based on the screen width
      color: AppColors.darkshade, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle vastagbekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 16.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold,
      color: AppColors.darkshade, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle vastagblueish(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 16.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold,
      color: AppColors.blueish, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle vastagyellow(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 18.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold,
      color: AppColors.yellow, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle vastagnagybekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 20.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold,
      color: AppColors.darkshade, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle feherbekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 16.sp,  // This scales based on the screen width
      color: AppColors.lightshade, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle cim(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 20.sp,  // This scales based on the screen width
      color: AppColors.bethesdacolor, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle bethesdabekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 18.sp,  // This scales based on the screen width
      color: AppColors.bethesdacolor, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle bethesdavastagbekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 18.sp,  // This scales based on the screen width
      color: AppColors.bethesdacolor, // Replace with your color variable if you have a custom one like AppColors.darkshade
      fontWeight: FontWeight.bold, // This scales based on the screen width
    );
  }

  static TextStyle fehercim(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 20.sp,  // This scales based on the screen width
      color: AppColors.whitewhite, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle feherkovercim(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 20.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold, // This scales based on the screen width
      color: AppColors.whitewhite, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle feherkicsikovercim(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 16.sp,
      fontWeight: FontWeight.bold, // This scales based on the screen width
      color: AppColors.whitewhite, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle gomb(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 20.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold,
      color: AppColors.whitewhite, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle szinesgomb(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 20.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold,
      color: AppColors.lightaccentcolor, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle bethesdagomb(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 24.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold,
      color: AppColors.bethesdacolor, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle bluegomb(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 22.sp,  // This scales based on the screen width
      fontWeight: FontWeight.bold,
      color: AppColors.blueish, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle kicsibekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 14.sp,  // This scales based on the screen width
      color: AppColors.darkshade, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle kicsibluebekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 14.sp,  // This scales based on the screen width
      color: AppColors.blueish,
      fontWeight: FontWeight.bold,
// Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle kicsiszinesbekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 14.sp,  // This scales based on the screen width
      color: AppColors.lightaccentcolor, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
  static TextStyle kicsisbethesdabekezdes(BuildContext context) {
    return TextStyle(
      fontFamily: 'Open_Sans.light',
      fontSize: 14.sp,  // This scales based on the screen width
      color: AppColors.bethesdacolor, // Replace with your color variable if you have a custom one like AppColors.darkshade
    );
  }
}
