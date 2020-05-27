import 'package:fluro/fluro.dart';
import 'package:merchant_ms/page/order/page/order_info_page.dart';
import 'package:merchant_ms/page/order/page/order_page.dart';
import 'package:merchant_ms/page/order/page/order_search_page.dart';
import 'package:merchant_ms/page/order/page/order_track_page.dart';
import 'package:merchant_ms/routers/router_init.dart';

class OrderRouter implements IRouterProvider{

  static String orderPage = '/order';
  static String orderInfoPage = '/order/info';
  static String orderSearchPage = '/order/search';
  static String orderTrackPage = '/order/track';
  
  @override
  void initRouter(Router router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, params) => OrderPage()));
    // router.define(orderInfoPage, handler: Handler(handlerFunc: (_, params) => OrderInfoPage()));
    router.define(orderInfoPage, handler: Handler(handlerFunc: (_, params) {
      String id = params['id'].first;
      return OrderInfoPage(
        id: id,
      );
    }));

    router.define(orderSearchPage, handler: Handler(handlerFunc: (_, params) => OrderSearchPage()));
    router.define(orderTrackPage, handler: Handler(handlerFunc: (_, params) => OrderTrackPage()));
  }
  
}

