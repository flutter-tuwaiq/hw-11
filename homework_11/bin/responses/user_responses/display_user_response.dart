import 'package:shelf/shelf.dart';
import '../../response_messages/bad_request.dart';
import '../../response_messages/success.dart';
import '../../services/supabase/supabase_env.dart';

displayUserHandler(Request _, String id) async {
  try {
    final supabase = SupabaseEnv().supabase;

    final user =
        (await supabase.from("profiles").select().eq("id", int.parse(id)))[0];
    final contact =
        await supabase.from("contact").select().eq("id_user", int.parse(id));

    Map userMap = {
      ...user,
      "contact": contact,
    };

    return Success().responseMessage(
      message: "Here are all of the user information.",
      data: userMap,
    );
  } on RangeError {
    return BadRequest().responseMessage(message: "user does not exist");
  } catch (error) {
    return BadRequest().responseMessage(message: "somthing went wrong");
  }
}
