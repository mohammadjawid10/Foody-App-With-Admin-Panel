import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widget/custom_text_style.dart';
import '../../custom_widget/image_widget.dart';
import '../../utils/app_colors.dart';

class RestaurantGeneralTermsAndConditionScreen extends StatelessWidget{
  const RestaurantGeneralTermsAndConditionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21,vertical: 31),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                          onTap: (){
                            Get.back();
                          },
                          child: iconWidget(img: 'back-button.png',size: 21)),
                      SizedBox(width: 10,),
                      Flexible(
                        flex: 1,
                        child: Center(
                          child: Text('Restaurant General Terms and  Condition',textAlign:TextAlign.center,style: heading1SemiBold(color: AppColors.blackColor,fontSize: 25),),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 86,),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.textFieldBackgroundColor,
                        borderRadius: BorderRadius.circular(5),
                        boxShadow: [
                          BoxShadow(
                              color: AppColors.greyColor,
                              offset: const Offset(0.0, 5.0),
                              blurRadius: 3.0,
                              spreadRadius: 4
                          ),
                        ]
                    ),
                    child: Text('Kontaktdaten des Verantwortlichen [Unternehmensname mit Rechtsformzusatz] [Gesetzlicher Vertreter] [Anschrift] [Telefonnummer] [Faxnummer] [E-Mail-Adresse] Wir begrüßen Sie auf unserer Webseite. Der Schutz Ihrer Daten ist uns sehr wichtig. Deshalb zeigen wir Ihnen nachfolgend auf, wie wir Ihre personenbezogenen Daten verarbeiten. Allgemeine Verarbeitung von Besucherdaten Die Nutzung unserer Webseite ist grundsätzlich ohne die Angabe personenbezogener Daten möglich. Wir weisen jedoch darauf hin, dass auch in diesem Fall Zugriffsdaten erhoben und in den Server-Log-Files gespeichert werden. Hierbei handelt es sich insbesondere um folgende',
                      style: heading1(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}