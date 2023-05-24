// ignore_for_file: file_names

import 'dart:convert';

import 'package:shelf/shelf.dart';

import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/supabaseEnv.dart';

loginResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    if (body["email"] == null || body["password"] == null) {
      return Response.badRequest(body: "add email and password please");
    }
    final auth = SupabaseEnv().supabase.auth;
    final userLogin = await auth.signInWithPassword(
      email: body["email"],
      password: body["password"],
    );

    //return Response.ok(userLogin.session?.accessToken.toString());
    // حاول تجربي

    return CustomResponse().successResponse(
      msg: "success",
      data: [
        {
          "token": userLogin.session?.accessToken.toString(),
          "token refresh": userLogin.session?.refreshToken.toString(),
        },
      ],
      statusCode: 200,
    );
  } catch (error) {
    return Response.badRequest();
  }
}
