import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:merchant_ms/common/common.dart';
import 'package:merchant_ms/page/order/models/order_entity.dart';
import 'package:merchant_ms/page/order/order_router.dart';
import 'package:merchant_ms/page/order/widgets/pay_type_dialog.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/util/theme_utils.dart';
import 'package:merchant_ms/util/toast.dart';
import 'package:merchant_ms/util/utils.dart';
import 'package:merchant_ms/widgets/my_card.dart';

class OrderItem extends StatelessWidget {
  final int tabIndex;
  final int index;
  final OrderItemEntity orderInfo;

  const OrderItem({
    Key key,
    @required this.tabIndex,
    @required this.index,
    @required this.orderInfo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextStyle textTextStyle =
        Theme.of(context).textTheme.body1.copyWith(fontSize: Dimens.font_sp12);
    bool isDark = ThemeUtils.isDark(context);

    Widget buildGrid() {
      if (orderInfo == null) {
        return null;
      }
      var goodsName = orderInfo.goodsName;

      var goodsCount = orderInfo.goodsCount;
      List<Widget> goods = [];
      Widget content;
// 遍历显示订单商品
      for (var i = 0; i < goodsName.length; i++) {
        goods.add(Gaps.vGap8);
        goods.add(
          RichText(
              text: TextSpan(
            style: textTextStyle,
            children: <TextSpan>[
              TextSpan(text: '${goodsName[i]}清凉一度抽纸'),
              TextSpan(
                  text: '  x${goodsCount[i]}', style: Theme.of(context).textTheme.subtitle),
            ],
          )),
        );
      }

      content = new Column(
        children: goods,
      );

      return content;
    }

    Widget ExampleWidget = buildGrid();

    return Container(
        margin: const EdgeInsets.only(top: 8.0),
        child: MyCard(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () =>
                  NavigatorUtils.push(context,
                        '${OrderRouter.orderInfoPage}?id=${orderInfo.id}'),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Text('${orderInfo.phone}（${orderInfo.userName}）'),
                      ),
                      Text(
                        '货到付款',
                        style: TextStyle(
                            fontSize: Dimens.font_sp12,
                            color: Theme.of(context).errorColor),
                      ),
                    ],
                  ),
                  Gaps.vGap8,
                  Text(
                    '${orderInfo.address}',
                    style: Theme.of(context).textTheme.subtitle,
                  ),
                  Gaps.vGap8,
                  Gaps.line,
                  ExampleWidget,
                  Gaps.vGap12,
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RichText(
                            text: TextSpan(
                          style: textTextStyle,
                          children: <TextSpan>[
                            TextSpan(
                                text: Utils.formatPrice('${orderInfo.price}',
                                    format: MoneyFormat.NORMAL)),
                            TextSpan(
                                text: '  共${orderInfo.count}件商品',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(fontSize: Dimens.font_sp10)),
                          ],
                        )),
                      ),
                      Text(
                        '${orderInfo.startTime}',
                        style: TextStyles.textSize12,
                      ),
                    ],
                  ),
                  Gaps.vGap8,
                  Gaps.line,
                  Gaps.vGap8,
                  Row(
                    children: <Widget>[
                      OrderItemButton(
                        key: Key('order_button_1_$index'),
                        text: '联系客户',
                        textColor: isDark ? Colours.dark_text : Colours.text,
                        bgColor:
                            isDark ? Colours.dark_material_bg : Colours.bg_gray,
                        onTap: () =>
                            _showCallPhoneDialog(context, '${orderInfo.phone}'),
                      ),
                      Expanded(
                        child: Gaps.empty,
                      ),
                      OrderItemButton(
                        key: Key('order_button_2_$index'),
                        text: Constant.orderLeftButtonText[tabIndex],
                        textColor: isDark ? Colours.dark_text : Colours.text,
                        bgColor:
                            isDark ? Colours.dark_material_bg : Colours.bg_gray,
                        onTap: () {
                          if (tabIndex >= 2) {
                            NavigatorUtils.push(
                                context, OrderRouter.orderTrackPage);
                          }
                        },
                      ),
                      Constant.orderRightButtonText[tabIndex].length == 0
                          ? Gaps.empty
                          : Gaps.hGap10,
                      Constant.orderRightButtonText[tabIndex].length == 0
                          ? Gaps.empty
                          : OrderItemButton(
                              key: Key('order_button_3_$index'),
                              text: Constant.orderRightButtonText[tabIndex],
                              textColor: isDark
                                  ? Colours.dark_button_text
                                  : Colors.white,
                              bgColor: isDark
                                  ? Colours.dark_app_main
                                  : Colours.app_main,
                              onTap: () {
                                if (tabIndex == 2) {
                                  showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return PayTypeDialog(
                                          onPressed: (index, type) {
                                            Toast.show('收款类型：$type');
                                          },
                                        );
                                      });
                                }
                              },
                            ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void _showCallPhoneDialog(BuildContext context, String phone) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('提示'),
            content: Text('是否拨打：$phone ?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => NavigatorUtils.goBack(context),
                child: const Text('取消'),
              ),
              FlatButton(
                onPressed: () {
                  Utils.launchTelURL(phone);
                  NavigatorUtils.goBack(context);
                },
                textColor: Theme.of(context).errorColor,
                child: const Text('拨打'),
              ),
            ],
          );
        });
  }
}

class OrderItemButton extends StatelessWidget {
  const OrderItemButton(
      {Key key, this.bgColor, this.textColor, this.text, this.onTap})
      : super(key: key);

  final Color bgColor;
  final Color textColor;
  final GestureTapCallback onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 14.0),
        decoration: BoxDecoration(
            color: bgColor, borderRadius: BorderRadius.circular(4.0)),
        constraints:
            BoxConstraints(minWidth: 64.0, maxHeight: 30.0, minHeight: 30.0),
        child: Text(
          text,
          style: TextStyle(fontSize: Dimens.font_sp14, color: textColor),
        ),
      ),
      onTap: onTap,
    );
  }
}
