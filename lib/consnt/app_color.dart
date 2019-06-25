import 'package:flutter/material.dart';
class AppColor{
  static const AppBarColor=0xff303030;
  static const IconFontFamily="appIconFont";
  static const TabIconNormal = 0xff999999;
  static const TabIconActive = 0xff46c11b;
  static const PopupMenuTextColor = 0xffffffff;
  static const PrimaryColor = 0xffebebeb;
  static const BackgroundColor = 0xffededed;
  static const ActionIconColor = 0xff000000;
  static const ActionMenuBgColor = 0xff4c4c4c;
  static const CardBgColor = 0xffffffff;
  static const AppBarPopupMenuColor = 0xffffffff;
  static const TitleColor = 0xff181818;
  static const ConversationItemBg = 0xffffffff;
  static const DesTextColor = 0xff999999;
  static const DividerColor = 0xffd5d5d5;
  static const NotifyDotBg = 0xfff85351;
  static const NotifyDotText = 0xffffffff;
  static const ConversationMuteIcon = 0xffd8d8d8;
  static const DeviceInfoItemBg = AppBarColor;
  static const DeviceInfoItemText = 0xff606062;
  static const DeviceInfoItemIcon = 0xff606062;
  static const ContactGroupTitleBg = 0xffebebeb;
  static const ContactGroupTitleText = 0xff888888;
  static const IndexLetterBoxBg = Colors.black45;
  static const HeaderCardBg = Colors.white;
  static const HeaderCardTitleText = 0xff353535;
  static const HeaderCardDesText = 0xff7f7f7f;
  static const ButtonDesText = 0xff8c8c8c;
  static const ButtonArrowColor = 0xffadadad;
  static const NewTagBg = 0xfffa5251;
  static const ChatBoxBg = 0xfff7f7f7;
  static const DeviceTipBg = 0xfff5f5f5;
}
class AppStyles {
  static const TitleStyle = TextStyle(
    fontSize: Constants.TitleTextSize,
    color: const Color(AppColor.TitleColor),
  );

  static const DesStyle = TextStyle(
    fontSize: Constants.DesTextSize,
    color: Color(AppColor.DesTextColor,
    ),
  );
  static const UnreadMsgCountDotStyle = TextStyle(
    fontSize: 12.0,
    color: Color(AppColor.NotifyDotText),
  );
  static const DeviceInfoItemTextStyle = TextStyle(
    fontSize: Constants.DesTextSize,
    color: Color(AppColor.DeviceInfoItemText),
  );
  static const GroupTitleItemTextStyle = TextStyle(
    fontSize: 15.0,
    color: Color(AppColor.ContactGroupTitleText),
  );

  static const IndexLetterBoxTextStyle =
  TextStyle(fontSize: 64.0, color: Colors.white);

  static const HeaderCardTitleTextStyle = TextStyle(
      fontSize: 20.0,
      color: Color(AppColor.HeaderCardTitleText),
      fontWeight: FontWeight.bold);

  static const HeaderCardDesTextStyle = TextStyle(
      fontSize: 14.0,
      color: Color(AppColor.HeaderCardDesText),
      fontWeight: FontWeight.normal);

  static const ButtonDesTextStyle = TextStyle(
      fontSize: 12.0,
      color: Color(AppColor.ButtonDesText),
      fontWeight: FontWeight.bold);

  static const NewTagTextStyle = TextStyle(
      fontSize: Constants.DesTextSize,
      color: Colors.white,
      fontWeight: FontWeight.bold);
}
  class Constants {
  static const IconFontFamily = "appIconFont";
  static const ActionIconSize = 20.0;
  static const ActionIconSizeLarge = 32.0;
  static const AvatarRadius = 4.0;
  static const ConversationAvatarSize = 48.0;
  static const DividerWidth = 0.5;
  static const ConversationMuteIconSize = 18.0;
  static const ContactAvatarSize = 42.0;
  static const TitleTextSize = 17.0;
  static const DesTextSize = 14.0;
  static const IndexBarWidth = 28.0;
  static const IndexLetterBoxSize = 114.0;
  static const IndexLetterBoxRadius = 4.0;
  static const FullWidthIconButtonIconSize = 25.0;
  static const ChatBoxHeight = 48.0;
  static const UN_READ_MSG_DOT_SIZE = 12.0;
  static const UN_READ_MSG_CIRCLE_SIZE = 20.0;

  static const String MENU_MARK_AS_UNREAD = 'MENU_MARK_AS_UNREAD';
  static const String MENU_MARK_AS_UNREAD_VALUE = '标为未读';
  static const String MENU_PIN_TO_TOP = 'MENU_PIN_TO_TOP';
  static const String MENU_PIN_TO_TOP_VALUE = '置顶聊天';
  static const String MENU_DELETE_CONVERSATION = 'MENU_DELETE_CONVERSATION';
  static const String MENU_DELETE_CONVERSATION_VALUE = '删除该聊天';
  static const String MENU_PIN_PA_TO_TOP = 'MENU_PIN_PA_TO_TOP';
  static const String MENU_PIN_PA_TO_TOP_VALUE = '置顶公众号';
  static const String MENU_UNSUBSCRIBE = 'MENU_UNSUBSCRIBE';
  static const String MENU_UNSUBSCRIBE_VALUE = '取消关注';
}