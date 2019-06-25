import 'package:flutter/material.dart';
import 'package:flutter_weixin/consnt/app_color.dart';

///自定义的通用组件
 class FullWidthCustomWidget extends StatelessWidget {
   static const HORIZONTAL_PADDING = 20.0;
   static const VERTICAL_PADDING = 16.0;
   static const HEIGHT = Constants.FullWidthIconButtonIconSize + VERTICAL_PADDING * 2;
   static const TAG_IMG_SIZE = 28.0;
   static const TAG_IMG_SIZE_BIG = 32.0;
   static const DOT_RADIUS = 5.0;
   final String iconPath;  //最左边的图标
   final String title;    //标题
   final bool showDivider;  //是否显示间隔线
   final bool showRightArrow;  //是否显示最右边的箭头图标
   final VoidCallback onPressed; //监听回调
   final String des;  //最左边的提示内容
   final Widget customWidget; //child组件
  const FullWidthCustomWidget(
      {@required this.iconPath,@required this.title,
        this.showDivider=false, this.showRightArrow=true,
        this.onPressed, this.des, this.customWidget}): assert(iconPath != null), assert(title != null);

   @override
   Widget build(BuildContext context) {
     Color borderColor= const Color(AppColor.DividerColor);
     double borderWidth=Constants.DividerWidth;
     //是否有无间隔线
     Border _border= showDivider ? Border(bottom: BorderSide( color: borderColor, width: borderWidth)) : null;
     final _rightAreaElements = <Widget>[];
     if (this.customWidget != null) {
       _rightAreaElements..add(Text(title, style: AppStyles.TitleStyle))..add(Expanded(child: customWidget));
     }else if(this.des != null){  //是否显示最右边的提示内容
       _rightAreaElements..add(Text(title, style: AppStyles.TitleStyle))..add(Expanded(child: Container(alignment: Alignment.centerRight, child: desText(this.des))));
     }else{
       _rightAreaElements.add(Expanded(child: Text(title, style: AppStyles.TitleStyle)));
     }
     // 是否显示最右边的箭头
     if (this.showRightArrow) {
       _rightAreaElements.add(arrowRight());
     }
     return FlatButton(
       padding: EdgeInsets.fromLTRB(HORIZONTAL_PADDING, 0, HORIZONTAL_PADDING, 0),
       color: Colors.white,
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: <Widget>[
           Image.asset(  //最右边的图标
             iconPath,
             width: Constants.FullWidthIconButtonIconSize,
             height: Constants.FullWidthIconButtonIconSize,
           ),
           SizedBox(width: HORIZONTAL_PADDING),
           Expanded(
               child: Container(
                 height: HEIGHT,
                 alignment: Alignment.centerLeft,
                 decoration: BoxDecoration(border: _border),
                 child: Row(
                   children: _rightAreaElements,
                 ),
               )
           ),
         ],
       ),
         onPressed: () {},
     );
   }
   /// 按钮上的描述性文字控件
   /// * [des] 显示在文本上的信息
   static Text desText(final des) {
     return Text(des, style: AppStyles.ButtonDesTextStyle);
   }
   /// 按钮右边的指示箭头
   static Widget arrowRight() {
     return Icon(
         IconData(0xe604, fontFamily: Constants.IconFontFamily,),
         size: 16.0,
         color: const Color(AppColor.ButtonArrowColor)
     );
   }
   /// 按钮上的图片标签，可以根据 [path] 的内容自动生成assets或者网络上的图片
   /// * [path] 图片在assets文件夹中的路径或者网络上的URL
   /// * [showDot] 是否需要显示图标右上角的原点
   /// * [isBig] 图标的大小
   static Widget iconTag(final String path, {bool showDot = false, bool isBig = false}) {
     bool network=path.startsWith('http');
     double size=isBig ? TAG_IMG_SIZE_BIG : TAG_IMG_SIZE;
     final avatarIcon=ClipRRect(
       borderRadius: BorderRadius.circular(Constants.AvatarRadius),
       child: network ? Image.network(path,width: size,height: size)
                      : Image.asset(path,width: size,height: size),
     );
     if(showDot){
       return Stack(
         overflow: Overflow.visible,
         children: <Widget>[
           avatarIcon,
           Positioned(
               right: isBig ? -3.0 : -7.0,
               top: isBig ? -3.0 : -7.0,
               child: Container(
                 width: DOT_RADIUS * 2,
                 height: DOT_RADIUS * 2,
                 decoration: BoxDecoration(
                   color: Color(AppColor.NotifyDotBg),
                   borderRadius: BorderRadius.circular(DOT_RADIUS),
                 ),
               )
           ),
         ],
       );
     }
     return avatarIcon;
   }

   /// 按钮上的圆角文本标签控件
   /// * [content] 标签上的显示文本
   static Widget tag(final content) {
     return Container(
       height: 20,
       alignment: Alignment.center,
       margin: const EdgeInsets.only(left: 6.0),
       padding: const EdgeInsets.only(left: 6.0, right: 6.0),
       decoration: BoxDecoration(
           color: const Color(AppColor.NewTagBg),
           borderRadius: BorderRadius.circular(10.0)),
       child: Text(content, style: AppStyles.NewTagTextStyle),
       );

   }
 }
