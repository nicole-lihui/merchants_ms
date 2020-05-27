import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:merchant_ms/common/common.dart';
import 'package:merchant_ms/page/login/login_router.dart';
import 'package:merchant_ms/provider/theme_provider.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/util/image_utils.dart';
import 'package:merchant_ms/util/theme_utils.dart';
import 'package:merchant_ms/widgets/load_images.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';


class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  
  int _status = 0;
  List<String> _guideList = ['app_start_1', 'app_start_2', 'app_start_3'];
  StreamSubscription _subscription;

  void _initGuide() {
    setState(() {
      _status = 1;
    });
  }

  void _goLogin() {
    NavigatorUtils.push(context, LoginRouter.loginPage, replace: true);
  }

  void _initSplash() {
    _subscription = Observable.just(1).delay(Duration(milliseconds: 1500)).listen((_) {
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        SpUtil.putBool(Constant.keyGuide, false);
        _initGuide();
      } else {
        _goLogin();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // SpUtil未初始化，所以MaterialApp获取的为默认主题配置，同步一下。
      await SpUtil.getInstance();
      Provider.of<ThemeProvider>(context, listen: false).syncTheme();
      if (SpUtil.getBool(Constant.keyGuide, defValue: true)) {
        // 预先缓存图片，避免直接使用时因为首次加载造成闪动       
        _guideList.forEach((img) {
          precacheImage(ImageUtils.getAssetImage(img), context);
        });
      }
      _initSplash();
    });
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ThemeUtils.getBackgroundColor(context),
      child: _status == 0 ? FractionallyAlignedSizedBox(
        heightFactor: 0.3,
        widthFactor: 0.33,
        leftFactor: 0.33,
        bottomFactor: 0,
        child: const LoadAssetImage('logo')
      ) : Swiper(
        key: const Key('swiper'),
        itemCount: _guideList.length,
        loop: false,
        itemBuilder: (_, index) {
          return LoadAssetImage(
            _guideList[index],
            key: Key(_guideList[index]),
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          );
        },
         onTap: (index) {
          if (index == _guideList.length - 1) {
            _goLogin();
          }
        },
      ),
    );
  }
  
}
