import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_weixin/consnt/app_color.dart';
import 'package:flutter_weixin/i18n/strings.dart';

import 'contact_page.dart';
import 'conversation_page.dart';
import 'discover_page.dart';
import 'mine_page.dart';

enum ActionItems { GROUP_CHAT, ADD_FRIEND, QR_SCAN, PAYMENT, HELP }

class HomePage extends StatefulWidget {

  String title = Strings.TitleWechat;
  Color headerColor;
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const HeaderColor = const Color(AppColor.PrimaryColor);
  int _currentIndex = 0;
  List<BottomNavigationBarItem> _bottomNavigationBarItems=[];
  PageController _pageController;
  List<Widget> pages=[];
  List<Widget> _mainActions=[];
  List<Widget> _mineActions=[];
  @override
  void initState() {
    super.initState();
    _bottomNavigationBarItems=[
    _bottomBarItem(0xe608,0xe603,"微信",0),
    _bottomBarItem(0xe601,0xe656,"通讯录",1),
    _bottomBarItem(0xe600,0xe671,"发现",2),
    _bottomBarItem(0xe6c0,0xe626,"我的",3),
    ];
    _pageController=PageController(initialPage: _currentIndex);
    pages=[
      ConversationPage(),
      ContactPage(),
      DiscoverPage(),
      MinePage(),
    ];
    ///微信，通讯录，发现模块顶部头布局右边的搜索和多功能按钮
    _mainActions=[
    IconButton(icon: Icon(IconData( 0xe65e, fontFamily: AppColor.IconFontFamily,),
      size:  Constants.ActionIconSize,color: Color(AppColor.ActionIconColor),), onPressed: (){}),
    SizedBox(width: 16.0),
    Theme(
        data: ThemeData(cardColor: Color(AppColor.ActionMenuBgColor)),
        child:  PopupMenuButton(
          itemBuilder: (BuildContext context){
            return <PopupMenuItem<ActionItems>>[
              _buildPopupMenuItem(0xe69e,"发起群聊",ActionItems.GROUP_CHAT),
              _buildPopupMenuItem(0xe638,"添加朋友",ActionItems.ADD_FRIEND),
              _buildPopupMenuItem(0xe61b,"扫一扫",ActionItems.QR_SCAN),
              _buildPopupMenuItem(0xe62a,"收付款",ActionItems.PAYMENT),
              _buildPopupMenuItem(0xe63d,"帮助与反馈",ActionItems.HELP),
            ];
          },
          icon: Icon(IconData(0xe60e, fontFamily: AppColor.IconFontFamily,),size:  Constants.ActionIconSize+4),
          onSelected: (ActionItems){print("-----${ActionItems}");
          },
        )
    ), SizedBox(width: 16.0),
    ];
    ///我的模块顶部布局右边只要一个相机按钮
    _mineActions=[ IconButton(
      icon: Icon(IconData(0xe60a, fontFamily: Constants.IconFontFamily,),
          size: Constants.ActionIconSize + 4.0,
          color: const Color(AppColor.ActionIconColor)), onPressed: () {print('打开相机拍短视频');},
    ),
    SizedBox(width: 16.0),
   ];
  }
  @override
  Widget build(BuildContext context) {
    ///设置状态栏的颜色  SystemChrome类似于Android 的 Application ==== 全局属性
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style:  AppStyles.TitleStyle),
        elevation: 0.0,
        brightness: Brightness.light,//应用程序整体主题的亮度 Brightness.light 颜色如果是亮白色，需要黑色文本
        backgroundColor: widget.headerColor,
        actions:_currentIndex==3 ? _mineActions : _mainActions
      ),
      body:PageView.builder(
          itemBuilder: (context,index){
            return pages[index];
          },
          controller: _pageController,
         itemCount: pages.length,
          onPageChanged: (index){
            setState(() {
              _currentIndex=index;
             _switch(index);
            });
          },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomNavigationBarItems,
        type: BottomNavigationBarType.fixed,//图标和文字都显示
        fixedColor:Color(AppColor.TabIconActive) ,//选中的文字和图标颜色
        currentIndex: _currentIndex,
        onTap: (index){
          setState(() {
            _currentIndex = index;
//            _pageController.animateToPage(_currentIndex, duration: Duration(milliseconds: 200), curve: Curves.linear);
            _pageController.jumpTo(MediaQuery.of(context).size.width*index);
          });
        },
      ),
    );
  }
  BottomNavigationBarItem _bottomBarItem(int iconCode ,int activeIconCode , String title,int index){
    return BottomNavigationBarItem(
        title: Text(title),
       icon: Icon(IconData( iconCode, fontFamily: AppColor.IconFontFamily)),
       activeIcon: Icon(IconData(activeIconCode,fontFamily: AppColor.IconFontFamily))
//     icon: Icon(IconData( iconCode, fontFamily: AppColor.IconFontFamily),color:Color( AppColor.TabIconNormal)),
//     activeIcon: Icon(IconData(activeIconCode,fontFamily: AppColor.IconFontFamily),color:Color( AppColor.TabIconActive))
    );
  }
  _buildPopupMenuItem(int iconCode,String title ,ActionItems actionItem){
     return  PopupMenuItem(
       child:_buildPopupMenuChild(iconCode,title),
       value:actionItem,
     );
  }
  _buildPopupMenuChild(int iconCode,String title){
    return Row(
      children: <Widget>[
        Icon(IconData(iconCode,fontFamily: AppColor.IconFontFamily),size: 22.0,color:  Colors.white,),
        SizedBox(width: 16.0,),
        Expanded(
//        被const关键词修饰的变量和方法在编译器编译的时候就会被预生成，可以优化程序的执行效率
          child: Text(title,style: TextStyle(color: const Color(AppColor.PopupMenuTextColor)),),
        )
      ],
    );
  }
  ///根据选择不同的模块显示不同的title和主题头部背景色
  void _switch(int index) {
    switch (index) {
      case 0:
        widget.title = Strings.TitleWechat;
        widget.headerColor = HeaderColor;
        break;
      case 1:
        widget.title = Strings.TitleContact;
        widget.headerColor = HeaderColor;
        break;
      case 2:
        widget.title = Strings.TitleDiscovery;
        widget.headerColor = HeaderColor;
        break;
      case 3:
        widget.title = '';
        widget.headerColor = Colors.white;
        break;
    }
  }
}
