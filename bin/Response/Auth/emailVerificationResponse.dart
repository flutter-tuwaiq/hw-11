import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

emailVerificationResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    await SupabaseEnv().supabase.auth.verifyOTP(
          token: body['otp'],
          type: OtpType.signup,
          email: body['email'],
        );

    return CustomResponse().successResponse(msg: "email is confirmed");
  } catch (error) {
    return CustomResponse().errorResponse(msg: "email is not confirmed");
  }
}
