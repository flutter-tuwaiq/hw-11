
// ignore_for_file: file_names

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
        return Response.notFound(" page not found please change your path");
      });

    return router;
  }
}
