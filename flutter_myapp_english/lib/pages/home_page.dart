import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_myapp_english/models/english_today.dart';
import 'package:flutter_myapp_english/packages/quote/quote.dart';
import 'package:flutter_myapp_english/pages/all_pages.dart';
import 'package:flutter_myapp_english/pages/control_page.dart';
import 'package:flutter_myapp_english/values/app_assets.dart';
import 'package:flutter_myapp_english/values/app_colors.dart';
import 'package:flutter_myapp_english/values/app_styles.dart';
import 'package:flutter_myapp_english/widgets/button_custom.dart';
import 'package:like_button/like_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../packages/quote/qoute_model.dart';

class HomePages extends StatefulWidget {
  const HomePages({Key? key}) : super(key: key);

  @override
  State<HomePages> createState() => _HomePagesState();
}

class _HomePagesState extends State<HomePages> {
  //! Tạo biến chạy khi vuốt box
  int currentIndex = 0;
  late PageController pageController;
  late SharedPreferences preferences;

  //!Khởi tạo tạo list data các từ tiếng anh
  List<EnglishToday> listWords = [];
  String qoute = Quotes().getRandom().content!;

  get buttonSize => null;

  //TODO: phương thức lấy random
  List<int> fixedListRandom({int len = 1, int max = 120, int min = 1}) {
    if (len > max || len < min) {
      return [];
    }
    List<int> newList = [];
    Random random = Random();
    int count = 1;
    while (count <= len) {
      int val = random.nextInt(max);
      if (newList.contains(val)) {
        continue;
      } else {
        newList.add(val);
        count++;
      }
    }
    return newList;
  }

//! Lấy phần tử từ package english-word của flutter
  getEnglishToday() async {
    //!Lấy phẩn từ từ data bên your control

    preferences = await SharedPreferences.getInstance();
    int lens = preferences.getInt('counter') ?? 5;

    List<String> newList = [];

    List<int> rans = fixedListRandom(len: lens, max: nouns.length);

    setState(() {
      for (var index in rans) {
        newList.add(nouns[index]);
      }
      listWords = newList.map((e) => getQouteContent(e)).toList();
    });
  }

  //! tạo đối tượng để lấy content có sẵn từ data
  EnglishToday getQouteContent(String noun) {
    Quote? quote;
    quote = Quotes().getByWord(noun);
    return EnglishToday(noun: noun, quote: quote?.content, id: quote?.id);
  }

  //! Tạo key
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  //!Mặc định kích thước box trong hàm chạy
  @override
  void initState() {
    //TODO: tương tự hàm onStart
    pageController = PageController(viewportFraction: 0.9);
    super.initState();
    getEnglishToday();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey, //!Gán key
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
            scaffoldKey.currentState?.openDrawer();
          },
          child: Image.asset(AppAssets.menu),
        ),
      ),

      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Container(
              height: size.height * 1 / 10, //! Lấy tỉ lệ toàn khung hình
              padding: const EdgeInsets.all(16),
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Text(
                  '"$qoute"',
                  style: AppStyles.h5
                      .copyWith(fontSize: 15, color: AppColors.textColor),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 2 / 3,
              child: PageView.builder(
                //! khỏi tạo biến chạy
                controller: pageController,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemCount: listWords.length > 5 ? 6 : listWords.length,
                itemBuilder: (context, index) {
                  //? Lấy kí tự đầu và phần còn lại theo form design
                  String? fistLetter = listWords[index].noun != null
                      ? listWords[index].noun!.trim()
                      : '';

                  fistLetter = fistLetter.substring(0, 1).toUpperCase();

                  String? lastLetters = listWords[index].noun != null
                      ? listWords[index].noun!.trim()
                      : '';

                  lastLetters = lastLetters
                      .substring(1, lastLetters.length)
                      .toLowerCase();

                  //? lấy content
                  String qouteConten =
                      'Think of all the beauty still left around you and be happy';
                  String qoutes = listWords[index].quote != null
                      ? listWords[index].quote!
                      : qouteConten;

                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Material(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      color: AppColors.primaryColor,
                      elevation: 4,
                      child: InkWell(
                        onDoubleTap: () {
                          setState(() {
                            listWords[index].isFavorite =
                                !listWords[index].isFavorite;
                          });
                        },
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        splashColor: Colors.transparent,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          child: index >=
                                  5 //! Tạo show more khi box có hơn 5 đối tượng
                              ? InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => AllWordsPage(
                                                listWords: listWords)));
                                  },
                                  child: Center(
                                    child: Text(
                                      'Show more...',
                                      style: AppStyles.h3.copyWith(
                                        shadows: [
                                          const BoxShadow(
                                            color: Colors.black38,
                                            offset: Offset(3, 6),
                                            blurRadius: 10,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              : Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //!Tạo animation cho icon
                                    LikeButton(
                                      onTap: (bool isLiked) async {
                                        setState(() {
                                          listWords[index].isFavorite =
                                              !listWords[index].isFavorite;
                                        });
                                        return listWords[index].isFavorite;
                                      },
                                      isLiked: listWords[index].isFavorite,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      size: 55,
                                      circleColor: const CircleColor(
                                          start: Color(0xff00ddff),
                                          end: Color(0xff0099cc)),
                                      bubblesColor: const BubblesColor(
                                        dotPrimaryColor: Color(0xff33b5e5),
                                        dotSecondaryColor: Color(0xff0099cc),
                                      ),
                                      likeBuilder: (bool isLiked) {
                                        return ImageIcon(
                                          const AssetImage(
                                            AppAssets.heart,
                                          ),
                                          color: isLiked
                                              ? Colors.red
                                              : Colors.white,
                                          size: 55,
                                        );
                                        // return Icon(
                                        //   Icons.home,
                                        //   color: isLiked
                                        //       ? Colors.deepPurpleAccent
                                        //       : Colors.grey,
                                        //   size: 55,
                                        // );
                                      },
                                    ),

                                    // Container(
                                    //     alignment: Alignment.centerRight,
                                    //     child: Image.asset(
                                    //       AppAssets.heart,
                                    //       color: listWords[index].isFavorite
                                    //           ? Colors.red
                                    //           : Colors.white,
                                    //     )),
                                    RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.start,
                                      text: TextSpan(
                                        text: fistLetter,
                                        style: const TextStyle(
                                          fontFamily: FontFamily.sen,
                                          fontSize: 80,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            BoxShadow(
                                              color: Colors.black38,
                                              offset: Offset(3, 6),
                                              blurRadius: 10,
                                            )
                                          ],
                                        ),
                                        children: [
                                          TextSpan(
                                            text: lastLetters,
                                            style: const TextStyle(
                                              fontFamily: FontFamily.sen,
                                              fontSize: 50,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 3,
                                              shadows: [
                                                BoxShadow(
                                                  color: Colors.black38,
                                                  offset: Offset(3, 6),
                                                  blurRadius: 10,
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: AutoSizeText(
                                        '"$qoutes"',
                                        maxLines: 5,
                                        overflow: TextOverflow.ellipsis,
                                        minFontSize: 20,
                                        style: AppStyles.h4.copyWith(
                                          fontSize: 23,
                                          letterSpacing: 1,
                                          color: const Color.fromARGB(
                                              255, 0, 0, 0),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            //! indicator: thanh trạng thái khi cuộn - Nằm ngoài box nội dung
            Container(
              height: 10,
              margin: const EdgeInsets.symmetric(vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 22),
              alignment: Alignment.center,
              child: SizedBox(
                child: ListView.builder(
                    physics:
                        const NeverScrollableScrollPhysics(), //!Cố định icon cuốn
                    scrollDirection: Axis.horizontal,
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return buildIndicator(index == currentIndex, size);
                    }),
              ),
            ),
          ],
        ),
      ),

      //! Icon ở cuối

      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20,right: 20),
        child: FloatingActionButton(
          backgroundColor: AppColors.primaryColor,
          onPressed: () {
            setState(() {
              getEnglishToday();
            });
          },
          child: Image.asset(AppAssets.exchange),

        ),
      ),

      //! Xử lí icon menu
      drawer: Drawer(
        child: Container(
          color: AppColors.lighBlue,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, //! Dồn phần tử
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 35, left: 15),
                child: Text(
                  'Your mind',
                  style: AppStyles.h3.copyWith(color: AppColors.textColor),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(lable: 'Favorites', onTap: () {}),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: AppButton(
                    lable: 'Your control',
                    onTap: () {
                      //! Tương tự intent bên android
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const ControlPage())
                              );
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isAcitve, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      margin: const EdgeInsets.symmetric(horizontal: 15),
      width: isAcitve ? size.width * 1 / 6 : 24,
      decoration: BoxDecoration(
        color: isAcitve ? AppColors.lighBlue : AppColors.lightGrey,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        boxShadow: const [
          BoxShadow(color: Colors.black38, offset: Offset(2, 3), blurRadius: 6)
        ],
      ),
    );
  }
}
