import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

editUserProfileResponse(Request req) async {
  final body = json.decode(await req.readAsString());
  final jwt = JWT.decode(req.headers["authorization"]!);
  final idAuth = jwt.payload["sub"];
  final supabase = SupabaseEnv().supabase;

  final idList = await supabase.from("users1").select("id").eq("id_auth", idAuth);
  final id = idList[0]["id"];

  final edit = await supabase.from("users1").update({
    "name": body["name"],
    "email": body["email"],
    "bio": body["bio"],
  }).eq("id", id);

  return Response.ok("Edit profile successfully!");
}
