import 'package:flutter/material.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/routers/routers.dart';
import 'package:merchant_ms/widgets/app_bar.dart';
import 'package:merchant_ms/widgets/load_images.dart';
import 'package:merchant_ms/widgets/my_button.dart';

/// design/2店铺审核/index.html#artboard2
class StoreAuditResultPage extends StatefulWidget {
  @override
  _StoreAuditResultPageState createState() => _StoreAuditResultPageState();
}

class _StoreAuditResultPageState extends State<StoreAuditResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: '审核结果',
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Gaps.vGap50,
            const LoadAssetImage('store/icon_success',
              width: 80.0,
              height: 80.0,
            ),
            Gaps.vGap12,
            Text(
              '恭喜，店铺资料审核成功',
              style: TextStyles.textSize16,
            ),
            Gaps.vGap8,
            Text(
              '2019-02-21 15:20:10',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.vGap8,
            Text(
              '预计完成时间：02月28日',
              style: Theme.of(context).textTheme.subtitle,
            ),
            Gaps.vGap12,
            Gaps.vGap12,
            MyButton(
              onPressed: () {
                NavigatorUtils.push(context, Routers.home, clearStack: true);
              },
              text: '进入',
            )
          ],
        ),
      ),
    );
  }
}
