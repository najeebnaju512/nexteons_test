import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nexteons_test/controller/initial_controller.dart';

class InitialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final InitalController control = Get.put(InitalController());
    control.fetchData();
    var size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Obx(() {
          return control.isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    Card(
                      child: SizedBox(
                        height: size.width * .2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Name",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "UID",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Doc type",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Images",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount:
                            control.initialModel.value.data?.list?.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                    width: size.width * .2,
                                    child: Text(
                                        "${control.initialModel.value.data?.list?[index].name}")),
                                Text(
                                    "${control.initialModel.value.data?.list?[index].uid}"),
                                Text(checkDoc(control, index)),
                                Container(
                                  width: size.width * .2,
                                  height: size.width * .2,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(control
                                              .initialModel
                                              .value
                                              .data!
                                              .list![index]
                                              .url
                                              .toString()))),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
        }),
      ),
    );
  }

  String checkDoc(InitalController control, int index) {
    if (control.initialModel.value.data?.list?[index].docType == 0) {
      return "image";
    } else if (control.initialModel.value.data?.list?[index].docType == 1) {
      return "video";
    } else if (control.initialModel.value.data?.list?[index].docType == 2) {
      return "audio";
    } else if (control.initialModel.value.data?.list?[index].docType == 3) {
      return "document";
    } else {
      return "null";
    }
  }
}
