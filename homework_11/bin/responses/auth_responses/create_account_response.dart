import 'dart:convert';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../response_messages/bad_request.dart';
import '../../response_messages/created.dart';
import '../../services/supabase/supabase_env.dart';

Future<Response> createAccountHandler(Request request) async {
  try {
    // read the request body
    final Map body = json.decode(await request.readAsString());

    // check if the user has entered valid values.
    if (body.keys.toString() != "(username, password, email, name, bio)") {
      return BadRequest().responseMessage(message: "Invalid input!");
    }

    final supabase = SupabaseEnv().supabase;

    final selectFromProfiles = supabase.from("profiles").select();

    // check if the user already have an account by the email.
    List checkEmail = await selectFromProfiles.eq("email", body["email"]);

    if (checkEmail.isNotEmpty) {
      return BadRequest()
          .responseMessage(message: "You already have an account!");
    }

    // check if the username is taken.
    List checkUsername =
        await selectFromProfiles.eq("username", body["username"]);

    if (checkUsername.isNotEmpty) {
      return BadRequest().responseMessage(message: "Username already taken!");
    }

    // create the user.
    UserResponse userInfo = await supabase.auth.admin.createUser(
      AdminUserAttributes(email: body["email"], password: body["password"]),
    );

    // add the user to the profiles table.
    final idAuth = userInfo.user?.id;

    await supabase.from("profiles").insert({
      "username": body["username"],
      "email": body["email"],
      "name": body["name"],
      "bio": body["bio"],
      "id_auth": idAuth,
    });

    // send verification email.
    await supabase.auth.signInWithOtp(
      email: body["email"],
    );

    return Created().responseMessage(
      message:
          "Account created! you will receive an email to confirm your account.",
      data: {
        "username": body["username"],
        "email": body["email"],
        "name": body["name"],
        "bio": body["bio"],
      },
    );
  } catch (error) {
    return BadRequest().responseMessage(message: "Something went wrong!");
  }
}
