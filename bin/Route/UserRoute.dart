import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middleware/User/CheckToken_Middleware.dart';
import '../Response/User/EditUserProfileResponse.dart';
import '../Response/User/addContactRespone.dart';
import '../Response/User/deleteContactResponse.dart';
import '../Response/User/displayContactByIdResponse.dart';
import '../Response/User/displayContactUserResponse.dart';
import '../Response/User/displayProfileResponse.dart';
import '../Response/User/userDisplayResponse.dart';

class UserRoute {
  Handler get handler {
    final router = Router()
      ..get("/user-display/<id>", userDisplayResponse)
      ..delete('/delete-contact/<id>', deleteContactResponse)
      ..get('/display-contact-id/<id>', displayContactByIdResponse)
      ..get('/profile', displayProfileResponse)
      ..post('/add_contact', addContactResponse)
      ..post('/edit_profile', editUserProfileResponse)
      ..get("/display-contact", displayContactUserResponse);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
