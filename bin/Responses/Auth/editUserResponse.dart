// ignore_for_file: file_names

import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

editUserResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final jwt = JWT.decode(req.headers["authorization"]!);
    final userAuth = jwt.payload['sub'];
    final supabase = SupabaseEnv().supabase.from('users');

    final List user = await supabase.select('id').eq('id_auth', userAuth);

    final result = await supabase
        .update({
          'name': body['name'],
          'bio': body['bio'],
          'email': body['email'],
        })
        .eq('id_auth', user[0]['id'])
        .select();

    return CustomResponse().successResponse(
      msg: "user updated",
      statusCode: 201,
      data: [result.toString()],
    );
  } on AuthException catch (error) {
    return CustomResponse()
        .errorResponse(msg: error.message, statusCode: error.statusCode);
  } on Exception catch (error) {
    return CustomResponse().errorResponse(msg: '$error', statusCode: '400');
  }
}
