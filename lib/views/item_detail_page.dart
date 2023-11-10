import 'package:clovi_template/models/item_element_model.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:clovi_template/views/components/bottom_nav_bar.dart';

class ItemDetailPage extends StatefulWidget {
  const ItemDetailPage({super.key});

  @override
  State<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends State<ItemDetailPage> {
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
    ItemElement itemElement = arguments['itemElement'];
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ExtendedImage.network(
                itemElement.item!.itemImgUrl!,
                height: 400,
                width: screenWidth * 0.95,
                // fit: BoxFit.cover,
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
              const Divider(
                color: Colors.black,
                height: 25,
                thickness: 2,
                indent: 22,
                endIndent: 22,
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: screenWidth * 0.9,
                child: Text(
                  itemElement.item!.brand!,
                  style: const TextStyle(
                      decoration: TextDecoration.underline,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 17,
                      color: Colors.black),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: screenWidth * 0.9,
                child: Text(
                  itemElement.item!.name!,
                  style: const TextStyle(
                      height: 2,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 22,
                      color: Colors.black),
                ),
              ),
              Divider(
                color: Colors.grey.shade200,
                height: 25,
                thickness: 2,
                indent: 22,
                endIndent: 22,
              ),
              Container(
                alignment: Alignment.centerRight,
                width: screenWidth * 0.9,
                child: Text(
                  '${NumberFormat('#,### ').format(itemElement.item!.shops![0].price)}원',
                  style: const TextStyle(
                      height: 2,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                      color: Colors.black),
                ),
              ),
              Divider(
                color: Colors.grey.shade200,
                height: 40,
                thickness: 2,
                indent: 22,
                endIndent: 22,
              ),
              Container(
                width: screenWidth * 0.9,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                            padding: EdgeInsets.only(left: 40, top: 50)),
                        SizedBox(
                            width: screenWidth * 0.55,
                            child: const Text(
                              "판매처",
                              style: TextStyle(
                                fontSize: 15,
                                fontStyle: FontStyle.normal,
                                fontWeight: FontWeight.w800,
                              ),
                            )),
                        SizedBox(
                            width: screenWidth * 0.15,
                            child: const Align(
                                alignment: Alignment.centerRight,
                                child: Text("가격",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontStyle: FontStyle.normal,
                                        fontWeight: FontWeight.w800))))
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(
                          style: TextButton.styleFrom(
                            side: BorderSide(
                                width: 5, color: Colors.grey.shade300),
                            textStyle: const TextStyle(fontSize: 20),
                          ),
                          onPressed: () => launchUrlString(
                              itemElement.item!.shops![0].shopUrl!),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(left: 2, right: 5),
                                  child: ExtendedImage.network(
                                    itemElement.item!.shops![0].logoUrl!,
                                    width: screenWidth * 0.05,
                                    fit: BoxFit.cover,
                                    loadStateChanged:
                                        (ExtendedImageState state) {
                                      switch (state.extendedImageLoadState) {
                                        case LoadState.loading:
                                          return null;
                                        case LoadState.completed:
                                          return null;
                                        case LoadState.failed:
                                          return const Icon(Icons.error,
                                              color: Colors.black);
                                      }
                                    },
                                  ),
                                ),
                                Container(
                                  width: screenWidth * 0.55,
                                  padding: const EdgeInsets.only(
                                      left: 5, top: 5, bottom: 5),
                                  child: Text(
                                    itemElement.item!.shops![0].name!,
                                    style: const TextStyle(
                                        fontSize: 15,
                                        fontStyle: FontStyle.normal,
                                        color: Colors.black),
                                  ),
                                ),
                                SizedBox(
                                  width: screenWidth * 0.21,
                                  child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '${NumberFormat('#,### ').format(itemElement.item!.shops![0].price)}원',
                                      style: const TextStyle(
                                          fontSize: 15,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black),
                                    ),
                                  ),
                                )
                              ]
                              // const Padding(padding: EdgeInsets.only(right: 20)),
                              ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
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
}
