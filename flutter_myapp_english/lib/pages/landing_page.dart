import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myapp_english/pages/home_page.dart';
import 'package:flutter_myapp_english/values/app_assets.dart';
import 'package:flutter_myapp_english/values/app_colors.dart';
import 'package:flutter_myapp_english/values/app_styles.dart';

class LandingPages extends StatelessWidget {
  const LandingPages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.centerLeft,
                child: Text('Wellcom to', style: AppStyles.h3),
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'English',
                      style: AppStyles.h2.copyWith(
                          color: AppColors.blackGrey,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text('Qoutes"',
                          textAlign: TextAlign.right,
                          style: AppStyles.h4.copyWith(height: 0.6)),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 72),
                  child: RawMaterialButton(
                    shape: CircleBorder(),
                    fillColor: AppColors.lighBlue,
                    onPressed: () {
                      //! gọi activity mới và có icon quay lại
                      //   Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //           builder: (context) => HomePages()));
                      //!Gọi activity k có nút back
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePages()),(route) => false);
                    },
                    child: Image.asset(
                      AppAssets.rightArrow,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
