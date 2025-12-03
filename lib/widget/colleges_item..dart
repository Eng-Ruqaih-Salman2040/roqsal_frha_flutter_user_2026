
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';




class CollegeItem extends StatelessWidget {
  final String id;
  final String title;
  final String image;
  CollegeItem(  this.title, this.image , this.id );

  void selectcollege(BuildContext ctx){

    //
    // Get.to(() => MajorScreen(), arguments: [
    // {"id": id},
    // {"title": title}
    // ]);
    // Get.put(MagerController()).getMajerApi(id);
    // Navigator.of(ctx).pushNamed(
    //   MajorScreen.screenRoute,
    //   arguments: {
    //     'id': id,
    //     'title': title,
    //   }
    //   );
  }
  @override
  Widget build(BuildContext context) {
    return 
      InkWell(
        onTap:()=> selectcollege(context),
        splashColor: Theme.of(context).primaryColor,
        borderRadius:BorderRadius.circular(15) ,
        child: Stack(
            children: [
          
                
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    image,
                    height: 250,
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.bottomCenter,
                child: Text(
                  title,
                  style: 
                  Theme.of(context).textTheme.titleLarge,
                ),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(15),
                ),
              )
          
            ],
              
          ),
      );
        
  }
}

  

