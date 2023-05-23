import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../response_messages/bad_request.dart';
import '../../response_messages/success.dart';
import '../../services/supabase/supabase_env.dart';

loginHandler(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    if (body["email"] == null || body["password"] == null) {
      return Response.badRequest(
        body: "make sure to enter the email and password",
      );
    }
    final auth = SupabaseEnv().supabase.auth;
    final userLogin = await auth.signInWithPassword(
      email: body["email"],
      password: body["password"],
    );

    return Success().responseMessage(
      message: "You are now logged in.",
      data: {
        "token": userLogin.session?.accessToken.toString(),
        "refresh_Token": userLogin.session?.refreshToken.toString(),
      },
    );
  } catch (error) {
    return BadRequest().responseMessage(message: 'something went wrong');
  }
}
