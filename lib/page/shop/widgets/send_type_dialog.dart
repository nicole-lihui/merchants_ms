import 'package:flutter/material.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/widgets/base_dialog.dart';
import 'package:merchant_ms/widgets/load_images.dart';

class SendTypeDialog extends StatefulWidget{

  final Function(int, String) onPressed;

  SendTypeDialog({
    Key key,
    this.onPressed,
  }) : super(key : key);
  
  @override
  _SendTypeDialog createState() => _SendTypeDialog();
  
}

class _SendTypeDialog extends State<SendTypeDialog>{

  int _value = 0;
  var _list = ['运费满免配置', '运费比例配置'];

  Widget getItem(int index) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: SizedBox(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Text(
                  _list[index],
                  style: _value == index ? TextStyle(
                    fontSize: Dimens.font_sp14,
                    color: Theme.of(context).primaryColor,
                  ) : null,
                ),
              ),
              Offstage(
                  offstage: _value != index,
                  child: const LoadAssetImage('order/ic_check', width: 16.0, height: 16.0)),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: () {
          if (mounted) {
            setState(() {
              _value = index;
            });
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: '运费配置',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getItem(0),
          getItem(1),
        ],
      ),
      onPressed: () {
        NavigatorUtils.goBack(context);
        widget.onPressed(_value, _list[_value]);
      },
    );
  }
}
