import 'package:clovi_template/views/channel_page.dart';
import 'package:clovi_template/views/shorts_video_page.dart';
import 'package:clovi_template/views/components/splash_screen.dart';
import 'package:clovi_template/views/survey_page.dart';
import 'package:flutter/material.dart';
import 'views/video_page.dart';
import 'views/item_detail_page.dart';
import 'views/item_info_page.dart';
import 'utils/color_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
      initialRoute: '/',
      routes: {
        'video': (context) => VideoPage(),
        'item_info': (context) => ItemInfoPage(),
        'item_detail': (context) => ItemDetailPage(),
        'shorts_video': (context) => ShortsVideoPage(),
        'channel': (context) => ChannelPage(),
        'survey_page': (context) => SurveyPage(),
      },
      home: SplashScreen(),
    );
  }
}
