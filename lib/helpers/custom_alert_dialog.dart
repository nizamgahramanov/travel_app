import 'package:flutter/material.dart';
import 'package:travel_app/helpers/app_large_text.dart';
import 'package:travel_app/helpers/app_light_text.dart';
import 'package:travel_app/helpers/custom_button.dart';

class CustomAlertDialog extends StatefulWidget {
  CustomAlertDialog({
    required this.title,
    this.description,
    required this.popButtonText,
    required this.onPopTap,
    required this.popButtonColor,
    this.isShowActionButton,
    this.actionButtonText,
    this.onTapAction,
    this.actionButtonColor,
  });

  final String title, popButtonText;
  final String? actionButtonText, description;
  final VoidCallback onPopTap;
  final VoidCallback? onTapAction;
  final bool? isShowActionButton;
  final Color? actionButtonColor;
  final Color popButtonColor;
  @override
  _CustomAlertDialogState createState() => _CustomAlertDialogState();
}

class _CustomAlertDialogState extends State<CustomAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: (){
        Navigator.of(context, rootNavigator: true).pop();
        return  Future.value(false);
      },
      child: Dialog(
        elevation: 0,
        backgroundColor: const Color(0xffffffff),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 20),
            AppLargeText(
              text: widget.title,
              color: Colors.black,
              size: 20,
            ),
            const SizedBox(
              height: 8,
            ),
            if (widget.description != null)
              AppLightText(
                text: widget.description!,
                alignment: Alignment.center,
              ),

            const SizedBox(height: 25),
            if (widget.isShowActionButton != null)
              CustomButton(
                onTap: widget.onTapAction!,
                buttonText: widget.actionButtonText!,
                borderRadius: 25,
                margin: 30,
                buttonColor: widget.actionButtonColor,
              ),
            const SizedBox(height: 20),
            CustomButton(
              onTap: widget.onPopTap,
              buttonText: widget.popButtonText,
              borderRadius: 25,
              margin: 30,
              buttonColor: widget.popButtonColor,
            ),
            const SizedBox(height: 20),
            // Container(
            //   width: MediaQuery
            //       .of(context)
            //       .size
            //       .width,
            //   height: 50,
            //   child: InkWell(
            //     highlightColor: Colors.grey[200],
            //     onTap: () {
            //       //do somethig
            //     },
            //     child: Center(
            //       child: Text(
            //         "Continue",
            //         style: TextStyle(
            //           fontSize: 18.0,
            //           color: Theme
            //               .of(context)
            //               .primaryColor,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // Divider(
            //   height: 1,
            // ),
            // Container(
            //   width: MediaQuery
            //       .of(context)
            //       .size
            //       .width,
            //   height: 50,
            //   child: InkWell(
            //     borderRadius: BorderRadius.only(
            //       bottomLeft: Radius.circular(15.0),
            //       bottomRight: Radius.circular(15.0),
            //     ),
            //     highlightColor: Colors.grey[200],
            //     onTap: () {
            //       Navigator.of(context).pop();
            //     },
            //     child: Center(
            //       child: Text(
            //         "Cancel",
            //         style: TextStyle(
            //           fontSize: 16.0,
            //           fontWeight: FontWeight.normal,
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
