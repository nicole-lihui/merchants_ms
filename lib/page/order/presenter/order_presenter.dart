import 'package:merchant_ms/mvp/base_page_presenter.dart';
import 'package:merchant_ms/net/net.dart';
import 'package:merchant_ms/page/order/models/order_entity.dart';
import 'package:merchant_ms/page/order/page/order_info_page.dart';
import 'package:merchant_ms/page/order/page/order_list_page.dart';

class OrderPagePresenter extends BasePagePresenter<OrderListPageState> {
  Future search(int text, int status, bool isShowDialog, bool isList) async{
   
    Map<String, int> params = Map();
    params['shopId'] = text;
    params['status'] = status;

    await requestNetwork<OrderItemEntity>(Method.get,
      url: HttpApi.orders,
      queryParameters: params,
      isShow: isShowDialog,
      isList: isList,
      onSuccessList: (data) {
        if (data != null) {
          view.orderslist = data;
        } else {
          print("Loading Fial");
        }
      },
      onError: (_, __) {
        /// 加载失败
        print(_);
      }
    );
  }
}

class OrderInfoPagePresenter extends BasePagePresenter<OrderInfoPageState> {
  Future getOrder(String id, bool isShowDialog, bool isList) async{
   
    Map<String, String> params = Map();
    params['id'] = id;

    await requestNetwork<OrderItemEntity>(Method.get,
      url: HttpApi.ordersGet,
      queryParameters: params,
      isShow: isShowDialog,
      onSuccess: (data) {
        if (data != null) {
          view.orderInfo = data;
        } else {
          print("Loading Fial");
        }
      },
      onError: (_, __) {
        /// 加载失败
        print(_);
      }
    );
  }
}
