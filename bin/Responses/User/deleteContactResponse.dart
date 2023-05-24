// ignore_for_file: file_names

import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

deleteContactResponse(Request req, String id) async {
  try {
    // create authorization wiht user token
    final jwt = JWT.decode(req.headers["authorization"]!);
    final userAuth = jwt.payload["sub"];
    final supabase = SupabaseEnv().supabase;

    // get id from table user by use id auth
    final iduser =
        await supabase.from("users").select("id").eq("id_auth", userAuth);

    // delete contact
    await supabase
        .from("contact")
        .delete()
        .eq("id_user", iduser[0]["id"])
        .eq('id', int.parse(id));

    return Response.ok(
      json.encode("delete is done"),
      headers: {"content-type": "application/json"},
    );
  } on AuthException catch (error) {
    return CustomResponse()
        .errorResponse(msg: error.message, statusCode: error.statusCode);
  } on Exception catch (error) {
    return CustomResponse().errorResponse(msg: '$error', statusCode: '400');
  }
}
