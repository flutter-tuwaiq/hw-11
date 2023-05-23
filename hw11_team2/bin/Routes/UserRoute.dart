import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middelwares/User/CheckTokenMiddelware.dart';
import '../Response/User/addContactResponse.dart';
import '../Response/User/deleteContactResponse.dart';
import '../Response/User/displayAllContactResponse.dart';
import '../Response/User/displayContactByIdResponse.dart';
import '../Response/User/editProfileResponse.dart';
import '../Response/User/profileResponse.dart';
import '../Response/User/retrieveUserResponse.dart';

class UserRoute {
  Handler get handler {
    final router = Router()
      ..get("/profile", profileResponse)
      ..put("/edit_profile", editProfileResponse)
      ..post('/contact/add', addContactResponse)
      ..delete("/contact/delete/<id>", deleteContactResponse)
      ..get("/contact/<id>", displayContactByIdResponse)
      ..get("/contact", displayAllContactResponse)
      ..get("/user/<id>", retrieveUserResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
