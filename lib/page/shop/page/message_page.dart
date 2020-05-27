import 'package:flutter/material.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/widgets/app_bar.dart';
import 'package:merchant_ms/widgets/my_card.dart';

class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        centerTitle: '消息',
        actionName: '全部已读',
        onPressed: () {},
      ),
      body: ListView.builder(
        itemCount: 20,
        physics: AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 28.0),
        itemBuilder: (_, index) => _MessageItem()
      ),
    );
  }
}


class _MessageItem extends StatefulWidget {
  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<_MessageItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Gaps.vGap15,
        Text('2019-5-31 17:19:36', style: Theme.of(context).textTheme.subtitle),
        Gaps.vGap8,
        MyCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(child: Text('系统通知')),
                    Container(
                      margin: const EdgeInsets.only(right: 4.0),
                      height: 8.0,
                      width: 8.0,
                      decoration: BoxDecoration(
                        color: Colours.app_main,
                        borderRadius: BorderRadius.circular(4.0),
                      ),
                    ),
                    Images.arrowRight
                  ],
                ),
                Gaps.vGap8,
                Gaps.line,
                Gaps.vGap8,
                Text('供货商由于[商品缺货]原因，取消了采购订单。', style: TextStyles.textSize12),
              ],
            ),
          ),
        )
      ],
    );
  }
}
