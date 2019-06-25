import 'package:flutter/material.dart';
import 'package:flutter_weixin/consnt/app_color.dart';
import 'package:flutter_weixin/custom/full_width_custom.dart';
import 'package:flutter_weixin/i18n/strings.dart';
import 'package:flutter_weixin/model/me.dart';
class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => new _MinePageState();
}

class _MinePageState extends State<MinePage> {
  static const SEPARATOR_SIZE = 10.0;
  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Color(AppColor.BackgroundColor),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            _HeaderWidget(),
            SizedBox(height: SEPARATOR_SIZE),
            FullWidthCustomWidget(
              iconPath: 'assets/images/ic_wallet.png',
              title: Strings.Payments,
              onPressed: () {
                print('点击的是钱包按钮。');
              },
            ),
            SizedBox(height: SEPARATOR_SIZE),
            FullWidthCustomWidget(
              iconPath: 'assets/images/ic_collections.png',
              title: Strings.Collections,
              showDivider: true,
              onPressed: () {
                print('点击的是收藏按钮。');
              },
            ),
            FullWidthCustomWidget(
              iconPath: 'assets/images/ic_album.png',
              title: Strings.Album,
              showDivider: true,
              onPressed: () {
                print('点击的是相册按钮。');
              },
            ),
            FullWidthCustomWidget(
              iconPath: 'assets/images/ic_cards_wallet.png',
              title: Strings.Wallet,
              showDivider: true,
              onPressed: () {
                print('打开卡包应用');
              },
            ),
            FullWidthCustomWidget(
              iconPath: 'assets/images/ic_emotions.png',
              title: Strings.Emotions,
              onPressed: () {
                print('打开表情应用');
              },
            ),
            SizedBox(height: SEPARATOR_SIZE),
            FullWidthCustomWidget(
              iconPath: 'assets/images/ic_settings.png',
              title: Strings.Settings,
              des: Strings.AccountNotProtected,
              showRightArrow: false,
              onPressed: () {
                print('打开设置');
              },
            ),
          ],
        ),
      ),
    );
  }
}
///头布局
class _HeaderWidget extends StatelessWidget {
  static const AVATAR_SIZE = 64.0;
  static const RADIUS = 6.0;
  static const SEPARATOR_SIZE = 16.0;
  static const QR_CODE_PREV_SIZE = 20.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: AppColor.HeaderCardBg,
        padding: const EdgeInsets.only(left: 32.0, right: 20.0, top: 0.0, bottom: 42.0),
        child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(RADIUS),
            child: Image.network( me.avatar, width: AVATAR_SIZE, height: AVATAR_SIZE),
          ),
          Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: SEPARATOR_SIZE, bottom: 5.0),
                    child: Text(me.name, style: AppStyles.HeaderCardTitleTextStyle),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.only(left: SEPARATOR_SIZE),
                          child: Text('${Strings.WechatAccountIs}${me.account}', style: AppStyles.HeaderCardDesTextStyle))
                      ),
                      Image.asset(
                        'assets/images/ic_qrcode_preview_tiny.png',
                        width: QR_CODE_PREV_SIZE,
                        height: QR_CODE_PREV_SIZE,
                      ),
                      FullWidthCustomWidget.arrowRight(),
                    ],
                  )
                ],
              ),
          )
        ],
        ),
      ),
    );
  }
}

