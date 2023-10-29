import 'package:clovi_template/models/video_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';


class VideoUIPage extends StatefulWidget {
  final Video video;

  const VideoUIPage({
    super.key,
    required this.video,
  });

  @override
  State<VideoUIPage> createState() => _VideoUIPageState();
}
bool click = true;

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
    return Stack(
      children: [
      // const SizedBox(),
          Container(
            child: Align(
              alignment: Alignment(-0.9,0.5),
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
          Container(
            child: Align(
              alignment: Alignment(0.9,0.5),
            child: ElevatedButton(
              
              style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,
              foregroundColor:(click == false) ? Colors.red : Colors.white ),
              onPressed:() {setState(() {
                click = !click;
              });
              },
            child:Icon(Icons.favorite,
            size: 40)
            )
            
            
            )
            
          ,
          ),
      ],
    );
  }
}
