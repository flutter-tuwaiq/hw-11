import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

addContactResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final jwt = JWT.decode(req.headers["authorization"]!);

    final supabase = SupabaseEnv().supabase;

    // get user id from user table
    final userId = (await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]))[0]["id"];

    // insert new contact
    await supabase.from("contact").upsert({"id_user": userId, ...body});

    return ResponseMsg().successResponse(
      msg: "Your contact is added successfully",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
