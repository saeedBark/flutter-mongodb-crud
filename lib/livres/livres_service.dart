import 'package:contacts_app/db/connect_mongoDb.dart';
import 'package:mongo_dart/mongo_dart.dart';

class LivresService {
  final url = ConnectMongoDB().dbUrl;

  Future<Map<String, dynamic>> getItem(String id) async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('livres');
      final products =
          await collection.findOne({'name': id}) as Map<String, dynamic>;
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
      final collection = db.collection('livres');
      final products = await collection.find().toList();
      await db.close();
      return products;
    } catch (e) {
      print('Error fetching products: $e');
      return [];
    }
  }

  Future<void> addItem(String name, String description, int quantity) async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('livres');
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

  Future<void> updateItem(
    String newName,
    String newDescription,
    int newQuantity,
  ) async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('livres');
      await collection.updateOne({
        'name': newName
      }, {
        '\$set': {
          'name': newName,
          'description': newDescription,
          'qty': newQuantity,
        }
      });
      await db.close();
      print('Product updated successfully');
    } catch (e) {
      print('Error updating product: $e');
    }
  }

  Future<void> deleteProduct(String id) async {
    try {
      final db = await Db.create(url);
      await db.open();
      final collection = db.collection('livres');

      // Use a colon ':' to associate the key '_id' with its value 'objectId'
      await collection.deleteOne({'name': id});
      await db.close();
      print('Product deleted successfully');
    } catch (e) {
      print('Error deleting product: $e');
    }
  }
}
