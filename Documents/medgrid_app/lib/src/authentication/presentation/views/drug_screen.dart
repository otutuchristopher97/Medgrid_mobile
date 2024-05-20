import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:medgrid_app/core/components/custom_elevated_button.dart';
import 'package:medgrid_app/core/components/texts/custom_text.dart';
import 'package:medgrid_app/core/routing/routes.dart';

class DrugScreen extends StatelessWidget {
  const DrugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(text: "Welcome to MedGrid App", size: 20, weight: FontWeight.w600,),
            SizedBox(height: 100,),
            CustomText(text: "Click on the button below to scan QR Code to see drug detail"),
            SizedBox(height: 40,),
            SizedBox(
              width: MediaQuery.of(context).size.width/2,
              height: 50,
              child: CustomElevatedButton(label: 'Scan QR', onPressed: (){
                context.push(RouteConstants.qrScreen);
              },))
          ],
        ),
      ),
    );
  }
}