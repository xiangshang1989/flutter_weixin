import 'package:flutter/material.dart';
import 'package:flutter_weixin/consnt/app_color.dart';
import 'package:flutter_weixin/model/contact_model.dart';
class ContactItem extends StatelessWidget {
  final Contact contact;
  final String groupTitle;
  static const double MARGIN_VERTICAL = 8.0;
  static const double MARGIN_HORIZONTAL = 16.0;
  static const double GROUP_TITLE_HEIGHT = 34.0;
  const ContactItem({Key key, this.contact, this.groupTitle}) : super(key: key);
   static double getHeight(bool hasGroupTitile){
       if(hasGroupTitile){  //有索引字母
         //上下间距+图片高度+每个item下划线+索引字母高度
         return MARGIN_VERTICAL*2+Constants.ContactAvatarSize+Constants.DividerWidth+GROUP_TITLE_HEIGHT;//上下间距+图片高度+索引字母高度
       }else{
         return MARGIN_VERTICAL*2+Constants.ContactAvatarSize+Constants.DividerWidth;//上下间距+图片高度+每个item下划线
       }
   }

  @override
  Widget build(BuildContext context) {
    double size=Constants.ContactAvatarSize;
    Widget avatar=contact.isAvatarFromNet(contact.avatar) ?
    Image.network(contact.avatar,width:size,height:size):
    Image.asset(contact.avatar,width:size,height:size);
    Widget itemBody;
    ///好友列表的主体部分（头像+姓名）
    Widget _itemBodyOne=Container(
      padding: EdgeInsets.only(left: MARGIN_HORIZONTAL),
//      margin: EdgeInsets.symmetric(horizontal: 16.0), 设置水平方向左右两边对称都为16间距
      color: Colors.white,
      child: Container(
        padding : EdgeInsets.fromLTRB(0, MARGIN_VERTICAL, 0, MARGIN_VERTICAL),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(width: Constants.DividerWidth,color: Color(AppColor.DividerColor))
          ),
        ),
        child: Row(
          children: <Widget>[
            avatar,
            SizedBox(width: 10.0,),
            Text(contact.name,style: AppStyles.GroupTitleItemTextStyle,)
          ],
        ),
      ),
    );
    if(groupTitle!=null){  //好友列表上面有字母序号）
      itemBody=Column(
        children: <Widget>[
          Container(
            height: GROUP_TITLE_HEIGHT,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.fromLTRB(16, 0, 0, 0),
            color:  const Color(AppColor.ContactGroupTitleBg),
            child: Text(groupTitle,style: AppStyles.GroupTitleItemTextStyle,),
          ),
          _itemBodyOne
        ],
      );
    }else{
      itemBody=_itemBodyOne;
    }
    return itemBody;
  }
}
