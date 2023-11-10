import 'dart:convert';
import 'dart:developer';
import 'package:clovi_template/models/video_model.dart';
import 'package:clovi_template/views/components/splash_screen.dart';
// import 'package:clovi_template/services/remote_service.dart';
// import 'package:clovi_template/views/time_control_widget.dart';
import 'package:clovi_template/views/video_player_screen.dart';
import 'package:clovi_template/views/video_ui_page.dart';
import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:clovi_template/views/components/bottom_nav_bar.dart';

class VideoPage extends StatefulWidget {
  const VideoPage({super.key});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  List<String> urls = [
    'https://api.clovi.app/api/v1/videos?videoUrl=ovjZC0yeBkg',
    'https://api.clovi.app/api/v1/videos?videoUrl=dMqofHwI1MI',
    'https://api.clovi.app/api/v1/videos?videoUrl=ezNbBuO7_i4',
    'https://api.clovi.app/api/v1/videos?videoUrl=pKdS4ukwB24',
    'https://api.clovi.app/api/v1/videos?videoUrl=hTLdiYdwj5A',
    'https://api.clovi.app/api/v1/videos?videoUrl=a3F9Bf-sb_w',
    'https://api.clovi.app/api/v1/videos?videoUrl=mAfwiwHduxY',
    'https://api.clovi.app/api/v1/videos?videoUrl=sIuxA77B6uk',
    'https://api.clovi.app/api/v1/videos?videoUrl=0-BXWBhhzNk',
    'https://api.clovi.app/api/v1/videos?videoUrl=7U74B9Zee6M',
  ];

  Future<Video>? video;
  Future<List<Video>>? videos;

  // Future<Video> getVideoApi() async {
  //   var uri =
  //       Uri.parse('https://api.clovi.app/api/v1/videos?videoUrl=ovjZC0yeBkg');
  //   final response = await http.get(uri);

  //   // var data = jsonDecode(response.body.toString());
  //   var data = jsonDecode(utf8.decode(response.bodyBytes));
  //   if (response.statusCode == 200) {
  //     return Video.fromJson(data);
  //   } else {
  //     return Video.fromJson(data);
  //   }
  // }

  Future<List<Video>> getVideoApis(List<String> urls) async {
    List<Video> videos = [];

    for (String url in urls) {
      var uri = Uri.parse(url);
      final response = await http.get(uri);

      var data = jsonDecode(utf8.decode(response.bodyBytes));
      videos.add(Video.fromJson(data));
    }
    log("getVideosAPI");
    return videos;
  }

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    // video = getVideoApi();
    // videos = getVideoApis(urls);
    log("initState");
  }

  void directToItemInfoPage(Video video, String dir) async {
    // video.ypController.pause();
    await Navigator.pushNamed(context, dir, arguments: {
      'controller': video.ypController,
      'timeShopItems': video.data?.timeShopItemLists,
      'model': video.data!.timeShopItemLists![0].model!,
      'video': video,
      'profileImgUrl': video.data!.profileImgUrl,
    });
    video.ypController?.play();
  }

  // with TimeControlWidget
  // Widget videoWidget(Video video) {
  //   return Column(
  //     children: <Widget>[
  //       Expanded(
  //         child: GestureDetector(
  //           onHorizontalDragEnd: (details) {
  //             if (details.velocity.pixelsPerSecond.dx < 0) {
  //               directToItemInfoPage(video, 'item_info');
  //             }
  //           },
  //           child: YoutubePlayer(
  //             controller: video.ypController!,
  //             showVideoProgressIndicator: true,
  //           ),
  //         ),
  //       ),
  //       TimeControlWidget(
  //         ypController: video.ypController!,
  //         video: video,
  //         refresh: false,
  //       ),
  //     ],
  //   );
  // }

  // For bottom navigation bar
  int _currentIndex = 0;
  void _onItemTapped(int index) {
    // Handle item selection
    if (index == 0) {
      Navigator.pushNamed(context, 'video');
    } else if (index == 1) {
      Navigator.pushNamed(context, 'survey_page');
    } else if (index == 2) {
      Navigator.pushNamed(context, 'survey_page');
    }
    _currentIndex = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Video>>(
        future: getVideoApis(urls),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return PreloadPageView.builder(
              // itemCount: snapshot.data!.length,
              scrollDirection: Axis.vertical,
              preloadPagesCount: snapshot.data!.length - 1,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    // videoWidget(snapshot.data![index % snapshot.data!.length]),
                    VideoPlayerScreen(
                        video: snapshot.data![index % snapshot.data!.length]),
                    VideoUIPage(
                        video: snapshot.data![index % snapshot.data!.length]),
                  ],
                );
              },
              controller: PreloadPageController(initialPage: 0),
              onPageChanged: (value) {
                snapshot.data![value % snapshot.data!.length].ypController!
                    .play();
                // currentIndex = value;
              },
            );
          } else {
            return splash(context);
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).highlightColor,
        items: BottomNavItems.items,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
