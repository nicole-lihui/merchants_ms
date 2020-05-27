import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:merchant_ms/page/account/widgets/rise_number_text.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/util/image_utils.dart';
import 'package:merchant_ms/widgets/app_bar.dart';
import 'package:merchant_ms/widgets/click_item.dart';

import '../account_router.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(
          centerTitle: '资金管理',
        ),
        body: Column(
          children: <Widget>[
            Gaps.vGap5,
            AspectRatio(
              aspectRatio: 1.85,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 6.0),
                padding: const EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: ImageUtils.getAssetImage('account/bg'),
                        fit: BoxFit.fill)),
                child: Column(
                  children: <Widget>[
                    const _AccountMoney(
// -----------Account Money------------
                      title: '当前余额(元)',
                      money: '30.12',
                      alignment: MainAxisAlignment.end,
                      moneyTextStyle: const TextStyle(
                          color: Colors.white,
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'RobotoThin'),
                    ),
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          const _AccountMoney(title: '累计结算金额', money: '20000'),
                          const _AccountMoney(title: '累计发放佣金', money: '0.02'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Gaps.vGap5,
            ClickItem(
              title: '提现',
              onTap: () =>
                  NavigatorUtils.push(context, AccountRouter.withdrawalPage),
            ),
            ClickItem(
              title: '提现记录',
              onTap: () => NavigatorUtils.push(
                  context, AccountRouter.withdrawalRecordListPage),
            ),
            ClickItem(
              title: '提现密码',
              onTap: () => NavigatorUtils.push(
                  context, AccountRouter.withdrawalPasswordPage),
            ),
          ],
        ));
  }
}

class _AccountMoney extends StatelessWidget {
  final String title;
  final String money;
  final MainAxisAlignment alignment;
  final TextStyle moneyTextStyle;

  const _AccountMoney(
      {Key key,
      @required this.title,
      @required this.money,
      this.alignment,
      this.moneyTextStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: MergeSemantics(
        child: Column(
          mainAxisAlignment: alignment ?? MainAxisAlignment.center,
          children: <Widget>[
            /// 横向撑开Column，扩大语义区域
            const SizedBox(width: double.infinity),
            Text(title,
                style: TextStyle(
                    color: Colours.text_disabled, fontSize: Dimens.font_sp12)),
            Gaps.vGap8,
            RiseNumberText(NumUtil.getDoubleByValueStr(money),
                style: moneyTextStyle ??
                    TextStyle(
                        color: Colours.text_disabled,
                        fontSize: Dimens.font_sp14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'RobotoThin')),
          ],
        ),
      ),
    );
  }
}

