import 'package:flutter/material.dart';
import 'package:merchant_ms/common/common.dart';
import 'package:merchant_ms/mvp/base_page_state.dart';
import 'package:merchant_ms/page/goods/models/goods_item_entity.dart';
import 'package:merchant_ms/page/goods/presenter/goods_presenter.dart';
import 'package:merchant_ms/page/goods/provider/goods_page_provider.dart';
import 'package:merchant_ms/page/goods/widgets/goods_delete_bottom_sheet.dart';
import 'package:merchant_ms/page/goods/widgets/goods_item.dart';
import 'package:merchant_ms/provider/base_list_provider.dart';
import 'package:merchant_ms/routers/fluro_navigator_utils.dart';
import 'package:merchant_ms/util/toast.dart';
import 'package:merchant_ms/widgets/my_refresh_list.dart';
import 'package:merchant_ms/widgets/state_layout.dart';
import 'package:provider/provider.dart';

import '../goods_router.dart';

class GoodsListPage extends StatefulWidget {
  final int index;

  const GoodsListPage({Key key, @required this.index}) : super(key: key);

  @override
  GoodsListPageState createState() => GoodsListPageState();
}

class GoodsListPageState
    extends BasePageState<GoodsListPage, GoodsPagePresenter>
    with
        AutomaticKeepAliveClientMixin<GoodsListPage>,
        SingleTickerProviderStateMixin {
  int _selectIndex = -1;
  Animation<double> _animation;
  AnimationController _controller;
  List<GoodsItemEntity> goodslist = [];
  BaseListProvider<GoodsItemEntity> lprovider =
      BaseListProvider<GoodsItemEntity>();
  int _index = 0;

  @override
  void initState() {
    super.initState();
    // 初始化动画控制
    _controller = new AnimationController(
        duration: const Duration(milliseconds: 450), vsync: this);
    // 动画曲线
    CurvedAnimation _curvedAnimation =
        CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);
    _animation = new Tween(begin: 0.0, end: 1.1).animate(_curvedAnimation);

    //Item数量
    _maxPage = widget.index == 0 ? 1 : (widget.index == 1 ? 2 : 3);
    _index = widget.index;

    _onRefresh();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  // List<String> _imgList = [
  //   'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3130502839,1206722360&fm=26&gp=0.jpg',
  //   '', // 故意使用一张无效链接，触发默认显示图片
  //   'https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1762976310,1236462418&fm=26&gp=0.jpg',
  //   'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3659255919,3211745976&fm=26&gp=0.jpg',
  //   'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=2085939314,235211629&fm=26&gp=0.jpg',
  //   'https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2441563887,1184810091&fm=26&gp=0.jpg'
  // ];

  Future _onRefresh() async {
    await Future.delayed(Duration(seconds: 0), () {
      setState(() async {
        _page = 1;
        await presenter.search(Constant.shopId, _index + 1, true, true);
      });
      _setGoodsCount(goodslist.length);
    });
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 0), () {
      setState(() async {
        await presenter.search(Constant.shopId, _index + 1, true, true);
        _page++;
      });
      _setGoodsCount(goodslist.length);
    });
  }

  _setGoodsCount(int count) {
    GoodsPageProvider provider =
        Provider.of<GoodsPageProvider>(context, listen: false);
    provider.setGoodsCount(count);
  }

  int _page = 1;
  int _maxPage;
  StateType _stateType = StateType.loading;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return DeerListView(
        itemCount: goodslist.length,
        stateType: _stateType,
        onRefresh: _onRefresh,
        loadMore: _loadMore,
        hasMore: _page < _maxPage,
        itemBuilder: (_, index) {
          return GoodsItem(
            index: index,
            selectIndex: _selectIndex,
            item: goodslist[index],
            animation: _animation,
            onTapMenu: () {
              // 开始执行动画
              _controller.forward(from: 0.0);
              setState(() {
                _selectIndex = index;
              });
            },
            onTapMenuClose: () {
              _controller.reverse(from: 1.1);
              _selectIndex = -1;
            },
            onTapEdit: () {
              setState(() {
                _selectIndex = -1;
              });
              NavigatorUtils.push(
                  context, '${GoodsRouter.goodsEditPage}?isAdd=false');
            },
            onTapOperation: () {
              Toast.show('下架');
            },
            onTapDelete: () {
              _controller.reverse(from: 1.1);
              _selectIndex = -1;
              _showDeleteBottomSheet(index);
            },
          );
        });
  }

  @override
  bool get wantKeepAlive => true;

  _showDeleteBottomSheet(int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return GoodsDeleteBottomSheet(
          onTapDelete: () {
            setState(() {
              goodslist.removeAt(index);
              if (goodslist.isEmpty) {
                _stateType = StateType.goods;
              }
            });
            _setGoodsCount(goodslist.length);
          },
        );
      },
    );
  }

  @override
  GoodsPagePresenter createPresenter() {
    return GoodsPagePresenter();
  }
}
