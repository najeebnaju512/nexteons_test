import 'dart:developer';

import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:nexteons_test/model/initial_model.dart';

class InitalController extends GetxController {
  var isLoading = false.obs;
  var initialModel = InitialModel().obs;

  void fetchData() async {
    isLoading(true);
    var data = {
      "statusArray": [1],
      "screenType": [],
      "responseFormat": [],
      "globalGalleryIds": [],
      "categoryIds": [],
      "docTypes": [],
      "types": [],
      "limit": 10,
      "skip": 0,
      "searchingText": ""
    };
    var token = {
      "Authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJfdXNlcklkXyI6IjYzMDI2ZjIxNWE5ZDVjNDY1NzQ3MTMxYSIsIl9lbXBsb3llZUlkXyI6IjYzMDI2ZjIxYTI1MTZhMTU0YTUxY2YxOSIsIl91c2VyUm9sZV8iOiJzdXBlcl9hZG1pbiIsImlhdCI6MTcxMTQ0NTY1OSwiZXhwIjoxNzQyOTgxNjU5fQ.lE1Gbdm8YZ6Fany4184Pb7kSUg-z6Rk8Ag1irB3fstc"
    };
    const url = "https://ajcjewel.com:4000/api/global-gallery/list";
    Dio dio = Dio();

    try {
      Options options = Options(headers: token);
      // Make POST request
      var response = await dio.post(
        url,
        data: data,
        options: options,
      );
      log("ApiService=> status code=${response.statusCode}");
      if (response.statusCode == 201) {
        initialModel(InitialModel.fromJson(response.data));
      } else {
        log("Else Condition -> Api failed");
      }
      isLoading(false);
    } catch (e) {
      log("$e");
      // Rethrow the exception
      rethrow;
    }
  }
}
