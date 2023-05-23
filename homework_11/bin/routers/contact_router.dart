import 'package:shelf_router/shelf_router.dart';
import '../responses/contact_responses/add_contact_response.dart';
import '../responses/contact_responses/delete_contact_response.dart';
import '../responses/contact_responses/get_contact_response.dart';

class ContactRouter {
  Router get handler {
    final router = Router()
      ..post("/add", addContactHandler)
      ..get("/get", getContactHandler)
      ..delete('/delete/<id>', deleteContactHandler);

    return router;
  }
}
