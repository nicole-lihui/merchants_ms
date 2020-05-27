import 'package:flutter/material.dart';
import 'package:merchant_ms/page/account/widgets/sms_verify_dialog.dart';
import 'package:merchant_ms/page/account/widgets/withdrawal_password_setting_dialog.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/util/utils.dart';
import 'package:merchant_ms/widgets/app_bar.dart';
import 'package:merchant_ms/widgets/base_dialog.dart';
import 'package:merchant_ms/widgets/click_item.dart';

class WithdrawalPasswordPage extends StatefulWidget {
  @override
  _WithdrawalPasswordPageState createState() => _WithdrawalPasswordPageState();
}

class _WithdrawalPasswordPageState extends State<WithdrawalPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        centerTitle: '提现密码',
      ),
      body: Column(
        children: <Widget>[
          Gaps.vGap5,
          ClickItem(
              title: '修改密码',
              onTap: () {
                showModalBottomSheet(
                    context: context,

                    /// 使用true则高度不受16分之9的最高限制
                    isScrollControlled: true,
                    builder: (_) => WithdrawalPasswordSettingDialog());
              }),
          ClickItem(
              title: '忘记密码',
              onTap: () {
                showElasticDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return BaseDialog(
                        hiddenTitle: true,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: const Text('为了您的账户安全需先进行短信验证并设置提现密码。',
                              textAlign: TextAlign.center),
                        ),
                        onPressed: () {
                          NavigatorUtils.goBack(context);
                          _showVerifyDialog();
                        },
                      );
                    });
              }),
        ],
      ),
    );
  }

  _showVerifyDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => SMSVerifyDialog());
  }
}
