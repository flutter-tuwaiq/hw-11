import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../response_messages/bad_request.dart';
import '../../response_messages/success.dart';
import '../../services/supabase/supabase_env.dart';

getContactHandler(Request req) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

//-------------- get id from table user by use id auth
    final result = await supabase
        .from("profiles")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

//-------------- get contact by the id
    final resultContact = await supabase
        .from("contact")
        .select("platform,value")
        .eq("id_user", result[0]["id"]);

    return Success().responseMessage(
      message: "Contact information has been obtained ",
      data: {"Contact": resultContact},
    );
  } catch (error) {
    return BadRequest().responseMessage(
      message: "Oops! wrong! Contact information was not obtained",
    );
  }
}
