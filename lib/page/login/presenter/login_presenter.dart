import 'package:merchant_ms/common/common.dart';
import 'package:merchant_ms/mvp/base_page_presenter.dart';
import 'package:merchant_ms/net/net.dart';
import 'package:merchant_ms/page/account/models/account_entity.dart';
import 'package:merchant_ms/page/login/model/login_entity.dart';
import 'package:merchant_ms/page/login/page/login_page.dart';

class LoginPagePresenter extends BasePagePresenter<LoginPageState> {
  
  Future login(String username, String password, bool isShowDialog, bool isList) async {
    Map<String, String> params = Map();
    params['username'] = username;
    params['password'] = password;

    await requestNetwork<LoginEntity>(Method.post,
      url: HttpApi.login,
      queryParameters: params,
      isShow: isShowDialog,
      onSuccess: (data) {
        if (data != null) {
          if(data.phone == username) {
            view.isLogin = true;
          }
          print(data);
        }
      },
      onError: (_, __) {
        print(_);
        print(__);
      },
    );
  }

  Future getShopId(String account, bool isShowDialog) async {
    Map<String, String> params = Map();
    params['phone'] = account;

    await requestNetwork<AccountEntity>(Method.post,
      url: HttpApi.account,
      queryParameters: params,
      isShow: isShowDialog,
      onSuccess: (data) {
        if (data != null) {
          if(data.phone == account) {
            Constant.shopId = data.shopId;
          }
          print(data);
        }
      },
      onError: (_, __) {
        print(_);
        print(__);
      },
    );
  }
}
