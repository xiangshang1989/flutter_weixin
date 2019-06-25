import 'package:flutter/material.dart';
class NavigationIconView{
  final Widget _icon;
  final Color _color;
  final String _title;
  final BottomNavigationBarItem item;
  NavigationIconView({Key key, Widget icon, Widget activeIcon, String title, Color color,})
      : _icon = icon,
        _color = color,
        _title = title,
        item = BottomNavigationBarItem(
          icon: icon,
          activeIcon: activeIcon,
          title: Text(title),
          backgroundColor: Colors.white,
        );
}