import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:merchant_ms/page/home/splash_page.dart';
import 'package:merchant_ms/provider/theme_provider.dart';
import 'package:merchant_ms/routers/applicaton.dart';
import 'package:merchant_ms/routers/routers.dart';
import 'package:merchant_ms/util/log_utils.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  final Widget home;
  
  MyApp({this.home}) {
    Log.init();
    final router = Router();
    Routers.configureRouters(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: ChangeNotifierProvider<ThemeProvider>(
        create: (_) => ThemeProvider(),
        child: Consumer<ThemeProvider>(
          builder: (_, provider, __) {
            return MaterialApp(
              title: 'Merchant MS',
              theme: provider.getTheme(),
              darkTheme: provider.getTheme(isDarkMode: true),
              themeMode: provider.getThemeMode(),
              home: home ?? SplashPage(),
              onGenerateRoute: Application.router.generator,
              // localizationsDelegates: const [
              //   GlobalMaterialLocalizations.delegate,
              //   GlobalWidgetsLocalizations.delegate,
              //   GlobalCupertinoLocalizations.delegate,
              // ],

              supportedLocales: const [Locale('zh', 'CH'), Locale('en', 'US')],

              builder: (context, child) {
                /// 保证文字大小不受手机系统设置影响 https://www.kikt.top/posts/flutter/layout/dynamic-text/
                return MediaQuery(
                  data: MediaQuery.of(context).copyWith(
                      textScaleFactor:
                          1.0), // 或者 MediaQueryData.fromWindow(WidgetsBinding.instance.window).copyWith(textScaleFactor: 1.0),
                  child: child,
                );
              },
            );
          },
        ),
      ),
      /// Toast 配置
      backgroundColor: Colors.black54,
      textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      radius: 20.0,
      position: ToastPosition.bottom
    );
  }
}


