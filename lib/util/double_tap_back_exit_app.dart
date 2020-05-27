import 'package:flutter/material.dart';
import 'package:merchant_ms/util/toast.dart';

class DoubleTapBackExitApp extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const DoubleTapBackExitApp({
    Key key,
    @required this.child,
    this.duration: const Duration(milliseconds: 2500),
  }) : super(key: key);

  @override
  _DoubleTapBackExitAppState createState() => _DoubleTapBackExitAppState();
}

class _DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime _lastTime;

  @override
  Widget build(BuildContext context) {
    //导航返回拦截（WillPopScope）
    //为了避免用户误触返回按钮而导致APP退出，在很多APP中都拦截了用户点击返回键的按钮，然后进行一些防误触判断
    //https://book.flutterchina.club/chapter7/willpopscope.html
    return WillPopScope(
      child: widget.child,
      onWillPop: _isExit,
    );
  }

  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > widget.duration) {
      _lastTime = DateTime.now();
      Toast.show('再次点击退出应用');
      return Future.value(false);
    }
    Toast.cancelToast();
    return Future.value(true);
  }
}
