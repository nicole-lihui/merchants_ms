import 'package:merchant_ms/mvp/base_page_presenter.dart';
import 'package:merchant_ms/net/net.dart';
import 'package:merchant_ms/page/goods/models/goods_item_entity.dart';
import 'package:merchant_ms/page/goods/page/goods_list_page.dart';
import 'package:merchant_ms/widgets/state_layout.dart';

class GoodsPagePresenter extends BasePagePresenter<GoodsListPageState> {
  
  Future search(int text, int status, bool isShowDialog, bool isList) async {

    Map<String, int> params = Map();
    params['shopId'] = text;
    params['status'] = status;

    await requestNetwork<GoodsItemEntity>(Method.get,
      url: HttpApi.goods,
      queryParameters: params,
      isShow: isShowDialog,
      isList: isList,
      onSuccessList: (data) {
        if (data != null) {
          view.goodslist = data;
        } else {
          //  加载失败
          // view.lprovider.setHasMore(false);
          // view.lprovider.setStateType(StateType.network);
        }
        view.goodslist = data;
        
      },
      onError: (_, __) {
        /// 加载失败
        // view.lprovider.setHasMore(false);
        // view.lprovider.setStateType(StateType.network);
      }
    ); 
  }
}
