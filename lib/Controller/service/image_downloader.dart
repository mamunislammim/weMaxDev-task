import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class DownloadImage {
  Future<String> saveNetworkImage({required String url,required int id}) async {
    try {
      var appDocDir = await getTemporaryDirectory();
      String savePath = "${appDocDir.path}/${id}_temp.jpg";
      String fileUrl = url;
      await Dio().download(fileUrl, savePath);
      return savePath;
    } catch (e) {
      debugPrint("Error : $e");
    }
    return "";
  }
}
