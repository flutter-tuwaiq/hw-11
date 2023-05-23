import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

deleteContactResponse(Request req, String id) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

    // get user id from user table
    final user = await supabase
        .from("users")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

    // delete contact
    await supabase
        .from("contact")
        .delete()
        .eq("id_user", user[0]["id"])
        .eq("id", int.parse(id));

    return ResponseMsg().successResponse(
      msg: "Your contact is deleted ",
    );
  } catch (error) {
    return ResponseMsg().errorResponse(msg: error.toString());
  }
}
