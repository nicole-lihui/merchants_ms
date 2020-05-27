import 'package:flutter/material.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/util/theme_utils.dart';
import 'package:merchant_ms/widgets/load_images.dart';
import 'package:merchant_ms/widgets/my_card.dart';

class OrderTagItem extends StatelessWidget {
  final String date;
  final int orderTotal;

  const OrderTagItem({
    Key key,
    @required this.date,
    @required this.orderTotal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      child: MyCard(
          child: Container(
        height: 34.0,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          children: <Widget>[
            ThemeUtils.isDark(context)
                ? const LoadAssetImage('order/icon_calendar_dark',
                    width: 14.0, height: 14.0)
                : const LoadAssetImage('order/icon_calendar',
                    width: 14.0, height: 14.0),
            Gaps.hGap10,
            Text(date),
            Expanded(child: Gaps.empty),
            Text('$orderTotal单')
          ],
        ),
      )),
    );
  }
}
