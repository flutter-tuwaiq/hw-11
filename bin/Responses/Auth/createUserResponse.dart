// ignore_for_file: file_names

import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../Models/UserModel.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/supabaseEnv.dart';

createUserResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final supabase = SupabaseEnv().supabase;
    print(body);

    final supabaseVariable = supabase.auth;
    UserResponse userInfo = await supabaseVariable.admin.createUser(
      AdminUserAttributes(
        email: body['email'],
        password: body['password'],
      ),
    );
    UserModel userObject = UserModel(
      email: userInfo.user!.email!,
      idAuth: userInfo.user!.id,
      username: body['username'],
      name: body['name'],
      bio: body['bio'],
    );

    await supabaseVariable.signInWithOtp(email: body['email']);
    await supabase.from("users").insert(userObject.toMap());

    return CustomResponse().successResponse(
      msg: "create account page",
      data: [
        {"email": body['email']},
      ],
      statusCode: 200,
    );
  } catch (error) {
    return CustomResponse().errorResponse(
      msg: error.toString(),
      statusCode: '400',
    );
  }
}
