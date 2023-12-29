import 'package:flutter/material.dart';
import 'package:wmax_devs_task/View/common_widget/custom_text_widget.dart';

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({
    super.key,
    required this.title,
    required this.titleData,
  });
  final String title;
  final String titleData;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: CustomTextWidget(
            text: title,
            fSize: 20,
            fWeight: FontWeight.w400,
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          flex: 5,
          child: CustomTextWidget(
            text: titleData,
            fSize: 20,
            fWeight: FontWeight.w400,
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}
