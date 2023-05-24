// ignore_for_file: file_names

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

verifyEmailResponse(Request req) async {
  try {  
    final body = json.decode(await req.readAsString());
     await SupabaseEnv().supabase.auth.verifyOTP(
           token: body['otp'],
           type: OtpType.signup,
           email: body['email'],
         );

     return CustomResponse().successResponse(msg: "email is confirm", statusCode: 200);
   } catch (error) {
     return CustomResponse().errorResponse(msg: "email not confirm", statusCode: '400');
  }
}
