import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatapp/controller/callCntroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controller/chatController.dart';
import '../../controller/contactController.dart';

class Callhistory extends StatefulWidget {
  const Callhistory({super.key});

  @override
  State<Callhistory> createState() => _CallhistoryState();
}

class _CallhistoryState extends State<Callhistory> {
  final Chatcontroller chatcontroller = Get.put(Chatcontroller());
  final Contactcontroller contactController = Get.put(Contactcontroller());
  CallController callController = Get.put(CallController());
  void _deleteCall(String callId) {
    callController.deleteAllCallsFromUser(
        callId); // Ensure you have a delete function in Chatcontroller
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: chatcontroller.getCalls(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          }

          var calldata = snapshot.data!;

          print("Total Calls: ${calldata.length}"); // Debugging

          return ListView.builder(
            itemCount: calldata.length,
            itemBuilder: (context, index) {
              var calldatalist = calldata[index];
              String formattedTime = "";
              if (calldatalist.timestamp != null) {
                DateTime dateTime = DateTime.parse(calldatalist.timestamp!);
                formattedTime = DateFormat('hh:mm a').format(dateTime);
              }
              return Card(
                color: Colors.transparent,
                elevation: 0,
                child: SizedBox(
                  height: 90,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 0),
                        child: Center(
                          child: GestureDetector(
                            onTap: () {
                              print("Tapped on Profile Image");
                            },
                            child: Container(
                              width: 60,
                              height: 60,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromARGB(255, 71, 71, 71),
                                image: DecorationImage(
                                  image: calldatalist.receiverPic != null &&
                                          calldatalist.receiverPic!.isNotEmpty
                                      ? CachedNetworkImageProvider(
                                          calldatalist.receiverPic!)
                                      : const NetworkImage(
                                              'https://picsum.photos/200/300')
                                          as ImageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 3),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      calldatalist.receiverName ?? "Unknown",
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w400),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    formattedTime,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  PopupMenuButton<String>(
                                    onSelected: (value) {
                                      if (value == "delete") {
                                        _deleteCall(calldatalist.receiverUid!);
                                      }
                                    },
                                    itemBuilder: (BuildContext context) => [
                                      const PopupMenuItem(
                                        value: "delete",
                                        child: Row(
                                          children: [
                                            Icon(Icons.delete,
                                                color: Colors.red),
                                            SizedBox(width: 2),
                                            Text("Delete Call"),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 15),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      calldatalist.receiverEmail ??
                                          "No status available",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Icon(
                                    calldatalist.type == "audio"
                                        ? Icons.call
                                        : Icons.video_call,
                                    color: calldatalist.type == "audio"
                                        ? Colors.green
                                        : Colors.blue,
                                  ),
                                    SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
