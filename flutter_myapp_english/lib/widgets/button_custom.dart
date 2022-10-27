import 'package:flutter/material.dart';
import 'package:flutter_myapp_english/values/app_colors.dart';
import 'package:flutter_myapp_english/values/app_styles.dart';

class AppButton extends StatelessWidget {
  final String lable;
  final VoidCallback onTap;

  const AppButton({Key? key, required this.lable, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
 
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(3, 6),
              blurRadius: 6,
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: Text(
          lable,
          style: AppStyles.h5.copyWith(color: AppColors.textColor),
        ),
      ),
    );
  }
}
