import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_myapp_english/packages/quote/quote.dart';
import 'package:flutter_myapp_english/pages/Landing_page.dart';

void main() async {
  //!Khởi tạo trước câu nội dung english
  WidgetsFlutterBinding.ensureInitialized();
  await Quotes.getAll();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      title: 'English Today',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LandingPages(),
    );
  }
}
