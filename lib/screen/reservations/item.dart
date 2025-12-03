import 'package:flutter/material.dart';

import '../../widget/my_text.dart';

class  Item extends StatelessWidget {
    var data;

  Item(  this.data );

  void select(BuildContext ctx){

    // Get.put(shopDetailsController()).getGalleryApi( data.id.toString());
    // Get.to(() => shop_detailsScreen(this.data));
    // Get.to(() => MajorScreen(), arguments: [
    // {"id": data.id},
    // {"title": data.name}
    // ]);
    // Get.put(MagerController()).getMajerApi(id);

  }
  @override
  Widget build(BuildContext context) {
    return   InkWell(
      onTap: () =>select(context),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 7,
        margin: EdgeInsets.all(10),
        child:
        Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(

              width: double.infinity,

              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),

              child: Column(
                children: [
                  Row(
                    children: [

                      Text("رقم الحجز: ", style: MyText.display2(context)?.copyWith(color: Colors.grey[800])),
                      Text(data.id, style: MyText.medium(context).copyWith(color:  Color(0xFFFF2424))),
                      Spacer(),
                      Text(
                        data.bookingDate,
                        maxLines: 2,
                        style: MyText.subhead(context)?.copyWith(
                            color: Colors.grey
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Divider(height: 0, thickness: 0.5),
                  SizedBox(height: 8,),

                  Row(
                    children: [
                      Text(
                        "اسم الفئة: ",
                        style: MyText.title(context)?.copyWith(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(width: 5),
                      Text(
                        data.name,
                        maxLines: 2,
                        style: MyText.subhead(context)?.copyWith(
                            color: Colors.grey
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "نوع الفئة: ",
                        style: MyText.title(context)?.copyWith(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(width: 5),
                      Text(
                        data.section_name,
                        maxLines: 2,
                        style: MyText.subhead(context)?.copyWith(
                            color: Colors.grey
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "نوع الدفع: ",
                        style: MyText.title(context)?.copyWith(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(width: 5),
                      Text(
                        data.accountName,
                        maxLines: 2,
                        style: MyText.subhead(context)?.copyWith(
                            color: Colors.grey
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        " رقم الحوالة: ",
                        style: MyText.title(context)?.copyWith(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      Container(width: 5),
                      Text(
                        data.bondNo,
                        maxLines: 2,
                        style: MyText.subhead(context)?.copyWith(
                            color: Colors.grey
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              color:Color(0xFF14AE94),
              padding: EdgeInsets.fromLTRB(15, 5, 15, 5),

              child: Row(
                children: [
                  Spacer(),
                  Row(
                    children: [
                      Text("سعر الحجز", style: MyText.display2(context)?.copyWith(color: Color(
                          0xFFFFFFFF))),
                      Text("  "+data.price+"  ", style: MyText.display2(context)?.copyWith(color: Color(
                          0xFFFFFFFF))),
                      Text("ريال", style: MyText.display2(context)?.copyWith(color: Color(
                          0xFFFFFFFF))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        )
        ,
      ),
    );

      // InkWell(
      //   onTap: (){  },
      //   child: Container(
      //     height: 150, width: double.infinity,
      //
      //     padding: EdgeInsets.fromLTRB(15, 5, 15, 5),
      //     child: Column(
      //       children: <Widget>[
      //
      //         Expanded(
      //           child: Row(
      //             children: <Widget>[
      //               // Card(
      //               //     margin: EdgeInsets.all(0), elevation: 0,
      //               //     shape: RoundedRectangleBorder( borderRadius: BorderRadius.circular(8),),
      //               //     clipBehavior: Clip.antiAliasWithSaveLayer,
      //               //     child: Image.network( Url_shop+data.image.toString(), height: 100, width: 100, fit: BoxFit.cover)
      //               // ),
      //               // Container(width: 10),
      //               Expanded(
      //                 child: Column(
      //                   children: <Widget>[
      //                     Text(data.name, maxLines:3, style: MyText.subhead(context)?.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500)),
      //                     Spacer(),
      //                     Row(
      //                       children: <Widget>[
      //                         Row(
      //                           children: [
      //                             Text("طريقة الدفع: ", style: MyText.subhead(context)?.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500)),
      //
      //                             Text(data.accountName.toString(), style: MyText.subhead(context)?.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500)),
      //                           ],
      //                         ),
      //                         Spacer(),
      //                         Row(
      //                           children: [
      //                             Text("رقم الحوالة: ", style: MyText.subhead(context)?.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500)),
      //
      //                             Text(data.accountName.toString(), style: MyText.subhead(context)?.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500)),
      //                           ],
      //                         ),
      //                       ],
      //                     ),
      //                     Row(
      //                       children: <Widget>[
      //
      //                         Spacer(),
      //
      //                         Text(data.bookingDate.toString(), style: MyText.subhead(context)?.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500)),
      //                       ],
      //                     ),
      //                     Text(data.note.toString(), style: MyText.subhead(context)?.copyWith(color: MyColors.grey_80, fontWeight: FontWeight.w500)),
      //
      //                   ],
      //                 ),
      //               )
      //              ],
      //           ),
      //         ),
      //         Container(height: 10),
      //         Divider(height: 0)
      //       ],
      //     ),
      //   ),
      // );
        
  }
}

  

