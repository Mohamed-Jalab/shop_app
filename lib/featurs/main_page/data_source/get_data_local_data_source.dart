import 'dart:developer';

import 'package:sqflite/sqflite.dart';

import '../../../core/constant.dart';
import '../../../injection.dart';
import '../featurs/home/models/product_model.dart';
import 'data_source_paths.dart';

class GetDataLocalDataSource {
  Future<List<Map<String, dynamic>>> getSearchHistory() async {
    Database db = await openDatabase(Constant.searchHistoryDataBasePath);
    return db.rawQuery('SELECT * FROM searchHistory ORDER BY count DESC');
  }

  Future<Map<String, dynamic>> getProductById(int id) async {
    Database db = await openDatabase(Constant.productDataBasePath);
    List<Map<String, dynamic>> products =
        await db.rawQuery('SELECT * FROM products WHERE id=$id');
    return products[0];
  }

  Future<List<Map<String, dynamic>>> getSimilarProducts(
      ProductModel product) async {
    Database db = await openDatabase(Constant.productDataBasePath);
    List<Map<String, dynamic>> list1 = await db.rawQuery(
        "SELECT * FROM products WHERE category =='${product.category}' AND makerCompany =='${product.makerCompany}'");
    List<Map<String, dynamic>> list2 = await db.rawQuery(
        "SELECT * FROM products WHERE category =='${product.category}' AND makerCompany !='${product.makerCompany}'");
    list1.addAll(list2);
    return list1;
  }

  Future<List<Map<String, dynamic>>> getReviews(int id) async {
    Database db = await openDatabase(Constant.reviewsDataBasePath);
    return db.rawQuery('SELECT * FROM reviews WHERE productId == $id');
  }

  Future<List<Map<String, dynamic>>> getDiscountProduct() async {
    Database db = await openDatabase(Constant.productDataBasePath);
    List<Map<String, Object?>> data = [];
    try {
      data = await db.rawQuery(
          'SELECT * FROM products WHERE discount > 0 ORDER BY discount DESC');
    } catch (e) {
      log(e.toString());
    }
    return data;
  }

  Future<Map<String, dynamic>> getAddToCartProductById(int id) async {
    Database db = await openDatabase(Constant.addToCartTable);
    List<Map<String, dynamic>> data =
        await db.rawQuery('SELECT * FROM AddToCartTable WHERE id==$id');
    return data[0];
  }

  Future<List<Map<String, dynamic>>> getAddToCartProduct() async {
    Database db = await openDatabase(Constant.addToCartTable);
    List<Map<String, dynamic>> products = [];
    try {
      products = await db.rawQuery('SELECT * FROM AddToCartTable');
    } catch (e) {
      log(e.toString());
    }
    log(products.toString());
    return products;
  }

  Future<List<Map<String, dynamic>>> getLocations() async {
    Database db = await openDatabase(Constant.locationsDataBasePath);
    List<Map<String, dynamic>> locations =
        await db.rawQuery('SELECT * FROM locations');
    return locations;
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    Database db = await openDatabase(Constant.ordersDataBasePath);
    return await db.rawQuery('SELECT * FROM orders');
  }

  Future<List<Map<String, dynamic>>> getLocationByName(
      String addressName) async {
    Database db = await openDatabase(Constant.locationsDataBasePath);
    return db
        .rawQuery('SELECT * FROM locations WHERE addressName="$addressName"');
  }

  Future<List<Map<String, dynamic>>> getProductsByIds(String ordersIds) async {
    List<Map<String, dynamic>> orders = [];
    Database db = await openDatabase(Constant.productDataBasePath);
    // String data = ordersIds.replaceAll('|', ',');
    List<String> p = ordersIds.split('|');
    try {
      for (var i = 0; i < p.length; i++) {
        var d = await db.rawQuery('SELECT * FROM products WHERE id = ${p[i]}');
        orders.add(d[0]);
      }
      // orders = await db.rawQuery('SELECT * FROM products WHERE id IN ($data)');
    } catch (e) {
      log(e.toString());
    }

    return orders;
  }

  Future<List<Map<String, dynamic>>> getTrendyProducts() async {
    List<Map<String, dynamic>> trendyProducts = [];
    try {
      List<Map<String, dynamic>> searchWords = await getSearchHistory();

      for (var i = 0; i < searchWords.length; i++) {
        List<Map<String, dynamic>> data = await sl
            .get<DataSource>()
            .searchProducts(
                search: searchWords[i]['word'],
                minPrice: 0,
                maxPrice: 100,
                discountFilter: [false, false, false, false, false, false],
                selectedCategory: 'All',
                ratingFilter: [false, false, false, false, false, false],
                colorFilter: [
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false,
                  false
                ]);
        for (var element in data) {
          List<Map<String, dynamic>> tempProduct = [];
          tempProduct = trendyProducts
              .where((element1) => element1['id'] != element['id'])
              .toList();
          tempProduct.add(element);
          trendyProducts = tempProduct;
        }
      }
    } catch (e) {
      log(e.toString());
    }
    return trendyProducts;
  }
}