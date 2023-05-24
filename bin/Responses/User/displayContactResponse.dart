// ignore_for_file: file_names

import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

displayContactResponse(Request req, String id) async {
  try {
// create authorization wiht user token
    final jwt = JWT.decode(req.headers["authorization"]!);
    final userAuth = jwt.payload["sub"];
    final supabase = SupabaseEnv().supabase;

    //get id from table user by use id auth
    final result =
        await supabase.from("user1").select("id").eq("id_auth", userAuth);

    //get contact
    final resultContact = await supabase
        .from("contact")
        .select("platform,value")
        .eq("id_user", result[0]["id"])
        .eq('id', int.parse(id));

    return Response.ok(
      json.encode(resultContact),
      headers: {"content-type": "application/json"},
    );
  } on AuthException catch (error) {
    return CustomResponse()
        .errorResponse(msg: error.message, statusCode: error.statusCode);
  } on Exception catch (error) {
    return CustomResponse().errorResponse(msg: '$error', statusCode: '400');
  }
}
