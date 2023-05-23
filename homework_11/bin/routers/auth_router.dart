import 'package:shelf_router/shelf_router.dart';
import '../responses/auth_responses/create_account_response.dart';
import '../responses/auth_responses/login_response.dart';
import '../responses/auth_responses/verify_account_response.dart';

class AuthRouter {
  Router get handler {
    final router = Router()
      ..post("/create_account", createAccountHandler)
      ..post("/verify_account", verifyAccountHandler)
      ..post('/login', loginHandler);

    return router;
  }
}
