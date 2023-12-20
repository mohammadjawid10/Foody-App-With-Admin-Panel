import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/app_colors.dart';
import 'image_widget.dart';

class CustomNormalAppbar extends StatelessWidget{
final String title;
   const CustomNormalAppbar({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteColor,
      automaticallyImplyLeading: false,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
              onTap: (){
               Get.back();
              },
              child: iconWidget(img: 'back-button.png',size: 21)),
          Center(
            child: Text(title,style: GoogleFonts.notoSans(
              textStyle: const TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700),
            ),),
          ),
          const SizedBox(),
        ],
      ),
    );

  }
}