import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import '../../response_messages/bad_request.dart';
import '../../response_messages/success.dart';
import '../../services/supabase/supabase_env.dart';

Future<Response> displayProfileHandler(Request req) async {
  try {
    final supabase = SupabaseEnv().supabase;
    final jwt = JWT.decode(req.headers["authorization"].toString().trim());
    final user = await supabase
        .from("profiles")
        .select("username, email, name, bio")
        .eq("id_auth", jwt.payload["sub"]);

    return Success().responseMessage(
      message: "Here is your profile!",
      data: {"profile": user},
    );
  } catch (error) {
    print(error);

    return BadRequest().responseMessage(message: "Something went wrong!");
  }
}
