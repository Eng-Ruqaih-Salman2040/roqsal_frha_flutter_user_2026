// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:file_picker/file_picker.dart';
//  class FilePickerController extends GetxController{
//
//    var filePath='';
//
//    var name='';
//     var baseFile='';
//     getFilePath() async {
//       try {
//        FilePickerResult? result = await FilePicker.platform.pickFiles(
//          type: FileType.custom,
//          allowedExtensions: ['jpg', 'pdf', 'doc','ppt','mdb','docx','xlsx','jpeg','jpg','png','gif'],);
//        if (result == null) {
//          return;
//        }
//
//        PlatformFile file = result.files.first;
//
//        name =file.name;
//        // baseFile.value = base64Encode(file.path.codeUnits);
//        print("File name: " + file.name);
//        filePath = file.path!;
//        print("File path: " + file.path!);
//        update();
// //
//
// return file.path;
//      } on PlatformException catch (e) {
//        print("Error while picking the file: " + e.toString());
//      }
//    }
//
//
//
//  }