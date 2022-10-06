import 'dart:convert';
import 'dart:math';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf_router/shelf_router.dart';

import '../models/order.dart';

class OrderAPI {
  late final DbCollection coll;

  OrderAPI({required this.coll});

  Handler get router {
    final router = Router();

    router.get('/id/<field>/', (Request request, String field) async {
      var integer = int.parse(field);
      var result = await coll.findOne(where.eq("id", integer));

      // print(result);

      return Response.ok(
        jsonEncode(result),
        headers: {'Application-Content': 'application/json'},
      );
    });

    router.get('/category/<field>/', (Request request, String field) async {
      if (field.contains('+')) {
        field = field.replaceAll('+', ' ');
      }
      var result = await coll.find(where.eq("category", field)).toList();

      // print(result);

      return Response.ok(
        jsonEncode(result),
        headers: {'Application-Content': 'application/json'},
      );
    });

    router.get('/category/', (Request request) async {
      var res = await coll.distinct('category');
      print('/category');
      print(res);

      return Response.ok(
        jsonEncode(res.values.first),
        headers: {'Application-Content': 'application/json'},
      );
    });
    router.get('/<id>/', (Request request, String id) async {
      // print(request.url);
      final result = await coll.find(where.eq('userId', id)).toList();

      //  print(result);

     // final  Order order = Order(dateOrdered: result[0], shippingDetails: shippingDetails, shippingCost: shippingCost, tax: tax, total: total, totalItemPrice: totalItemPrice, paymentMethod: paymentMethod, userType: userType, cartItems: cartItems)

      return Response.ok(
        jsonEncode(result),
        headers: {'Application-Content': 'application/json'},
      );
    });

    router.post('/stripepayment/', (Request request) async {
      final payLoad = await request.readAsString();

      var result = json.decode(payLoad);
      await coll.insertOne(result);

      return Response.ok(jsonEncode(result), headers: {'Content-Type': 'application/json'});
    });

    router.post('/paypall/', (Request request) async {
      final payLoad = await request.readAsString();

      var result = json.decode(payLoad);
      await coll.insertOne(result);

      return Response.ok(jsonEncode(result), headers: {'Content-Type': 'application/json'});
    });

    router.delete('/id/<parameter>/',
        (Request request, String parameter) async {
      var itemToDelete = await coll.findOne(where.eq('id', parameter));
      await coll.remove(itemToDelete);
      return Response.ok('User deleted');
    });

    router.patch('/', (Request request) async {
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
//todo duplicate

}
