import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../response_messages/bad_request.dart';
import '../../response_messages/success.dart';
import '../../services/supabase/supabase_env.dart';

addContactHandler(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final jwt = JWT.decode(req.headers["authorization"]!);
    final supabase = SupabaseEnv().supabase;

//-------------- get id from table user by  id auth
    final result = await supabase
        .from("profiles")
        .select("id")
        .eq("id_auth", jwt.payload["sub"]);

//-------------- add contact info with id_user
    await supabase
        .from("contact")
        .upsert({"id_user": result[0]["id"], ...body});

    return Success().responseMessage(
      message: "Contact information has been added ! ${result[0]["id"]}",
      data: body,
    );
  } catch (error) {
    return BadRequest().responseMessage(
      message: "Oops! wrong! Contact information has not been added",
    );
  }
}
