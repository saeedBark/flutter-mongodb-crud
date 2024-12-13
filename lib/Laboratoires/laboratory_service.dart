import 'package:contacts_app/db/connect_mongoDb.dart';
import 'package:mongo_dart/mongo_dart.dart';

class LaboratoriesService {
  final url = ConnectMongoDB().dbUrl;

  Future<Map<String, dynamic>> getLaboratory(ObjectId id) async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('users');
      final products =
          await collection.findOne({'_id': id}) as Map<String, dynamic>;
      await db.close();
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return {};
    }
  }

  Future<List<Map<String, dynamic>>> getItems() async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('users');
      final products = await collection.find().toList();
      await db.close();
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<void> addLaboratroy(
      String name, String description, int quantity) async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('users');
      await collection.insert({
        'name': name,
        'description': description,
        'qty': quantity,
      });
      await db.close();
      print('Product added successfully');
    } catch (e) {
      print('Error adding product: $e');
    }
  }

  Future<void> editLaboratory(
    ObjectId id,
    String newName,
    String newDescription,
    int newQuantity,
  ) async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('users');

      final result = await collection.updateOne(
          where.eq('_id', id),
          modify
              .set('name', newName)
              .set('description', newDescription)
              .set('qty', newQuantity)
          //  {
          //   '\$set': {
          //     'name': newName,
          //     'description': newDescription,
          //     'qty': newQuantity,
          //   }
          // }
          );

      if (result.isSuccess) {
        print('Product updated successfully');
      } else {
        print('Product not updated successfully');
      }
      await db.close();
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> deleteLabroatory(ObjectId id) async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('users');

      await collection.deleteOne({'_id': id});
      await db.close();
      print('Product deleted successfully');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
