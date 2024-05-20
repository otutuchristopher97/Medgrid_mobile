import 'package:flutter/material.dart';
import 'package:medgrid_app/core/components/texts/custom_text.dart';
import 'package:medgrid_app/core/pallet.dart';

catalystSnackMessage({
  BuildContext? context,
  String? message,
  Function? onClick,
  String? actionButtonTitle,
  String errorTitle = "Oops!",
}) {
  return showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 40.0, left: 20.0, bottom: 20.0, right: 20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 0.07,
                        child: Center(
                          child: CustomText(
                            text: message!.isEmpty ? "Try again" : message,
                            color: Pallet.black,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            onClick == null
                                ? Navigator.of(context).pop()
                                : onClick();
                          },
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Pallet.error700Color,
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                              child: CustomText(
                                text: actionButtonTitle ?? "Try Again",
                                weight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                top: -30,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Pallet.error700Color),
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      });
}
