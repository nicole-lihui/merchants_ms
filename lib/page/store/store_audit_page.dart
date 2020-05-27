import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:merchant_ms/page/shop/shop_router.dart';
import 'package:merchant_ms/page/store/store_router.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/util/theme_utils.dart';
import 'package:merchant_ms/util/toast.dart';
import 'package:merchant_ms/widgets/app_bar.dart';
import 'package:merchant_ms/widgets/my_button.dart';
import 'package:merchant_ms/widgets/selected_image.dart';
import 'package:merchant_ms/widgets/store_select_text_item.dart';
import 'package:merchant_ms/widgets/text_field_item.dart';

/// design/2店铺审核/index.html
class StoreAuditPage extends StatefulWidget {
  @override
  _StoreAuditPageState createState() => _StoreAuditPageState();
}

class _StoreAuditPageState extends State<StoreAuditPage> {
  File _imageFile;
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  final FocusNode _nodeText3 = FocusNode();
  String _address = '陕西省 西安市 雁塔区 高新六路201号';

  void _getImage() async {
    try {
      //  适用于iOS和Android的Flutter插件，用于从图像库中拾取图像，并使用相机拍摄新照片。
      _imageFile = await ImagePicker.pickImage(
          source: ImageSource.gallery, maxWidth: 800, imageQuality: 95);
    } catch (e) {
      Toast.show('没有权限，无法打开相册');
    }
  }

  KeyboardActionsConfig _buildConfig(BuildContext context) {
    return KeyboardActionsConfig(
      keyboardActionsPlatform: KeyboardActionsPlatform.IOS,
      // keyboardActionsPlatform: KeyboardActionsPlatform.All,
      keyboardBarColor: ThemeUtils.getKeyboardActionsColor(context),
      nextFocus: true,
      actions: [
        KeyboardAction(
          focusNode: _nodeText1,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText2,
          displayCloseWidget: false,
        ),
        KeyboardAction(
          focusNode: _nodeText3,
          closeWidget: Padding(
            padding: EdgeInsets.all(5.0),
            child: const Text('关闭'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: const MyAppBar(
        centerTitle: '店铺审核资料',
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: defaultTargetPlatform == TargetPlatform.iOS
                  ? FormKeyboardActions(child: _buildBody())
                  : SingleChildScrollView(child: _buildBody()),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 8.0),
              child: MyButton(
                onPressed: () {
                  NavigatorUtils.push(context, StoreRouter.auditResultPage);
                },
                text: '提交',
              ),
            )
          ],
        ),
      ),
    );
  }

  String _sortName = '';
  var _list = [
    '水果生鲜',
    '家用电器',
    '休闲食品',
    '茶酒饮料',
    '美妆个护',
    '粮油调味',
    '家庭清洁',
    '厨具用品',
    '儿童玩具',
    '床上用品'
  ];

  _showBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 360.0,
          child: ListView.builder(
            key: const Key('goods_sort'),
            itemExtent: 48.0,
            itemBuilder: (_, index) {
              return InkWell(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(_list[index]),
                ),
                onTap: () {
                  setState(() {
                    _sortName = _list[index];
                  });
                  NavigatorUtils.goBack(context);
                },
              );
            },
            itemCount: _list.length,
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      // Row水平方向   Column 垂直方向
      child: Column(
        // MainAxisAlignment（主轴）就是与当前控件方向一致的轴，而CrossAxisAlignment（交叉轴）就是与当前控件方向垂直的轴
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Gaps.vGap5,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text('店铺资料', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          Center(
            child: SelectedImage(image: _imageFile, onTap: _getImage),
          ),
          Gaps.vGap10,
          Center(
            child: Text(
              '店主手持身份证或营业执照',
              style: Theme.of(context)
                  .textTheme
                  .subtitle
                  .copyWith(fontSize: Dimens.font_sp14),
            ),
          ),
          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText1, title: '店铺名称', hintText: '填写店铺名称'),
          StoreSelectTextItem(
              title: '主营范围',
              content: _sortName,
              onTap: () => _showBottomSheet()),
          StoreSelectTextItem(
              title: '店铺地址',
              content: _address,
              onTap: () {
                NavigatorUtils.pushResult(context, ShopRouter.addressSelectPage,
                    (result) {
                  setState(() {
                    PoiSearch model = result;
                    _address = model.provinceName +
                        ' ' +
                        model.cityName +
                        ' ' +
                        model.adName +
                        ' ' +
                        model.title;
                  });
                });
              }),
          Gaps.vGap16,
          Gaps.vGap16,
          const Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: const Text('店主信息', style: TextStyles.textBold18),
          ),
          Gaps.vGap16,
          TextFieldItem(
              focusNode: _nodeText2, title: '店主姓名', hintText: '填写店主姓名'),
          TextFieldItem(
              focusNode: _nodeText3,
              config: _buildConfig(context),
              keyboardType: TextInputType.phone,
              title: '联系电话',
              hintText: '填写店主联系电话')
        ],
      ),
    );
  }
}
