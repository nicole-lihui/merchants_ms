import 'package:flutter/material.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';

class GoodsDeleteBottomSheet extends StatelessWidget {
  
  final Function onTapDelete;
  
  const GoodsDeleteBottomSheet({
    Key key,
    @required this.onTapDelete,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SizedBox(
            height: 161.2,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  height: 52.0,
                  child: const Center(
                    child: const Text(
                      '是否确认删除，防止错误操作',
                      style: TextStyles.textSize16,
                    ),
                  ),
                ),
                Gaps.line,
                SizedBox(
                  height: 54.0,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Theme.of(context).errorColor,
                    child: const Text('确认删除', style: TextStyle(fontSize: Dimens.font_sp18)),
                    onPressed: () {
                      NavigatorUtils.goBack(context);
                      onTapDelete();
                    },
                  ),
                ),
                Gaps.line,
                SizedBox(
                  height: 54.0,
                  width: double.infinity,
                  child: FlatButton(
                    textColor: Colours.text_gray,
                    child: const Text('取消', style: TextStyle(fontSize: Dimens.font_sp18)),
                    onPressed: () {
                      NavigatorUtils.goBack(context);
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
