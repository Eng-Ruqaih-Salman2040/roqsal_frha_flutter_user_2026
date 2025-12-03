
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../apiservice/checkInterNet.dart';

import '../../apiservice/api_service.dart';
import '../../apiservice/url.dart';
import '../../router/custom_router.dart';
import '../../widget/my_data.dart';
import 'notifications_model.dart';

class NotificationsController extends GetxController with StateMixin<NotificationsModel> {


  NotificationsModel?notificationsModel ;
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
  await  getNotificationsApi();


  }


  getNotificationsApi(){



    change(null, status: RxStatus.loading());




    ApiService().getData('?checkopration=load_Data_Notifications').then((value) {


      if(value.statusCode==200) {

        print(value.data);

        NotificationsModel notificationsModel =  NotificationsModel.fromJson(json.decode(value.data));
        MyData.Number_of_notifications=notificationsModel.notifications!.length.toString();

        print(value.data);



        update();
        change(notificationsModel, status: RxStatus.success());


      }
      else{
        change(null, status: RxStatus.error());

      }}

    );
  }
}