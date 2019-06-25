import 'package:flutter/material.dart';
import 'package:flutter_weixin/consnt/app_color.dart';
import 'package:flutter_weixin/model/conversation_model.dart';
class ConversationPage extends StatefulWidget {
  @override
  _ConversationPageState createState() => new _ConversationPageState();
}
class _ConversationPageState extends State<ConversationPage> {
  Offset tapPostion;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
          itemBuilder: (context,index){
            if(index==0){
              return _buildTopDeviceTip(Device.WIN);
            }
            ///index-1是由于index为0 时候显示的是微信在电脑登录提示
            return _buildConversationItem(ConversationModel.conversationModels[index-1]);
          },
          ///长度+1是由于要显示完整的listview展示的数据
          itemCount:ConversationModel.conversationModels.length+1,
      ),
    );
  }
  ///会话的item
  _buildConversationItem(ConversationModel model){
    return Material(
      color: Color(AppColor.ConversationItemBg),

          child:  InkWell(  //inkWell下面的孩子不能设置背景，不然点击时水波纹效果没有
            onTapDown: (TapDownDetails details){  //手指按下监听
              tapPostion = details.globalPosition;  //获取手指按下的位置
            },
            onLongPress: (){  //长按监听
              _showMenu(context,tapPostion);
            },
            child: Container(
              padding: EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 0.6,color: Color(AppColor.DividerColor)),
                  )
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _buildAvatarAndunreadMsgCount(model),//头像图片和上面的未读消息数
                  SizedBox(width: 10.0,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(model.title,style: AppStyles.TitleStyle,),
                        SizedBox(height: 5.0,),
                        Text(model.des,style: AppStyles.DesStyle,maxLines: 1,overflow: TextOverflow.ellipsis,)
                      ],
                    ),
                  ),
                  SizedBox(width: 15.0),
                  Column(
                    children: <Widget>[
                      Text(model.updateAt,style: AppStyles.DesStyle,),
                      _buildIsMute(model)
                    ],
                  )
                ],
              ),
            ),
      ),
    );
  }
  ///显示网络图片还是本地图片包括未读消息数
  _buildAvatarAndunreadMsgCount(ConversationModel model){
    var size=Constants.ConversationAvatarSize;
    ///显示网络还是本地图片
    Widget avator=model.isFromNet()?Image.network(model.avatar,width: size,height: size,):Image.asset(model.avatar,width: size,height: size);
    if(model.unreadMsgCount>0){ //有未读消息
      return Stack(
        overflow: Overflow.visible, //设置超出边界不会缺少
        children: <Widget>[
          avator,
          Positioned(
            right:model.displayDot?-4.0: -6.0,
            top: model.displayDot?-4.0:-6.0,
            child: _buildUnreadMsgCount(model)
          ),
        ],
      );
    }
    return avator;
  }
  ///显示未读数量还是显示小红点
  _buildUnreadMsgCount(ConversationModel model){
    var size=model.displayDot ? Constants.UN_READ_MSG_DOT_SIZE:Constants.UN_READ_MSG_CIRCLE_SIZE;
    return Container(
      alignment: Alignment.center,
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
       color: Color(AppColor.NotifyDotBg)
      ),
      child:model.displayDot? null:Text(model.unreadMsgCount.toString(),style: AppStyles.UnreadMsgCountDotStyle),
    );
  }
  ///是否显示免打扰模式图标
  _buildIsMute(ConversationModel model){
    return Container(
      margin: EdgeInsets.only(top: 5.0),
      child:  Icon(
              IconData(0xe755, fontFamily: Constants.IconFontFamily,),
              color:model.isMute? Color(AppColor.ConversationMuteIcon) : Colors.transparent,
              size: Constants.ConversationMuteIconSize)
    );
  }
  ///微信在电脑登录顶部提示
  _buildTopDeviceTip(Device device){
    int iconCode=device==Device.WIN ? 0xe6b3 : 0xe61c;
    String title=device==Device.WIN ? "Window" : "Mac";
    return Container(
      padding: EdgeInsets.fromLTRB(24, 10, 24, 10),
      decoration: BoxDecoration(
        color: Color(AppColor.DeviceTipBg),
        border: Border(
        bottom: BorderSide(width: 0.5,color: Color(AppColor.DividerColor))
        )
      ),
      child: Row(
        children: <Widget>[
          Icon(IconData(iconCode,fontFamily: AppColor.IconFontFamily),size: 24.0,color:Color(AppColor.DeviceInfoItemIcon)),
          SizedBox(width: 15.0,),
          Text('$title 微信已登录，手机通知已关闭。',style: AppStyles.DeviceInfoItemTextStyle)
        ],

      ),
    );
  }
  _showMenu(BuildContext context,Offset tapPos){
    //弹出的在手机屏幕上的蒙层
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    final RelativeRect position = RelativeRect.fromLTRB(
      tapPos.dx,tapPos.dy,overlay.size.width- tapPos.dx,overlay.size.height-tapPos.dy
    );
    return showMenu(
        context: context,
        position: position,
        items: <PopupMenuItem<String>>[
          PopupMenuItem(
            child: Text(Constants.MENU_MARK_AS_UNREAD_VALUE),
            value: Constants.MENU_MARK_AS_UNREAD,
          ),
          PopupMenuItem(
            child: Text(Constants.MENU_PIN_TO_TOP_VALUE),
            value: Constants.MENU_PIN_TO_TOP,
          ),
          PopupMenuItem(
            child: Text(Constants.MENU_DELETE_CONVERSATION_VALUE),
            value: Constants.MENU_DELETE_CONVERSATION,
          ),
        ]).then<String>((String selected){
            switch (selected) {
              default:
                print('当前选中的是：$selected');
            }
         });
  }
}
