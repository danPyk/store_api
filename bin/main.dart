import 'dart:io';

import 'package:logger/logger.dart';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'api/api_config.dart';
import 'api/controllers/order.dart';
import 'api/controllers/product.dart';
import 'api/controllers/people.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';

void main(List<String> arguments) async {
  var db = Db(ApiConfig.dbUrl);

  await db.open();
  var collPeople = db.collection('people');
  var collProduct = db.collection('product');
  var collOrder = db.collection('order');

  var array = await collPeople.find().toList();
  // array.forEach((element) {
  //   print(element);
  // });
  int port = ApiConfig.port;
  final Router app = Router();
  app.mount('/people', PeopleAPI(coll: collPeople).router);
  app.mount('/product', ProductAPI(coll: collProduct).router);
  app.mount('/order', OrderAPI(coll: collOrder).router);

  // Listen for incoming connections

  final Handler handler =
  //todo add time of log
      Pipeline().addMiddleware(logRequests()).addHandler(app);

  await io
      .serve(handler, InternetAddress.anyIPv4, port)
      .whenComplete(() => print('Server serving'));



/*  var logger = Logger();
  logger.d(result);*/

  // var res =  await collProduct.distinct('category');
  //
  // print(res.values);

  // var res = await collProduct.find(where.sortBy('category')).forEach((
  //     article) {
  //   print("[${article['category']}]");
  // });
}
