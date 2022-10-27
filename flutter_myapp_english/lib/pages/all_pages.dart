import 'package:flutter/material.dart';
import 'package:flutter_myapp_english/models/english_today.dart';
import 'package:flutter_myapp_english/values/app_assets.dart';
import 'package:flutter_myapp_english/values/app_colors.dart';
import 'package:flutter_myapp_english/values/app_styles.dart';

class AllWordsPage extends StatelessWidget {
  final List<EnglishToday> listWords;

  const AllWordsPage({Key? key, required this.listWords}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.secondColor,
        appBar: AppBar(
          backgroundColor: AppColors.secondColor,
          elevation: 0, //! Mất đường viền của appBar với body
          title: Text(
            'English today',
            style:
                AppStyles.h3.copyWith(color: AppColors.textColor, fontSize: 30),
          ),
          leading: InkWell(
            //! Sự kiện on click
            onTap: () {
              Navigator.pop(context);
            },
            child: Image.asset(AppAssets.leftArrow),
          ),
        ),
        body: ListView.builder(
            itemCount: listWords.length,
            itemBuilder: (context, index) {
              String? fistLetter = listWords[index].noun != null
                  ? listWords[index].noun!.trim()
                  : '';
              fistLetter = fistLetter.substring(0, 1).toUpperCase();

              String? lastLetters = listWords[index].noun != null
                  ? listWords[index].noun!.trim()
                  : '';

              lastLetters =
                  lastLetters.substring(1, lastLetters.length).toLowerCase();
              return Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: (index % 2 == 0)
                      ? const Color.fromARGB(255, 160, 201, 237)
                      : const Color.fromARGB(255, 226, 246, 245),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                child: ListTile(
                    contentPadding: const EdgeInsets.all(16),
                    title: Text(
                      fistLetter + lastLetters,
                      style: AppStyles.h4.copyWith(
                          fontWeight: FontWeight.bold,
                          color: (index % 2 == 0)
                              ? const Color.fromARGB(255, 50, 119, 239)
                              : const Color.fromARGB(255, 236, 172, 94)),
                    ),
                    subtitle: Text(
                      listWords[index].quote ??
                          '"Think of all the beauty still left around you and be happy"',
                      style: AppStyles.h5.copyWith(
                        color: const Color.fromARGB(255, 122, 118, 120),
                      ),
                    ),
                    leading: Icon(
                      Icons.favorite,
                      color: listWords[index].isFavorite
                          ? Colors.red
                          : Colors.grey,
                    )),
              );
            }));
  }
}
