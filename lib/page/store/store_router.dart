import 'package:fluro/fluro.dart';
import 'package:merchant_ms/page/store/store_audit_page.dart';
import 'package:merchant_ms/page/store/store_audit_result_page.dart';
import 'package:merchant_ms/routers/router_init.dart';

class StoreRouter implements IRouterProvider{

  static String auditPage = '/store/audit';
  static String auditResultPage = '/store/auditResult';
  
  @override
  void initRouter(Router router) {
    router.define(auditPage, handler: Handler(handlerFunc: (_, params) => StoreAuditPage()));
    router.define(auditResultPage, handler: Handler(handlerFunc: (_, params) => StoreAuditResultPage()));
  }
}
