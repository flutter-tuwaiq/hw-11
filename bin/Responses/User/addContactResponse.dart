// ignore_for_file: file_names

import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

addContactResponse(Request req) async {
  try {
// create body
    final body = json.decode(await req.readAsString());

    // create authorization wiht user token
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supaEnv = SupabaseEnv().supabase;

    // select user id by id_auth with it code (sup)
    final result = await supaEnv
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

    // create varable to save the id of user
    final iduser = result[0]["id"];

    // add new contact in the table(contact)
    await supaEnv.from("contact").upsert({"id_user": iduser, ...body});

    // return Response.ok("create contact successesed fro id : ${iduser.toString()} \n ${json.encode(body) }" ,headers: {"content-type": "application/json"});
    return CustomResponse().successResponse(
      msg: "create contact successesed for id : ${iduser.toString()}",
      data: [body],
      statusCode: 201,
    );
  } on AuthException catch (error) {
    return CustomResponse()
        .errorResponse(msg: error.message, statusCode: error.statusCode);
  } on Exception catch (error) {
    return CustomResponse().errorResponse(msg: '$error', statusCode: '400');
  }
}
