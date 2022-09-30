import 'dart:convert';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

class PeopleAPI {
  late final DbCollection coll;

  PeopleAPI({required this.coll});

  Handler get router {
    final router = Router();

    router.get('/id/<field>/', (Request request, String field) async {
      int integer = int.parse(field);
       var result = await coll.findOne(where.eq("id", integer));
      print(result);

      return Response.ok(
        jsonEncode(result),
        headers: {'Application-Content': 'application/json'},
      );
    });

    router.post('/people/', (Request request) async {
      final payLoad = await request.readAsString();

      var result = json.decode(payLoad);
      await coll.insertOne(result);

      return Response.ok(result, headers: {'Content-Type': 'application/json'});
    });

    router.delete('/people/id/<parameter>/',
        (Request request, String parameter) async {
      var itemToDelete = await coll.findOne(where.eq('id', parameter));
      await coll.remove(itemToDelete);
      return Response.ok('User deleted');
    });

    router.patch('/people/', (Request request) async {
      final payLoad = await request.readAsString();

      var document = json.decode(payLoad);
      var id = document['id'];
      var itemToPatch = await coll.findOne(where.eq('id', id));

      await coll.update(itemToPatch, {
        r'$set': document,
      });
      return Response.ok('User updated');
    });

    return router;
  }
}
