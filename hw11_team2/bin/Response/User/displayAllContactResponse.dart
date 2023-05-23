import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../Services/Supabase/supabaseEnv.dart';

displayAllContactResponse(Request req) async {
  final jwt = JWT.decode(req.headers["authorization"]!);

  final supabase = SupabaseEnv().supabase;

  final user = await supabase
      .from("users")
      .select("id")
      .eq("id_auth", jwt.payload["sub"]);

  final contact = await supabase
      .from("contact")
      .select("platform,value")
      .eq("id_user", user[0]["id"]);

  return Response.ok(
    json.encode(contact),
    headers: {"content-type": "application/json"},
  );
}
