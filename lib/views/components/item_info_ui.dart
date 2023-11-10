import 'package:clovi_template/models/item_element_model.dart';
import 'package:clovi_template/models/model_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:intl/intl.dart';

class VideoItemUI extends StatefulWidget {
  final ItemElement itemElement;
  final YoutubePlayerController ypController;

  VideoItemUI(this.itemElement, this.ypController);

  @override
  _VideoItemUIState createState() => _VideoItemUIState();
}

class _VideoItemUIState extends State<VideoItemUI> {
  bool _isClicked = false;
  Color _iconColor = Colors.black;

  Future<void> _launchURL(String url) async {
    Uri uri;
    if (!url.startsWith("https")) {
      url = "https://$url";
    }
    uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // throw "Can not launch $url";
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Cannot launch $url'),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(dialogContext).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, 'item_detail', arguments: {
            'itemElement': widget.itemElement,
          });
        },
        child: Container(
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                  width: 1.0, color: Color.fromARGB(255, 242, 242, 242)),
            ),
          ),
          padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 14, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: ExtendedImage.network(
                  widget.itemElement.item!.itemImgUrl!,
                  width: 80,
                  fit: BoxFit.cover,
                  loadStateChanged: (ExtendedImageState state) {
                    switch (state.extendedImageLoadState) {
                      case LoadState.loading:
                        return null;
                      case LoadState.completed:
                        return null;
                      case LoadState.failed:
                        return const Icon(Icons.error);
                    }
                  },
                ),
              ),
              Container(
                  width: 135,
                  height: 130,
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '[${widget.itemElement.item!.brand}] ${widget.itemElement.item!.name}',
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              '${widget.itemElement.item!.color} / ${widget.itemElement.item!.size} 착용',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color.fromARGB(255, 93, 93, 93),
                              ),
                            )),
                      ),
                    ],
                  )),
              Container(
                height: 75,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        _isClicked = !_isClicked;
                        if (_isClicked) {
                          _iconColor = Colors.red;
                        } else {
                          _iconColor = Colors.black;
                        }
                      });
                    },
                    icon: Icon(
                      _isClicked ? Icons.favorite : Icons.favorite_border,
                      color: _iconColor,
                      size: 25,
                    ),
                  ),
                ),
              ),
              Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(10, 10, 0, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${NumberFormat('#,###').format(widget.itemElement.item!.shops![0].price)}원',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).highlightColor,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              _launchURL(
                                  widget.itemElement.item!.shops![0].shopUrl!);
                            },
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(10, 6, 10, 6),
                              child: Text(
                                '구매 링크',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Theme.of(context).highlightColor,
                                  fontWeight: FontWeight.w500,
                                  //  Color.fromARGB(255, 255, 111, 0)
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ))
            ],
          ),
        ));
  }
}

Widget allItemUI(BuildContext context, ItemElement itemElement,
    YoutubePlayerController ypController) {
  return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'item_detail', arguments: {
          'itemElement': itemElement,
        });
      },
      child: Container(
        // height: 500,
        margin: const EdgeInsetsDirectional.fromSTEB(5, 10, 5, 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExtendedImage.network(
              itemElement.item!.itemImgUrl!,
              height: 220,
              width: 180,
              fit: BoxFit.cover,
              loadStateChanged: (ExtendedImageState state) {
                switch (state.extendedImageLoadState) {
                  case LoadState.loading:
                    return null;
                  case LoadState.completed:
                    return null;
                  case LoadState.failed:
                    return Container(
                        height: 220,
                        width: 180,
                        color: Colors.white,
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'item_detail',
                                  arguments: {
                                    'itemElement': itemElement,
                                  });
                            },
                            icon: const Icon(Icons.error, size: 20)));
                }
              },
            ),
            Container(
                width: 180,
                // height: 100,
                // padding: const EdgeInsets.only(left: 10, top: 15, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${itemElement.item!.brand}',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      margin: EdgeInsets.only(bottom: 10.0),
                      padding: EdgeInsets.only(right: 10),
                      child: Text(
                        '${itemElement.item!.name}',
                        maxLines: 2,
                        style: TextStyle(
                          color: Color.fromARGB(255, 93, 93, 93),
                          fontWeight: FontWeight.w500,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: [
                            TextSpan(
                              text: NumberFormat('#,###')
                                  .format(itemElement.item!.shops![0].price),
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                            ),
                            const TextSpan(
                                text: '원', style: TextStyle(fontSize: 13)),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ],
        ),
      ));
}

Widget itemHeader(BuildContext context, Model model) {
  return Container(
    height: 44,
    decoration: const BoxDecoration(),
    padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Calico 자동 검색 서비스',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            '${model.name} ${model.heightCm?.toStringAsFixed(0)}cm ${model.weightKg?.toStringAsFixed(0)}kg',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}
