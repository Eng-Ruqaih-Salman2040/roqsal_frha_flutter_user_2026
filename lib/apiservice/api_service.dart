

import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../apiservice/url.dart';

import '../Constants.dart';


class ApiService extends GetConnect {
  dio.Dio _dio = dio.Dio();

  Future getData(String url ) async {
    dio.Response   response;


    try{

      response= await _dio.get(urlBase+url,
        //     options:
        // dio.Options(headers: {'authorization': 'Bearer ${GetStorage().read(token)}'} )
      );
      // print("\nresponse.statusCode \n${response.statusCode}\n");
      // print("\nresponse.body\nresponse.body ${response.data}\n");

      return response;

    }
    on dio.DioError catch(error){
      if(error.response!=null){

        response =error.response!;
        return response;
      }

    }


  }



  Future postData({required String url, required Map<String,dynamic>header ,required Map<String,dynamic> body}) async {
    dio.Response   response;
    try{
      print('ff');
      response= await _dio.post(urlBase+url,options: dio.Options(headers: header),data:dio.FormData.fromMap( body),);


      return response;

    }
    on dio.DioError catch(error){
      print(error);
      if(error.response!=null){

        response =error.response!;
        return response;
      }





    }


  }


  Future postDataLogin({required String url,}) async {
    dio.Response   response;
    try{
      response= await _dio.post(urlBase+url,onSendProgress: (count, total) => Center(child: CircularProgressIndicator()),);


      return response;

    }
    on dio.DioError catch(error){
      print(error);
      if(error.response!=null){

        response =error.response!;
        return response;
      }





    }


  }
  Future postDataForm({required String url,}) async {
    dio.Response   response;
    try{
      response= await _dio.post(urlBase+url,onSendProgress: (count, total) => Center(child: CircularProgressIndicator()),);


      return response;

    }
    on dio.DioError catch(error){
      print(error);
      if(error.response!=null){

        response =error.response!;
        return response;
      }





    }


  }
}