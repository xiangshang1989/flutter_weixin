import 'package:flutter/material.dart';
import 'package:flutter_weixin/consnt/app_color.dart';

class FullWidthItem extends StatelessWidget {
  static const VERTICAL_PADDING = 16.0;
  final String title;
  final String iconPath;
  final VoidCallback onPressed;
  final bool showDivider;
  const FullWidthItem({Key key, this.title, this.iconPath, this.onPressed, this.showDivider}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final Border _border = showDivider
        ? Border(bottom: BorderSide(color: const Color(AppColor.DividerColor), width: Constants.DividerWidth))
        : null;
    return Material(
      color: Colors.white,
      child: InkWell(
          onTap: onPressed,
          child: new Container(
            padding: EdgeInsets.only(left: VERTICAL_PADDING),
            child: Container(
              padding: EdgeInsets.fromLTRB(0, VERTICAL_PADDING, VERTICAL_PADDING, VERTICAL_PADDING),
              decoration: BoxDecoration(
                border: _border,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: <Widget>[
                        Image.asset(iconPath,width: Constants.FullWidthIconButtonIconSize,height:Constants.FullWidthIconButtonIconSize),
                        SizedBox(width: 16.0),
                        Text(title,style: AppStyles.TitleStyle),
                      ],
                    ),
                  ),
                  Icon(
                      IconData(0xe604, fontFamily: Constants.IconFontFamily,), size: 16.0,
                      color: const Color(AppColor.ButtonArrowColor))
                ],
              ),
            ),
          )
      ),
    );
  }
}
