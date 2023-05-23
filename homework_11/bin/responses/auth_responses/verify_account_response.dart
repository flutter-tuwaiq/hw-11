import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../response_messages/bad_request.dart';
import '../../response_messages/success.dart';
import '../../services/supabase/supabase_env.dart';

Future<Response> verifyAccountHandler(Request request) async {
  try {
    final body = json.decode(await request.readAsString());

    // check if the user has entered valid values.
    if (body.keys.toString() != "(email, otp)") {
      return BadRequest().responseMessage(message: "Invalid input!");
    }

    // verify via otp
    await SupabaseEnv().supabase.auth.verifyOTP(
          token: body['otp'],
          type: OtpType.signup,
          email: body['email'],
        );

    return Success().responseMessage(message: "Account has been verified!");
  } catch (error) {
    return BadRequest()
        .responseMessage(message: "Account has not been verified!");
  }
}
