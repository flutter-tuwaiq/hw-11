import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Response/Auth/createAccountResponse.dart';
import '../Response/Auth/emailVerificationResponse.dart';
import '../Response/Auth/loginResponse.dart';

class AuthRoute {
  Handler get handler {
    final router = Router()
    ..post("/create-account", createAccountResponse)
    ..post("/email-verification", emailVerificationResponse)
    ..post("/login",loginResponse);

    return router;
  }
}
