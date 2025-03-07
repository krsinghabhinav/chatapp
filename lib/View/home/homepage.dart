// import 'package:chatapp/View/homepage/widget/appbarTab.dart';
// import 'package:chatapp/config/images.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   State<Homepage> createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> with TickerProviderStateMixin {
//   TabController? tabController;

//   @override
//   void initState() {
//     super.initState();
//     tabController = TabController(length: 3, vsync: this);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         bottom: myTabBar(tabController!),
//         leading: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Image.asset(
//             AssetsImages.homeIconPng,
//             height: 5,
//           ),
//         ),
//         title: Text("SAMPRAK"),
//         backgroundColor: Theme.of(context).colorScheme.primaryContainer,
//         actions: [
//           Icon(Icons.search),
//           SizedBox(
//             width: Get.width * 0.03,
//           ),
//           Icon(Icons.more_vert_outlined),
//           SizedBox(
//             width: Get.width * 0.03,
//           ),
//         ],
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: const Color.fromARGB(255, 11, 124, 230),
//         onPressed: () {},
//         child: Icon(
//           Icons.add,
//           color: Colors.white,
//           size: 30,
//         ),
//       ),
//       body: TabBarView(
//         controller: tabController!,
//         children: [
//           Center(
//             child: Text("Chats"),
//           ),
//           Center(
//             child: Text("Groups"),
//           ),
//           Center(
//             child: Text("calls"),
//           ),
//         ],
//       ),
//     );
//   }
// }
