// import 'dart:convert';
import 'package:clovi_template/models/item_element_model.dart';
import 'package:clovi_template/models/time_shop_items_model.dart';
import 'package:clovi_template/views/time_control_widget.dart';
import 'package:clovi_template/models/video_model.dart';
import 'package:clovi_template/models/model_model.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'components/item_info_ui.dart';
// import 'package:http/http.dart' as http;
import 'package:clovi_template/views/components/bottom_nav_bar.dart';

class ItemInfoPage extends StatefulWidget {
  const ItemInfoPage({super.key});

  @override
  State<ItemInfoPage> createState() => _ItemInfoPageState();
}

class _ItemInfoPageState extends State<ItemInfoPage> {
  Widget itemView(List<ItemElement> items, Model model,
      YoutubePlayerController ypController) {
    return Column(children: [
      itemHeader(context, model),
      ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (
          BuildContext context,
          int i,
        ) {
          return VideoItemUI(items[i], ypController);
        },
      ),
      Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
                width: 1.0, color: Color.fromARGB(255, 177, 177, 177)),
          ),
        ),
      )
    ]);
  }

  Widget allItemView(
    List<TimeShopItemLists> timeShopItemsList,
    YoutubePlayerController ypController,
  ) {
    // filter out duplicating items
    List<ItemElement> allItems = [];
    Set<int> uniqueItemIds = {};
    timeShopItemsList.forEach((item) {
      item.items?.forEach((subItem) {
        int itemId = subItem.item?.id ?? 0;
        if (!uniqueItemIds.contains(itemId)) {
          uniqueItemIds.add(itemId);
          allItems.add(subItem);
        }
      });
    });

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.only(top: 44, bottom: 15),
          child: Padding(
            padding: const EdgeInsets.only(left: 6),
            child: const Text(
              '영상에 나온 옷들',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
      GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: allItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.53,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 0),
        itemBuilder: (BuildContext context, int index) {
          return allItemUI(context, allItems[index], ypController);
        },
      ),
    ]);
  }

  Widget timeItemView(List<TimeShopItemLists> timeShopItemsList, Model model,
      YoutubePlayerController ypController) {
    for (int i = 0; i < timeShopItemsList.length; i++) {
      TimeShopItemLists currentItem = timeShopItemsList[i];
      TimeShopItemLists? nextItem =
          (i + 1 < timeShopItemsList.length) ? timeShopItemsList[i + 1] : null;

      if (currentItem.times!.start! <= ypController.value.position.inSeconds &&
          (nextItem == null ||
              nextItem.times!.start! > ypController.value.position.inSeconds)) {
        return itemView(currentItem.items!, model, ypController);
      }
    }
    return Container();
  }

  @override
  void initState() {
    super.initState();
  }

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
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    YoutubePlayerController ypController = arguments['controller'];
    List<TimeShopItemLists> timeShopItemList = arguments['timeShopItems'];
    Model model = arguments['model'];
    Video video = arguments['video'];

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Column(children: [
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (BuildContext context, int i) {
                    return timeItemView(timeShopItemList, model, ypController);
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (
                    BuildContext context,
                    int i,
                  ) {
                    return allItemView(timeShopItemList, ypController);
                  },
                ),
              ])),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: TimeControlWidget(
                    ypController: video.ypController!,
                    video: video,
                    refresh: true,
                  ),
                ),
              ),
            ],
          ),
          onHorizontalDragEnd: (details) {
            if (details.velocity.pixelsPerSecond.dx > 0) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).highlightColor,
        items: BottomNavItems.items,
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  //         ),
  //   );
  // }
}
