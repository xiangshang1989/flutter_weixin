import 'package:flutter/material.dart';
import 'package:flutter_weixin/consnt/app_color.dart';
import 'package:flutter_weixin/custom/full_width_custom.dart';
import 'package:flutter_weixin/i18n/strings.dart';

import 'full_width_item.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => new _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  static const SEPARATE_SIZE = 10.0;
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(AppColor.BackgroundColor),
     child: SingleChildScrollView(
       child: Column(
         children: <Widget>[

       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_social_circle.png',
         title: Strings.FriendsCircle,
         customWidget: Row(
           mainAxisAlignment: MainAxisAlignment.end, //设置显示在最右边
           children: <Widget>[
             FullWidthCustomWidget.iconTag( 
                 'https://randomuser.me/api/portraits/men/74.jpg', showDot: true, isBig: true
               ),
               SizedBox(width: 10.0,)
              ],
             ),
             onPressed: () {},
           ),
       SizedBox(height: SEPARATE_SIZE),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_quick_scan.png',
         title: Strings.Scan,
         showDivider: true,
         onPressed: () {
           print('点击了扫一扫');
         },
       ),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_shake_phone.png',
         title: Strings.Shake,
         onPressed: () {},
       ),
       SizedBox(height: SEPARATE_SIZE),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_feeds.png',
         title: Strings.KnowMore,
         showDivider: true,
         customWidget: Row(
           children: <Widget>[FullWidthCustomWidget.tag('NEW')],
         ),
         onPressed: () {},
       ),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_quick_search.png',
         title: Strings.SearchMore,
         onPressed: () {},
       ),
       SizedBox(height: SEPARATE_SIZE),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_people_nearby.png',
         title: Strings.FriendsNearby,
         showDivider: true,
         onPressed: () {},
       ),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_bottle_msg.png',
         title: Strings.FlowMessage,
         onPressed: () {},
       ),
       SizedBox(height: SEPARATE_SIZE),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_shopping.png',
         title: Strings.Shopping,
         showDivider: true,
         onPressed: () {},
       ),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_game_entry.png',
         title: Strings.Games,
         customWidget: Row(
           mainAxisAlignment: MainAxisAlignment.end, //设置显示在最右边
           children: <Widget>[
             FullWidthCustomWidget.desText('注册领时装抢红包'),
             SizedBox(width: 6.0),
             FullWidthCustomWidget.iconTag('assets/images/ad_game_notify.png',
                 showDot: true),
             SizedBox(width: 12.0),
           ],
         ),
         onPressed: () {},
       ),
       SizedBox(height: SEPARATE_SIZE),
       FullWidthCustomWidget(
         iconPath: 'assets/images/ic_mini_program.png',
         title: Strings.MiniPrograms,
         onPressed: () {},
       ),
       SizedBox(height: SEPARATE_SIZE),
         ],
       ),
     ),
    );
  }
}
