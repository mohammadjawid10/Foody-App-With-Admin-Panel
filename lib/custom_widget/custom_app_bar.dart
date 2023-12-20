import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:liefermars/custom_widget/image_widget.dart';

import '../controller/general_screens_controller/custom_appbar_controller.dart';
import '../utils/app_colors.dart';
import 'custom_text_style.dart';

class CustomAppBar extends GetView<CustomAppBarController>{
  final dynamic onTap;
  const CustomAppBar({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          iconWidget(img: 'location-icon.png',size: 30),
          Expanded(child: Obx(()=> GestureDetector(
              onTap: () async{
                Prediction? p = await PlacesAutocomplete.show(
                    context: context,
                    apiKey: controller.kGoogleApiKey,
                    mode: controller.mode,
                    language: 'en',
                    strictbounds: false,
                    types: [""],
                    decoration: InputDecoration(
                        hintText: 'Search',
                        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(20), borderSide: const BorderSide(color: Colors.white))),
                    components: [Component(Component.country,"pk"),Component(Component.country,"de")]);
                if(p!=null) {
                  controller.displayPrediction(p);
                }
              },
              child: Text(controller.address.value,style: heading1(color: AppColors.blackColor,fontSize: 16),maxLines: 1,overflow: TextOverflow.ellipsis)))),
          const SizedBox(width: 53,),
          GestureDetector(
              onTap: onTap,
              child: iconWidget(img: 'menu-icon.png',size: 30))
        ],
      ),
    );
  }

}