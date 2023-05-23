import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

displayProfileResponse(Request req) async {
  final jwt = JWT.decode(req.headers["authorization"]!);
  final supabase = SupabaseEnv().supabase;

  final user = (await supabase
      .from("users1")
      .select()
      .eq("id_auth", jwt.payload["sub"]))[0];

//-------------- here start get contact
  final resultProfile = await supabase
      .from("users1")
      .select("name, email, username, bio")
      .eq("username", user["username"]);

  return Response.ok(
    json.encode(resultProfile),
    headers: {"content-type": "application/json"},
  );
}
