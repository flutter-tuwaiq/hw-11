import 'dart:convert';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:shelf/shelf.dart';
import 'package:supabase/supabase.dart';
import '../../response_messages/bad_request.dart';
import '../../response_messages/success.dart';
import '../../services/supabase/supabase_env.dart';

Future<Response> editProfileHandler(Request request) async {
  try {
    // read the request body
    final Map body = json.decode(await request.readAsString());

    final checkEmail = body.keys.contains("email");

    // check if the user has entered valid values.
    if (!body.keys.contains("name") &&
        !checkEmail &&
        !body.keys.contains("bio")) {
      return BadRequest().responseMessage(message: "Invalid input!");
    }

    final supabase = SupabaseEnv().supabase;
    final jwt = JWT.decode(request.headers["authorization"].toString().trim());
    final fromProfiles = supabase.from("profiles");

    // check if the user edited the email and if he does change his email in auth users table as admin.
    if (checkEmail) {
      await supabase.auth.admin.updateUserById(
        jwt.payload["sub"],
        attributes: AdminUserAttributes(email: body["email"]),
      );
    }

    // get user profile before updating it and save it inside user.
    final user = await fromProfiles
        .select("email, name, bio")
        .eq("id_auth", jwt.payload["sub"]);

    // update the user profile with entered values or keep the old values and save it inside updatedUser.
    final updatedUser = await fromProfiles
        .update({
          "name": body["name"] ?? user[0]["name"],
          "email": body["email"] ?? user[0]["email"],
          "bio": body["bio"] ?? user[0]["bio"],
        })
        .eq("id_auth", jwt.payload["sub"])
        .select("username, email, name, bio");

    return Success().responseMessage(
      message: "Profile has been updated!",
      data: {"Updated profile": updatedUser},
    );
  } catch (error) {
    print(error);

    return BadRequest().responseMessage(message: "Something went wrong!");
  }
}
