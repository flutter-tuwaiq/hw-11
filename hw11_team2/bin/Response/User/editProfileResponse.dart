import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

editProfileResponse(Request req) async {
  try {
    final Map body = json.decode(await req.readAsString());

    final jwt = JWT.decode(req.headers["authorization"]!);

    final supabase = SupabaseEnv().supabase;

    if (body.keys.contains("name")) {
      await supabase
          .from("users")
          .update({"name": body["name"]}).eq("id_auth", jwt.payload["sub"]);
    }

    if (body.keys.contains("email")) {
      await supabase
          .from("users")
          .update({"email": body["email"]}).eq("id_auth", jwt.payload["sub"]);
    }

    if (body.keys.contains("bio")) {
      await supabase
          .from("users")
          .update({"bio": body["bio"]}).eq("id_auth", jwt.payload["sub"]);
    }

    return ResponseMsg().successResponse(
      msg: "Your profile is updated",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
