import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../screen/section/section_model.dart';
import '../../apiservice/url.dart';
import '../../widget/my_text.dart';

class Item extends StatelessWidget {
  var data;

  Item(this.data);

  void select(BuildContext ctx) {
    // Get.to(() => MajorScreen(), arguments: [
    // {"id": data.id},
    // {"title": data.name}
    // ]);
    // Get.put(MagerController()).getMajerApi(id);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => select(context),
      splashColor: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Expanded(
              child: Image.network(
                Url_shop + data.image.toString(),
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: EdgeInsets.all(15),
              width: double.infinity,
              color: Color(0xff2c878a),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          data.nameShop.toString(),
                          style: MyText.subhead(context)?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(height: 2),
                        Text(
                          data.price.toString(),
                          style: MyText.caption(
                            context,
                          )?.copyWith(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.chevron_right, color: Colors.white),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
