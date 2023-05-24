// ignore_for_file: file_names

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../ResponseMsg/CustomResponse.dart';

Middleware checkTokenMiddleware() => (innerhandler) => (Request req) {
      try {
        return CustomResponse().successResponse(
          msg: "",
          statusCode: 201,
          data: [],
        );
      } on AuthException catch (error) {
        return CustomResponse()
            .errorResponse(msg: error.message, statusCode: error.statusCode);
      } on JWTExpiredError {
        print('jwt expired');

        return Response.forbidden("expired is Expired");
      } on JWTError catch (error) {
        print(error.message);

        return Response.forbidden("token not right");
        // error: invalid token
      } on Exception {
        return Response.forbidden("you need access for this endPoint");
      }
    };
