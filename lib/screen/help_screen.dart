
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../Constants.dart';
import '../../router/route_constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import '../widget/my_colors.dart';
import '../widget/my_text.dart';



class HelpScreen extends StatefulWidget {

  HelpScreen();

  @override
  TabsScrollRouteState createState() => new TabsScrollRouteState();
}


class TabsScrollRouteState extends State<HelpScreen> with SingleTickerProviderStateMixin{

  late TabController _tabController;
  late ScrollController _scrollController;
 Widget _getDetails1(BuildContext context){
    Widget widget;
    widget =   ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.w),
      itemCount: 2,
      itemBuilder: (context, index) => GestureDetector(onTap: () {
        //  controller.onClickGroup(group.result[index]);
        //Get.toNamed(RoutingApp.supplierDetailRoute,);
      },
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.0.w),
          child: NewCart(context,'محمد الطيب',"ش",'SO-27'),
        ),
      ),
    );
    return widget;
  }

  Widget NewCart(BuildContext context,String name,String note,String id) {
    return Padding(
      padding:  EdgeInsets.only(bottom:8.0.w),
      child: Card(
        color: kColorsWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r),

        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.symmetric(horizontal:8.r,vertical: 5.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10.r),topRight: Radius.circular(10.r)),
                  color: kColorRed,
                ),
                width: double.infinity,
                child: Text('1. كيف يمكنك مواكبة التطورات في سوقك المستهدفة؟',style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.white),)),
            Padding(
              padding:  EdgeInsets.all(10.0.r),
      child: Text('حتى لو كان السوق المستهدف الذي عمل فيه سابقًا مختلفًا عن السوق المستهدف الحالي، فمن المهم تكوين فكرة عن مقدار فهمه لنشاط شركتك، ولاحتياجات عملائها. هل يواكب التطورات من خلال قراءة مدونة، أم بالاستماع إلى البودكاست، أو بمتابعة بعض المؤثرين على تويتر؟ اكتشف ذلك.',style: Theme.of(context).textTheme.headlineMedium,)

            ),

          ],
        ),

      ),
    );
  }

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScroller){
          return <Widget>[
            SliverAppBar(
              title: Text("common questions".tr), pinned: true, floating: true,
              backgroundColor: MyColors.primary,
              leading: IconButton(icon: const Icon(Icons.menu), onPressed: () {
                Navigator.pop(context);
              }),

              bottom: TabBar(
                indicatorColor: Colors.white,
                isScrollable: true,
                indicatorSize: TabBarIndicatorSize.tab, indicatorWeight: 4,
                labelStyle: MyText.subhead(context)?.copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                unselectedLabelColor: Colors.grey[300],
                tabs: [
                  Tab(text: "الأسئلة المتعلقة بالعملاء"),
                  Tab(text:"Sell orders".tr),
                  Tab(text: "Sales returns".tr),
                  Tab(text: "عرض سعر"),
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: [
            _getDetails1(context),
            _getDetails1(context),
            _getDetails1(context),
            _getDetails1(context),
          ],
          controller: _tabController,
        ),
      ),
      //   floatingActionButton :buildSpeedDial(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
    );
  }
  Widget buildSpeedDial() {
    return SpeedDial(
        elevation: 2,
        animatedIcon: AnimatedIcons.menu_close,
        curve: Curves.linear,
       // animationSpeed: 100,
      animationDuration : const Duration(milliseconds: 150),
        overlayColor: Colors.black,
        overlayOpacity: 0.2,
        backgroundColor: MyColors.primary,
        children: [

          SpeedDialChild(
            elevation: 2,
            label:"Sale order".tr,
            child: Icon(Icons.volunteer_activism, color: MyColors.grey_80),
            backgroundColor: Colors.white,
            onTap: () {
              Get.toNamed(RoutingApp.SellOrderRoute);
            },
          ),
          SpeedDialChild(
            elevation: 2,
            label: "Sales return".tr,
            child: Icon(Icons.archive_outlined, color: MyColors.grey_80),
            backgroundColor: Colors.white,
            onTap: () {},
          ),
        ],
    );
  }

}

