import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import 'AuthRoute.dart';
import 'UserRoute.dart';

class BaseRoute {
  Handler get handler {
    final router = Router()
      ..mount('/auth', AuthRoute().handler)
      ..mount('/user', UserRoute().handler)
      ..all('/<name|.*>', (Request _) {
        return Response.notFound("Page not found! please change your path");
      });

    return router;
  }
}
