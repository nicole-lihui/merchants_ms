import 'package:flutter/material.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/widgets/app_bar.dart';
import 'package:merchant_ms/widgets/load_images.dart';
import 'package:merchant_ms/widgets/my_button.dart';

class WithdrawalResultPage extends StatefulWidget {
  @override
  _WithdrawalResultPageState createState() => _WithdrawalResultPageState();
}

class _WithdrawalResultPageState extends State<WithdrawalResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '提现结果',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap50,
            const LoadAssetImage(
              'account/sqsb',
              width: 80.0,
              height: 80.0,
            ),
            Gaps.vGap12,
            Text(
              '提现申请提交失败，请重新提交',
              style: TextStyles.textSize16,
            ),
            Gaps.vGap8,
            Text(
              '2020-05-31 15:20:10',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.vGap8,
            Text(
              '5秒后返回提现页面',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.vGap12,
            Gaps.vGap12,
            MyButton(
              onPressed: () => NavigatorUtils.goBack(context),
              text: '返回',
            )
          ],
        ),
      ),
    );
  }
}
