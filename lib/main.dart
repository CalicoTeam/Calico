import 'package:clovi_template/views/home_page.dart';
import 'package:clovi_template/views/shorts_video_page.dart';
import 'package:flutter/material.dart';
import 'views/login_page.dart';
import 'views/video_page.dart';
import 'views/item_detail_page.dart';
import 'views/item_info_page.dart';
import 'utils/color_utils.dart';

void main() {
  // String initialRoute = "login";
  // runApp(MyApp(initialRoute: initialRoute));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // const MyApp({Key? key, required this.initialRoute}) : super(key: key);
  // final String initialRoute;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: CalicoColors.representBlack,
        primaryColorLight: CalicoColors.representWhite,
        highlightColor: CalicoColors.representOrange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: "login",
      routes: {
        'login': (context) => LoginPage(),
        'video': (context) => VideoPage(),
        'item_info': (context) => ItemInfoPage(),
        'item_detail': (context) => ItemDetailPage(),
        'shorts_video': (context) => ShortsVideoPage(),
      },
      home: HomePage(),
    );
  }
}
