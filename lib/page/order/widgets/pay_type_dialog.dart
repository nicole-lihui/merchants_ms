import 'package:flutter/material.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/widgets/base_dialog.dart';
import 'package:merchant_ms/widgets/load_images.dart';

class PayTypeDialog extends StatefulWidget {
  final Function(int, String) onPressed;

  PayTypeDialog({
    Key key,
    this.onPressed,
  }) : super(key: key);

  @override
  _PayTypeDialog createState() => _PayTypeDialog();
}

class _PayTypeDialog extends State<PayTypeDialog> {
  int _value = 0;
  var _list = ['未收款', '支付宝', '微信', '现金'];

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
                  style: _value == index
                      ? TextStyle(
                          fontSize: Dimens.font_sp14,
                          color: Theme.of(context).primaryColor,
                        )
                      : null,
                ),
              ),
              Offstage(
                  offstage: _value != index,
                  child: const LoadAssetImage('order/ic_check',
                      width: 16.0, height: 16.0)),
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
      title: '收款方式',
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getItem(0),
          getItem(1),
          getItem(2),
          getItem(3),
        ],
      ),
      onPressed: () {
        NavigatorUtils.goBack(context);
        widget.onPressed(_value, _list[_value]);
      },
    );
  }
}
