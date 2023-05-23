import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';

import '../../response_messages/bad_request.dart';
import '../../response_messages/success.dart';
import '../../services/supabase/supabase_env.dart';

deleteContactHandler(Request req, String id) async {
  try {
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

//-------------- get id from table user by  id auth
    final result = await supabase
        .from("profiles")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

    final fromContact = supabase.from("contact");

//-------------- delete contact by id
    final deltedContact = await fromContact
        .delete()
        .eq("id_user", result[0]["id"])
        .eq("id", int.parse(id))
        .select("platform, value");

    return Success().responseMessage(
      message: "Contact information has been removed ! ",
      data: {"contact": deltedContact},
    );
  } catch (error) {
    return BadRequest().responseMessage(
      message: "Oops! Wrong! contact information was not deleted",
    );
  }
}
