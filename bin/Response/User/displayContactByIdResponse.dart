import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../Services/Supabase/supabaseEnv.dart';

displayContactByIdResponse(Request req, String id) async {
  final jwt = JWT.decode(req.headers["authorization"]!);
  final userAuth = jwt.payload["sub"];
  final supabase = SupabaseEnv().supabase;


  final resultContact = await supabase
      .from("contact1")
      .select("platform,value")
      .eq("id", int.parse(id));

  return Response.ok(
    json.encode(resultContact),
    headers: {"content-type": "application/json"},
  );
}
