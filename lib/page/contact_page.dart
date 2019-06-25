import 'package:flutter/material.dart';
import 'package:flutter_weixin/consnt/app_color.dart';
import 'package:flutter_weixin/model/contact_model.dart';

import 'contact_item.dart';

class ContactPage extends StatefulWidget {
  String _showLetter = '';
  @override
  _ContactPageState createState() => new _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  List<Contact> contacts=[];
  List<Contact> contactTops=[];
  List<Widget> letterWidgets=[];
  Color _indexBarBg = Colors.transparent;
  final ScrollController _controller=ScrollController();
  //默认点击"↑", "☆" 时，都返回最顶部
  final Map _letterPosMap = {ContactsModel.INDEX_BAR_WORDS[0]: 0.0,ContactsModel.INDEX_BAR_WORDS[1]: 0.0};
  @override
  void initState() {
    super.initState();
     //    微信好友数据
    contacts..addAll(ContactsModel.mock().contacts)
            ..addAll(ContactsModel.mock().contacts)
            ..addAll(ContactsModel.mock().contacts);
    ///最上面的四个不变的（新的朋友、群聊、标签、公众号）
    contactTops=ContactsModel.mock().contactTops;
    ///对好友进行排序排序
    contacts.sort((Contact o1,Contact o2)=>o1.nameIndex.compareTo(o2.nameIndex));
    ///添加右边的索引字母(Expanded  平均分配)
    letterWidgets=ContactsModel.INDEX_BAR_WORDS.map((String word){
        return Expanded(child: Text(word));
     }).toList();
    ///计算用于 IndexBar 进行定位的关键通讯录列表项的位置
    double _totalPostion=contactTops.length*ContactItem.getHeight(false);//最上面的四个不变的总高度
    for(int i=0;i<contacts.length;i++){
      bool hasGroupTitle=true;//默认第一个item有索引字母显示
      //如果当前的索引字母和它的上一个索引字母相同，则隐藏当前的索引字母
      if(i>=1&&contacts[i].nameIndex.compareTo(contacts[i-1].nameIndex)==0){
        hasGroupTitle=false;
      }
      if(hasGroupTitle){  //将索引字母和它对应的position绑定在map里
        _letterPosMap[contacts[i].nameIndex]=_totalPostion;
      }
      _totalPostion+=ContactItem.getHeight(hasGroupTitle);
    }
  }
  @override
  void dispose() {
    super.dispose();
    if(_controller!=null)_controller.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          child: ListView.builder(
            controller: _controller,
            itemBuilder: (context,index){
              ///通讯录上面的头部四个不变的部分
              if(index<contactTops.length){
                return ContactItem(contact: contactTops[index],groupTitle: null);
              }
              int _currentIndex=index-contactTops.length;
              Contact contact = contacts[_currentIndex];
              bool isGroupTitle=true;//默认显示字母索引值
              //如果索引大于等于1（索引为0的第一个默认显示字母索引）并且和它的上一个索引字母一样的话则隐藏字母索引值
              if(_currentIndex>=1&&contact.nameIndex==contacts[_currentIndex-1].nameIndex){
                isGroupTitle=false;
              }
              ///通讯录里面真正从网络获取的好友信息
              String groupTitle=isGroupTitle ? contact.nameIndex : null;
              return ContactItem(contact: contact,groupTitle: groupTitle,);
            },
            itemCount:contacts.length+contactTops.length ,
          ),
        ),
        Positioned(
          width: Constants.IndexBarWidth,
            top: 0.0,
            bottom: 0.0,
            right: 0.0,
            child: Container(
              color: _indexBarBg,
              child: LayoutBuilder(  //类似于Android生命周期的onLayout方法，此组件可以获取view的size（高和宽）
                  builder: _buildIndexBar
              ),
            )
        ),
        Center(
          child: (widget._showLetter!=null && widget._showLetter.isNotEmpty ) //当手指触摸在indexBar上时，显示中间字母
             ? Container(
            width: Constants.IndexLetterBoxSize,
            height: Constants.IndexLetterBoxSize,
            decoration: BoxDecoration(
              color: AppColor.IndexLetterBoxBg,
              borderRadius: BorderRadius.circular(Constants.IndexLetterBoxRadius)
            ),
             alignment: Alignment.center,
             child: Text(widget._showLetter,style: AppStyles.IndexLetterBoxTextStyle,),
          ) : null,
        )
      ],
    );
  }

 ///BoxConstraints  存储父view 的信息
 Widget _buildIndexBar(BuildContext context, BoxConstraints constraints){
    //获取父view最大的高度也就是indexBar的总高度
   double allHeight = constraints.biggest.height;
   //获取单个索引字母的高度
   double indexBarTitleHeight=allHeight/ ContactsModel.INDEX_BAR_WORDS.length;
    return GestureDetector(
      onVerticalDragDown: (DragDownDetails details){  //竖直方向手指按下监听
        setState(() {
          _indexBarBg=Colors.black26;
          widget._showLetter=_getLetter(context,indexBarTitleHeight,details.globalPosition);
          _jumpToIndex(widget._showLetter);
        });

      },
      onVerticalDragEnd: (DragEndDetails details){    //竖直方向手指滑动过程中松开监听
        setState(() {
          _indexBarBg=Colors.transparent;
          widget._showLetter="";
        });
      },
      onVerticalDragCancel: (){ //竖直方向 手指松开监听
        setState(() {
          _indexBarBg=Colors.transparent;
          widget._showLetter="";
        });
      },
      onVerticalDragUpdate: (DragUpdateDetails details){ //竖直方向 手指移动更新监听
        setState(() {
          widget._showLetter=_getLetter(context,indexBarTitleHeight,details.globalPosition);
          _jumpToIndex( widget._showLetter);
        });
      },
        child: Column(
          children: letterWidgets,
        ),
    );
  }
  ///获取对应位置的索引字母
  String _getLetter(BuildContext context,double indexBarTitleHeight, Offset offset){
    //通过LayoutBuilder提供的context里面的findRenderObject方法来获取RenderBox
    RenderBox renderBox=context.findRenderObject();
    //通过RenderBox来获取相对于indexBar自身的坐标值，而不是相对于手机屏幕的坐标值
    var localOffset = renderBox.globalToLocal(offset);
    print("localOffset---${localOffset.dy}");
    //clamp(num lowerLimit, num upperLimit)可以设置它的取值范围在一定范围之内，超出的话就不返回值，
    //( ~/ 代表取整 )
    int index=(localOffset.dy ~/ indexBarTitleHeight).clamp(0, ContactsModel.INDEX_BAR_WORDS.length-1);
    print("index---${index}");
    return ContactsModel.INDEX_BAR_WORDS[index];
  }
  ///触摸索引字母跳转滑动到对应的字母显示
  _jumpToIndex(String letter){
    if(_letterPosMap.isNotEmpty&&_letterPosMap[letter]!=null){
    _controller.animateTo(_letterPosMap[letter], duration: Duration(milliseconds: 100), curve: Curves.linear);
    }
  }
}
