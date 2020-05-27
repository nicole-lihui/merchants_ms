import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:merchant_ms/common/common.dart';
import 'package:merchant_ms/mvp/base_page_state.dart';
import 'package:merchant_ms/page/login/login_router.dart';
import 'package:merchant_ms/page/login/presenter/login_presenter.dart';
import 'package:merchant_ms/page/store/store_router.dart';
import 'package:merchant_ms/resources/resources.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:flustars/flustars.dart' as FlutterStars;
import 'package:merchant_ms/routers/routers.dart';
import 'package:merchant_ms/util/utils.dart';
import 'package:merchant_ms/widgets/app_bar.dart';
import 'package:merchant_ms/widgets/my_button.dart';
import 'package:merchant_ms/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginPage, LoginPagePresenter> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();
  bool _isClick = false;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    //监听输入改变
    _nameController.addListener(_verify);
    _passwordController.addListener(_verify);
    _nameController.text = FlutterStars.SpUtil.getString(Constant.phone);
  }

  void _verify() {
    String name = _nameController.text;
    String password = _passwordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick) {
      setState(() {
        _isClick = isClick;
      });
    }
  }

  void _login() async {
    FlutterStars.SpUtil.putString(Constant.phone, _nameController.text);
    print(_nameController.text);
    print(_passwordController.text);
    await presenter.login(_nameController.text, _passwordController.text, true, false);
    if(isLogin) {
      Constant.phone = _nameController.text;
      await presenter.getShopId(_nameController.text, true);
      if (Constant.shopId == 'shopId') {
        NavigatorUtils.push(context, StoreRouter.auditPage);
      } else {
         NavigatorUtils.push(context, Routers.home, clearStack: true);
      }
    } else {
      NavigatorUtils.push(context, LoginRouter.registerPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MyAppBar(
          isBack: false,
          actionName: '验证码登录',
          onPressed: () {
            NavigatorUtils.push(context, LoginRouter.smsLoginPage);
          },
        ),
        body: defaultTargetPlatform == TargetPlatform.iOS
            ? FormKeyboardActions(
                child: _buildBody(),
              )
            : SingleChildScrollView(
                child: _buildBody(),
              ));
  }

  _buildBody() {
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            '密码登录',
            style: TextStyles.textBold26,
          ),
          Gaps.vGap16,
          MyTextField(
            key: const Key('phone'),
            focusNode: _nodeText1,
            controller: _nameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: '请输入账号',
          ),
          Gaps.vGap8,
          MyTextField(
            key: const Key('password'),
            keyName: 'password',
            focusNode: _nodeText2,
            config: Utils.getKeyboardActionsConfig(
                context, [_nodeText1, _nodeText2]),
            isInputPwd: true,
            controller: _passwordController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 16,
            hintText: '请输入密码',
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            key: const Key('login'),
            onPressed: _isClick ? _login : null,
            text: '登录',
          ),
          Container(
            height: 40.0,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: Text(
                '忘记密码',
                style: Theme.of(context).textTheme.subtitle,
              ),
              onTap: () =>
                  NavigatorUtils.push(context, LoginRouter.resetPasswordPage),
            ),
          ),
          Gaps.vGap16,
          Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: Text(
                  '还没账号？快去注册',
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                onTap: () =>
                    NavigatorUtils.push(context, LoginRouter.registerPage),
              ))
        ],
      ),
    );
  }

  @override
  LoginPagePresenter createPresenter() {
    return LoginPagePresenter();
  }

}
