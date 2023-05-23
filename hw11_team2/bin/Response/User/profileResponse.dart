import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

profileResponse(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);

    final supabase = SupabaseEnv().supabase;

    final profile = (await supabase
        .from("users")
        .select("name , username , email , bio")
        .eq("id_auth", jwt.payload["sub"]))[0];

    return ResponseMsg().successResponse(
      msg: "success",
      data: {"profile": profile},
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
