import 'dart:convert';

import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';

import '../../Models/UserModel.dart';
import '../../ResponseMsg/CustomResponse.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

createAccountResponse(Request req) async {
  try {
    final body = json.decode(await req.readAsString());
    final auth = SupabaseEnv().supabase.auth;

    UserResponse userInfo = await auth.admin.createUser(
      AdminUserAttributes(email: body["email"], password: body["password"]),
    );

    UserModel userObject = UserModel(
        email: userInfo.user!.email!,
        idAuth: userInfo.user!.id,
        name: body["name"],
        username: body["username"],
        bio: body["bio"],);
    
     await auth.signInWithOtp(email: body['email']);
     await SupabaseEnv().supabase.from("users1").insert(userObject.toMap());

     return CustomResponse().successResponse(
      msg: "Account created successfully!",
      data: {"email": body['email'], "username": body['username']},
    );

  } catch (error) {
    print(error);

    return CustomResponse().errorResponse(
      msg: "sorry, please check your information",
    );
  }
}
