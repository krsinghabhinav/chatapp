import 'package:flutter/material.dart';

mytabbar() {
  return TabBar(
    unselectedLabelColor: const Color.fromARGB(218, 150, 150, 149),
    labelStyle: TextStyle(color: const Color.fromARGB(255, 253, 253, 253)),
    indicatorWeight: 1,
    indicatorSize: TabBarIndicatorSize.tab,
    tabs: [
      Tab(
        text: "Chats",
      ),
      Tab(
        text: "Groups",
      ),
      Tab(
        text: "Calls",
      )
    ],
  );
}
