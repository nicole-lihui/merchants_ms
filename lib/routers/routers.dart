import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:merchant_ms/page/account/account_router.dart';
import 'package:merchant_ms/page/goods/goods_router.dart';
import 'package:merchant_ms/page/home/home_page.dart';
import 'package:merchant_ms/page/home/webview_page.dart';
import 'package:merchant_ms/page/login/login_router.dart';
import 'package:merchant_ms/page/order/order_router.dart';
import 'package:merchant_ms/page/setting/setting_router.dart';
import 'package:merchant_ms/page/shop/shop_router.dart';
import 'package:merchant_ms/page/statistics/statistics_router.dart';
import 'package:merchant_ms/page/store/store_router.dart';
import 'package:merchant_ms/routers/router_init.dart';
import '404.dart';

class Routers {
  static String home = '/home';
  static String webViewPage = '/webview';
  static List<IRouterProvider> _listRouter = [];

  static void configureRouters(Router router) {
    router.define(home,
        handler: Handler(
            handlerFunc:
                (BuildContext context, Map<String, List<String>> params) =>
                    Home()));

    router.define(webViewPage, handler: Handler(handlerFunc: (_, params) {
      String title = params['title']?.first;
      String url = params['url']?.first;
      return WebViewPage(title: title, url: url);
    }));

    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        debugPrint('Not found the target Page');
        return WidgetNotFound();
      });

    /// 各自路由由各自模块管理，统一在此添加初始化
    _listRouter.clear();
    _listRouter.add(LoginRouter());
    _listRouter.add(ShopRouter());
    _listRouter.add(GoodsRouter());
    _listRouter.add(OrderRouter());
    _listRouter.add(StoreRouter());
    _listRouter.add(AccountRouter());
    _listRouter.add(SettingRouter());
    _listRouter.add(StatisticsRouter());

    /// 初始化路由
    _listRouter.forEach((routerProvider) {
      routerProvider.initRouter(router);
    });
  }
}
