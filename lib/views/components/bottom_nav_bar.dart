import 'package:flutter/material.dart';

class BottomNavItems {
  static const List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      activeIcon: Icon(
        Icons.video_collection,
        color: Colors.white,
      ),
      icon: Icon(Icons.video_collection),
      label: '숏츠',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(
        Icons.favorite,
        color: Colors.white,
      ),
      icon: Icon(Icons.favorite),
      label: '찜하기 목록',
    ),
    BottomNavigationBarItem(
      activeIcon: Icon(
        Icons.account_circle,
        color: Colors.white,
      ),
      icon: Icon(Icons.account_circle),
      label: '마이페이지',
    ),
  ];
}
