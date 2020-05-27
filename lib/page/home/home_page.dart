import 'package:flutter/material.dart';
import 'package:merchant_ms/page/goods/page/goods_page.dart';
import 'package:merchant_ms/page/order/page/order_page.dart';
import 'package:merchant_ms/page/shop/page/shop_page.dart';
import 'package:merchant_ms/page/statistics/page/statistics_page.dart';
import 'package:merchant_ms/resources/colors.dart';
import 'package:merchant_ms/resources/dimens.dart';
import 'package:merchant_ms/util/double_tap_back_exit_app.dart';
import 'package:merchant_ms/util/theme_utils.dart';
import 'package:merchant_ms/widgets/load_images.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

//监听数据传递和状态改变
class HomeProvider extends ValueNotifier<int> {
  HomeProvider() : super(0);
}

class _HomeState extends State<Home> {
  var _pageList;
  var _appBarTitles = ['订单', '商品', '统计', '店铺'];

  final _pageController = PageController();
  HomeProvider provider = HomeProvider();
  List<BottomNavigationBarItem> _list;
  List<BottomNavigationBarItem> _listDark;

  void initPage() {
    _pageList = [
      OrderPage(),
      GoodsPage(),
      StatisticsPage(),
      ShopPage(),
    ];
  }

  @override
  void initState() {
    super.initState();
    initPage();
  }

  List<BottomNavigationBarItem> _bulidBottomNavigationBarItem() {
    if (_list == null) {
      var _tabImages = [
        [
          const LoadAssetImage(
            'home/icon_order',
            width: 25.0,
            color: Colours.unselected_item_color,
          ),
          const LoadAssetImage(
            'home/icon_order',
            width: 25.0,
            color: Colours.app_main,
          ),
        ],
        [
          const LoadAssetImage(
            'home/icon_commodity',
            width: 25.0,
            color: Colours.unselected_item_color,
          ),
          const LoadAssetImage(
            'home/icon_commodity',
            width: 25.0,
            color: Colours.app_main,
          ),
        ],
        [
          const LoadAssetImage(
            'home/icon_statistics',
            width: 25.0,
            color: Colours.unselected_item_color,
          ),
          const LoadAssetImage(
            'home/icon_statistics',
            width: 25.0,
            color: Colours.app_main,
          ),
        ],
        [
          const LoadAssetImage(
            'home/icon_shop',
            width: 25.0,
            color: Colours.unselected_item_color,
          ),
          const LoadAssetImage(
            'home/icon_shop',
            width: 25.0,
            color: Colours.app_main,
          ),
        ]
      ];
      _list = List.generate(4, (i) {
        return BottomNavigationBarItem(
            icon: _tabImages[i][0],
            activeIcon: _tabImages[i][1],
            title: Padding(
                padding: const EdgeInsets.only(top: 1.5),
                child: Text(_appBarTitles[i], key: Key(_appBarTitles[i]))));
      });
    }
    return _list;
  }

  List<BottomNavigationBarItem> _buildDarkBottomNavigationBarItem() {
    if (_listDark == null) {
      var _tabImagesDark = [
        [
          const LoadAssetImage('home/icon_order', width: 25.0),
          const LoadAssetImage(
            'home/icon_order',
            width: 25.0,
            color: Colours.dark_app_main,
          ),
        ],
        [
          const LoadAssetImage('home/icon_commodity', width: 25.0),
          const LoadAssetImage(
            'home/icon_commodity',
            width: 25.0,
            color: Colours.dark_app_main,
          ),
        ],
        [
          const LoadAssetImage('home/icon_statistics', width: 25.0),
          const LoadAssetImage(
            'home/icon_statistics',
            width: 25.0,
            color: Colours.dark_app_main,
          ),
        ],
        [
          const LoadAssetImage('home/icon_shop', width: 25.0),
          const LoadAssetImage(
            'home/icon_shop',
            width: 25.0,
            color: Colours.dark_app_main,
          ),
        ]
      ];

      _listDark = List.generate(4, (i) {
        return BottomNavigationBarItem(
            icon: _tabImagesDark[i][0],
            activeIcon: _tabImagesDark[i][1],
            title: Padding(
              padding: const EdgeInsets.only(top: 1.5),
              child: Text(
                _appBarTitles[i],
                key: Key(_appBarTitles[i]),
              ),
            ));
      });
    }
    return _listDark;
  }

  void _onPageChanged(int index) {
    provider.value = index;
  }

  @override
  Widget build(BuildContext context) {
    bool isDark = ThemeUtils.isDark(context);
    return ChangeNotifierProvider<HomeProvider>(
      create: (_) => provider,
      child: DoubleTapBackExitApp(
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
//---NoSovle (-, provider, __)
            builder: (_, provider, __) {
              return BottomNavigationBar(
                backgroundColor: ThemeUtils.getBackgroundColor(context),
                items: isDark
                    ? _buildDarkBottomNavigationBarItem()
                    : _bulidBottomNavigationBarItem(),
                // 1.BottomNavigationBarType.fixed:（代表tab固定不变，也是默认格式）
                // (1).底部tab数： 不超过4个
                // (2).导航栏背景色，默认由Material 控件的ThemeData.canvasColor决定
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: Dimens.font_sp10,
                unselectedFontSize: Dimens.font_sp10,
                selectedItemColor: Theme.of(context).primaryColor,
                unselectedItemColor: isDark
                    ? Colours.dark_unselected_item_color
                    : Colours.unselected_item_color,
                onTap: (index) => _pageController.jumpToPage(index),
              );
            },
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: _onPageChanged,
            children: _pageList,
            //禁止滑动
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}
