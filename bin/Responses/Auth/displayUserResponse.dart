// ignore_for_file: file_names

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

displayUserResponse(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final userAuth = jwt.payload['sub'];
    final supabase = SupabaseEnv().supabase.from('users');

    final user = await supabase.select('*').eq('id_auth', userAuth);

    return CustomResponse().successResponse(
      msg: "display user",
      statusCode: 201,
      data: [user[0].toString()],
    );
  } on AuthException catch (error) {
    return CustomResponse()
        .errorResponse(msg: error.message, statusCode: error.statusCode);
  } on Exception catch (error) {
    return CustomResponse().errorResponse(msg: '$error', statusCode: '400');
  }
}
