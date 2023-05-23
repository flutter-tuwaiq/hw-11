import 'package:shelf/shelf.dart';

import '../../RespnseMsg/ResponseMsg.dart';
import '../../Services/Supabase/supabaseEnv.dart';

retrieveUserResponse(Request _, String id) async {
  final supabase = SupabaseEnv().supabase;

  final profile = (await supabase
      .from("users")
      .select("name , username , email , bio")
      .eq("id", int.parse(id)))[0];

  return ResponseMsg().successResponse(
    msg: "success",
    data: {"User information": profile},
  );
}
