import 'dart:io';

import 'package:mongo_dart/mongo_dart.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_router/shelf_router.dart';

import 'api/api_config.dart';
import 'api/controllers/product.dart';
import 'api/controllers/people.dart';
import 'package:shelf_hotreload/shelf_hotreload.dart';

void main(List<String> arguments) async {
  var db = Db('mongodb://${ApiConfig.username}:${ApiConfig.password}@'
      'ac-eiipju9-shard-00-02.bb6hpqn.mongodb.net:27017,'
      'ac-eiipju9-shard-00-00.bb6hpqn.mongodb.net:27017,'
      'ac-eiipju9-shard-00-01.bb6hpqn.mongodb.net:27017/'
      'test?authSource=admin&compressors=disabled'
      '&gssapiServiceName=mongodb&replicaSet=atlas-stcn2i-shard-0'
      '&ssl=true');

  await db.open();
  var collPeople = db.collection('people');
  var collProduct = db.collection('product');
  var array = await collPeople.find().toList();
  // array.forEach((element) {
  //   print(element);
  // });
  int port = ApiConfig.port;
  final app = Router();
  app.mount('/people', PeopleAPI(coll: collPeople).router);
  app.mount('/product', ProductAPI(coll: collProduct).router);

  // Listen for incoming connections

  final handler = Pipeline()
  // .addMiddleware(logRequests())
      .addHandler(app);


  await io
      .serve(handler, InternetAddress.anyIPv4, port)
      .whenComplete(() => print('Server serving'));

  // var res =  await collProduct.distinct('category');
  //
  // print(res.values);

  // var res = await collProduct.find(where.sortBy('category')).forEach((
  //     article) {
  //   print("[${article['category']}]");
  // });
}