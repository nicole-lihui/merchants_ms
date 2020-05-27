import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MyFlexibleSpaceBar extends StatefulWidget {
  final Widget title;
  final Widget background;
  final bool centerTitle;
  final CollapseMode collapseMode;
  final EdgeInsetsGeometry titlePadding;

  const MyFlexibleSpaceBar({
    Key key,
    this.title,
    this.background,
    this.centerTitle,
    this.titlePadding,
    this.collapseMode = CollapseMode.parallax,
  })  : assert(collapseMode != null),
        super(key: key);

  static Widget createSettings({
    double toolbarOpacity,
    double minExtent,
    double maxExtent,
    @required double currentExtent,
    @required Widget child,
  }) {
    assert(currentExtent != null);
    return FlexibleSpaceBarSettings(
      toolbarOpacity: toolbarOpacity ?? 1.0,
      minExtent: minExtent ?? currentExtent,
      maxExtent: maxExtent ?? currentExtent,
      currentExtent: currentExtent,
      child: child,
    );
  }

  @override
  _FlexibleSpaceBarState createState() => _FlexibleSpaceBarState();
}

class _FlexibleSpaceBarState extends State<MyFlexibleSpaceBar> {
  bool _getEffectiveCenterTitle(ThemeData theme) {
    if (widget.centerTitle != null) return widget.centerTitle;
    assert(theme.platform != null);
    switch (theme.platform) {
      case TargetPlatform.android:
      case TargetPlatform.fuchsia:
        return false;
      case TargetPlatform.iOS:
        return true;
      case TargetPlatform.macOS:
        break;
    }
    return null;
  }

  Alignment _getTitleAlignment(bool effectiveCenterTitle) {
    if (effectiveCenterTitle) return Alignment.bottomCenter;
    final TextDirection textDirection = Directionality.of(context);
    assert(textDirection != null);
    switch (textDirection) {
      case TextDirection.rtl:
        return Alignment.bottomRight;
      case TextDirection.ltr:
        return Alignment.bottomLeft;
    }
    return null;
  }

  double _getCollapsePadding(double t, FlexibleSpaceBarSettings settings) {
    switch (widget.collapseMode) {
      case CollapseMode.pin:
        return -(settings.maxExtent - settings.currentExtent);
      case CollapseMode.none:
        return 0.0;
      case CollapseMode.parallax:
        final double deltaExtent = settings.maxExtent - settings.minExtent;
        return -Tween<double>(begin: 0.0, end: deltaExtent / 4.0).transform(t);
    }
    return null;
  }

  GlobalKey _key = GlobalKey();
  double _offset = 0;

  @override
  void initState() {
    //监听Widget是否绘制完毕
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBoxRed = _key.currentContext.findRenderObject();
      _offset = renderBoxRed.size.width / 2;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final FlexibleSpaceBarSettings settings =
        context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
    assert(settings != null,
        'A FlexibleSpaceBar must be wrapped in the widget returned by FlexibleSpaceBar.createSettings().');

    final List<Widget> children = <Widget>[];

    final double deltaExtent = settings.maxExtent - settings.minExtent;

    // 0.0 -> Expanded
    // 1.0 -> Collapsed to toolbar
    final double t =
        (1.0 - (settings.currentExtent - settings.minExtent) / deltaExtent)
            .clamp(0.0, 1.0);

    // background image
    //  if (widget.background != null) {
    //    final double fadeStart = math.max(0.0, 1.0 - kToolbarHeight / deltaExtent);
    //    const double fadeEnd = 1.0;
    //    assert(fadeStart <= fadeEnd);
    //    final double opacity = 1.0 - Interval(fadeStart, fadeEnd).transform(t);
    //    if (opacity > 0.0) {
    children.add(Positioned(
      top: _getCollapsePadding(t, settings),
      left: 0.0,
      right: 0.0,
      height: settings.maxExtent,
      child: Opacity(
        opacity: 1,
        child: widget.background,
      ),
    ));
//      }
//    }

    if (widget.title != null) {
      Widget title;
      switch (defaultTargetPlatform) {
        case TargetPlatform.iOS:
          title = widget.title;
          break;
        case TargetPlatform.fuchsia:
        case TargetPlatform.android:
          title = Semantics(
            namesRoute: true,
            child: widget.title,
          );
          break;
        case TargetPlatform.macOS:
          break;
      }

      title = Container(
        key: _key,
        child: title,
      );

      final ThemeData theme = Theme.of(context);
      final double opacity = settings.toolbarOpacity;
      if (opacity > 0.0) {
        TextStyle titleStyle = theme.primaryTextTheme.title;
        titleStyle = titleStyle.copyWith(
            color: titleStyle.color.withOpacity(opacity),
            fontWeight: t != 0 ? FontWeight.normal : FontWeight.bold);
        final bool effectiveCenterTitle = _getEffectiveCenterTitle(theme);
        final EdgeInsetsGeometry padding = widget.titlePadding ??
            EdgeInsetsDirectional.only(
              start: effectiveCenterTitle ? 0.0 : 72.0,
              bottom: 16.0,
            );
        final double scaleValue =
            Tween<double>(begin: 1.5, end: 1.0).transform(t);
        double width = (size.width - 32.0) / 2 - _offset;
        final Matrix4 scaleTransform = Matrix4.identity()
          ..scale(scaleValue, scaleValue, 1.0)
          ..translate(t * width, 0.0);
        final Alignment titleAlignment = _getTitleAlignment(false);
        children.add(Container(
          padding: padding,
          child: Transform(
            alignment: titleAlignment,
            transform: scaleTransform,
            child: Align(
              alignment: titleAlignment,
              child: DefaultTextStyle(
                style: titleStyle,
                child: title,
              ),
            ),
          ),
        ));
      }
    }

    return ClipRect(child: Stack(children: children));
  }
}
