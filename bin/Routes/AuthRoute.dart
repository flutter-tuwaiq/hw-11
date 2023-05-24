// ignore_for_file: file_names

import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../Responses/Auth/createUserResponse.dart';
import '../Responses/Auth/displayUserResponse.dart';
import '../Responses/Auth/editUserResponse.dart';
import '../Responses/Auth/loginResponse.dart';
import '../Responses/Auth/verifyEmailResponse.dart';

class AuthRoute {
  Handler get handler {
    final router = Router()
      ..post('/create_account', createUserResponse) // create user
      ..post('/verification_email', verifyEmailResponse) // verify email
      ..post('/login', loginResponse) // login user
      ..get('/display_profile', displayUserResponse)
      ..put('/edit_profile', editUserResponse);

    return router;
  }
}
