import 'package:clovi_template/models/video_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class VideoUIPage extends StatefulWidget {
  final Video video;

  const VideoUIPage({
    super.key,
    required this.video,
  });

  @override
  State<VideoUIPage> createState() => _VideoUIPageState();
}

class _VideoUIPageState extends State<VideoUIPage> {
  void directToChannelPage(Video video) async {
    // video.ypController.pause();
    await Navigator.pushNamed(context, 'channel', arguments: {
      'controller': video.ypController,
      'timeShopItems': video.data?.timeShopItemLists,
      'model': video.data!.timeShopItemLists![0].model!,
      'profileImgUrl': video.data!.profileImgUrl,
    });
    video.ypController?.play();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(
              bottom: 100,
              left: 25,
            ),
            child: GestureDetector(
              onTap: () {
                directToChannelPage(widget.video);
              },
              child: CircleAvatar(
                backgroundImage: ExtendedNetworkImageProvider(
                    widget.video.data!.profileImgUrl!),
                radius: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
