import 'package:flutter/material.dart';
import 'package:flutter_myapp_english/pages/home_page.dart';
import 'package:flutter_myapp_english/values/app_assets.dart';
import 'package:flutter_myapp_english/values/app_colors.dart';
import 'package:flutter_myapp_english/values/app_styles.dart';
import 'package:flutter_myapp_english/values/share_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ControlPage extends StatefulWidget {
  const ControlPage({Key? key}) : super(key: key);

  @override
  State<ControlPage> createState() => _ControlPageState();
}

class _ControlPageState extends State<ControlPage> {
  double sliderValue = 5;
  late SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    initDefaultValue();
  }

  initDefaultValue() async {
    preferences = await SharedPreferences.getInstance();
    int value =  preferences.getInt(ShareKeys.counter) ?? 5;
    setState(() {
      sliderValue = value.toDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 236, 252),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 223, 232, 249),
        elevation: 0, //! Mất đường viền của appBar với body
        title: Text(
          'Your control',
          style:
              AppStyles.h3.copyWith(color: AppColors.textColor, fontSize: 30),
        ),
        leading: InkWell(
          //! Sự kiện on click
          
          onTap: () async {
            //!Lưu dữ liệu khi back về
            SharedPreferences preferences =
                await SharedPreferences.getInstance();
            await preferences.setInt('counter', sliderValue.toInt());
           
            Navigator.pop(context);
          },
          child: Image.asset(AppAssets.leftArrow),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Spacer(), //!Đẩy phần tử xuống dưới
            Text(
              'How much a number word a once',
              style: AppStyles.h4.copyWith(
                color: const Color.fromARGB(255, 87, 90, 92),
                fontSize: 21,
              ),
            ),
            const Spacer(),
            Text(
              '${sliderValue.toInt()}',
              style: AppStyles.h1.copyWith(
                color: const Color.fromARGB(255, 129, 168, 226),
                fontSize: 140,
                fontWeight: FontWeight.bold,
              ),
            ),
            //!Thanh kéo
            Slider(
                value: sliderValue,
                min: 5,
                max: 100,
                divisions: 95,
                activeColor: const Color.fromARGB(255, 129, 168, 226),
                onChanged: (value) {
                  setState(() {
                    sliderValue = value;
                  });
                }),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              alignment: Alignment.centerLeft,
              child: Text(
                'slide to set',
                style: AppStyles.h5.copyWith(
                  color: AppColors.textColor,
                  fontSize: 22,
                ),
              ),
            ),
            const Spacer(),
            const Spacer(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
