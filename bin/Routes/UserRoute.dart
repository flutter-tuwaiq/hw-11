// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Middlewares/checkTokenMiddleware.dart';
import '../Responses/User/addContactResponse.dart';
import '../Responses/User/deleteContactResponse.dart';
import '../Responses/User/displayAllContact.dart';
import '../Responses/User/displayContactResponse.dart';
import '../Responses/User/displayUserContact.dart';

class UserRoute {
  Handler get handler {
    final router = Router()
      // Add contact
      ..post('/add_contact', addContactResponse)
      //delete contact
      ..delete('/delete_mycontact/<id>', deleteContactResponse)
      // display contact
      ..get("/view_contact/<id>", displayContactResponse)
      // display all contact
      ..get('/view_allcontact', displayAllContact)
      // display user => contact
      ..get("/display_user/<id>", displayUserContact);

    final pipline =
        Pipeline().addMiddleware(checkTokenMiddleware()).addHandler(router);

    return pipline;
  }
}
