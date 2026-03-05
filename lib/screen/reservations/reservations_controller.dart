import 'dart:convert';

import 'package:get/get.dart';

import '../../apiservice/api_service.dart';
import '../../screen/reservations/reservations_model.dart';
import '../../widget/my_data.dart';

class reservationsController extends GetxController
    with StateMixin<reservationsModel> {
  reservationsModel? model;

  void onInit() async {
    // TODO: implement onInit
    super.onInit();
  }

  getReservationsApi(String id, String reservation_status) {
    change(null, status: RxStatus.loading());
    ApiService()
        .getData('?checkopration=load_Data_reservations&id=${id.trim()}' +
        '&reservation_status=${reservation_status.trim()}')
        .then((value) {
      if (value.statusCode == 200) {
        print("aa");

        print(value.data);

        reservationsModel data =
        reservationsModel.fromJson(json.decode(value.data));
        if (reservation_status == "0")
          MyData.Number_of_Reservations_0 =
              data.reservations!.length.toString();

        if (reservation_status == "1")
          MyData.Number_of_Reservations_1 =
              data.reservations!.length.toString();

        if (reservation_status == "2")
          MyData.Number_of_Reservations_2 =
              data.reservations!.length.toString();

        print(value.data);

        update();
        change(data, status: RxStatus.success());
      } else {
        print("ee");
        change(null, status: RxStatus.error());
      }
    });
  }
}
