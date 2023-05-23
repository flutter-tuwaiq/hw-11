import 'dart:convert';
import 'package:shelf/shelf.dart';
import '../../Services/Supabase/SupabaseEnv.dart';

userDisplayResponse(Request _, String id)async{
  try{
    final supabase = SupabaseEnv().supabase;
    
     final user = (await supabase
      .from("users1")
      .select()
      .eq("id", int.parse(id)))[0];

      final contact =
      await supabase.from("contact1").select().eq("id_user", user["id"]);

      Map userMap = {...user, "contact": contact};

      return Response.ok(json.encode(userMap), headers:{"content-type": "application/json"});
  } catch (e) {
    return Response.internalServerError(body: "Sorry, try again later");
  }
}