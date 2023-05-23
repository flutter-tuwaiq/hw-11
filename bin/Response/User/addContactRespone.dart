// ignore_for_file: file_names

import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../Services/Supabase/supabaseEnv.dart';

addContactResponse(Request req) async {
  final body = json.decode(await req.readAsString());
  final jwt = JWT.decode(req.headers["authorization"]!);
  final supabase = SupabaseEnv().supabase;
  final result = await supabase
      .from("users1")
      .select("id")
      .eq("id_auth", jwt.payload["sub"]);

  final iduser = result[0]["id"];

  await supabase.from("contact1").upsert({"id_user": iduser, ...body});

  return Response.ok("Contact added successfully!");
}
