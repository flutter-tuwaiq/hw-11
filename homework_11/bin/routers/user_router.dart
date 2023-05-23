import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';
import '../middlewares/check_token_middleware.dart';
import '../responses/user_responses/display_profile_response.dart';
import '../responses/user_responses/display_user_response.dart';
import '../responses/user_responses/edit_profile_response.dart';
import 'contact_router.dart';

class UserRouter {
  Handler get handler {
    final router = Router()
      ..get("/display_profile", displayProfileHandler)
      ..put("/edit_profile", editProfileHandler)
      ..get('/display_user/<id>', displayUserHandler)
      ..mount("/contact", ContactRouter().handler);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
