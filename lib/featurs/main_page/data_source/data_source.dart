import 'package:appwrite/models.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import '../../auth/models/user_model.dart';
import '../featurs/check_out/models/address_model.dart';
import '../featurs/home/models/product_model.dart';
import '../featurs/products_view/models/add_to_cart_product_model.dart';
import '../featurs/products_view/models/review_model.dart';
import 'data_source_paths.dart';

class DataSource {
  RemoteDataSource remoteDataSource;
  SearchDataSource searchDataSource;
  InsertDataLocalDataSource insertDataLocalDataSource;
  GetDataLocalDataSource getDataLocalDataSource;
  UpdateDeleteLocalDataSource updateDeleteLocalDataSource;
  DataSource({
    required this.updateDeleteLocalDataSource,
    required this.remoteDataSource,
    required this.searchDataSource,
    required this.getDataLocalDataSource,
    required this.insertDataLocalDataSource,
  });
  //! this section for inserting data
  Future<Either<List<Document>, bool>> downloadLoactionsFromCloud() async {
    return remoteDataSource.downloadLoactionsFromCloud();
  }

  Future<String> addLoationToCloude(AddressModel address) async {
    return remoteDataSource.addLoationToCloude(address);
  }

  Future<bool> insertProductsIntoLocalDataBase(
      List<Document> products, bool isNew) async {
    return insertDataLocalDataSource.insertProductsIntoLocalDataBase(
        products, isNew);
  }

  Future<bool> uploadProfileSettings(
      String borderProducts, String cartProducts, String borders) async {
    return remoteDataSource.uploadProfileSettings(
        borderProducts, cartProducts, borders);
  }

  Future<bool> rateApp(String descrition, double rate) async {
    return await remoteDataSource.rateApp(descrition, rate);
  }

  Future<bool> changePassword(String newPassword) async {
    return remoteDataSource.changePassword(newPassword);
  }

  Future<bool> uploadImage(XFile image) async {
    return remoteDataSource.uploadImage(image);
  }

  Future<bool> getReviewsFromCloud() async {
    return remoteDataSource.getReviewsFromCloud();
  }

  Future<bool> addReviewToCloud(ReviewModel reviewModel) {
    return remoteDataSource.addReviewToCloud(reviewModel);
  }

  Future<bool> addReiviewToProduct(ReviewModel reiview) async {
    return insertDataLocalDataSource.addReviewToProduct(reiview);
  }

  Future<void> addBorder(String borderName) async {
    return insertDataLocalDataSource.addBorder(borderName);
  }

  Future<void> addProductToBorder(int productId, int borderId) async {
    return insertDataLocalDataSource.addProductToBorder(productId, borderId);
  }

  Future<bool> insertDataInOrderTableFromCloud(List<Document> orders) async {
    return insertDataLocalDataSource.insertDataInOrderTableFromCloud(orders);
  }

  Future<bool> insertDataInReviewTableFromCloud(List<Document> document) async {
    return insertDataLocalDataSource.addDataToReviewTableFromCloue(document);
  }

  Future<void> addOrder(
      ordersIds,
      totalPrice,
      orderDate,
      deliveryAddress,
      shoppingMethod,
      orderId,
      trakingNumber,
      String longitude,
      String latitude,
      String colors,
      String sizes,
      String amounts) async {
    insertDataLocalDataSource.addOrder(
        ordersIds,
        totalPrice,
        orderDate,
        deliveryAddress,
        shoppingMethod,
        orderId,
        trakingNumber,
        latitude,
        longitude,
        colors,
        sizes,
        amounts);
  }

  Future<bool> addOrdersToCloudDataBase(
      List<Map<String, dynamic>> orderProducts,
      double totalPrice,
      String deliveryAddress,
      String shoppingMethod,
      String latitude,
      String longitude) async {
    return remoteDataSource.addOrderToCloudDataBase(orderProducts, totalPrice,
        deliveryAddress, shoppingMethod, latitude, longitude);
  }

  Future<void> addNewLocation(AddressModel address, String type) async {
    return insertDataLocalDataSource.addNewLocation(address, type);
  }

  Future<void> addToCart(AddToCartProductModel addToCartTableModel) async {
    insertDataLocalDataSource.addToCart(addToCartTableModel);
  }

  Future<void> setSearchHistory(String searchWord) {
    return insertDataLocalDataSource.setSearchHistory(searchWord);
  }

  Future<void> setFavorateProduct(int id, bool value) async {
    insertDataLocalDataSource.setFavorateProduct(id, value);
  }

  //! this section for getting data
  Future<Either<Uint8List, bool>> downloadProfileImage(
      String cloudImageUrl) async {
    return remoteDataSource.downloadProfileImage(cloudImageUrl);
  }

  Future<Either<List<Map<String, dynamic>>, bool>> getProductsByNames(
      String names) async {
    return getDataLocalDataSource.getProductsByNames(names);
  }

  Future<List<Map<String, dynamic>>> getNewestProducts() async {
    return getDataLocalDataSource.getNewestProducts();
  }

  Future<List<Document>> getUpdatedReviews(String lastDate) async {
    return remoteDataSource.getUpdatedReviews(lastDate);
  }

  Future<Either<Map<String, List<Document>>, bool>> getUpdatedProducts(
      String lastDate) async {
    return remoteDataSource.getUpdatedProducts(lastDate);
  }

  Future<List<Map<String, dynamic>>> getRecommendedProducts() async {
    return getDataLocalDataSource.getRecommendedProducts();
  }

  Future<Either<List<Document>, bool>> getRecommendedproductsFromCloud() async {
    return remoteDataSource.getRecommendedproductsFromCloud();
  }

  Future<bool> setRecommendedProducts() {
    return insertDataLocalDataSource.setRecommendedProducts();
  }

  Future<bool> isAllBordersIsEmpty() async {
    return getDataLocalDataSource.isAllBordersIsEmpty();
  }

  Future<bool> insertPersonalData() async {
    return insertDataLocalDataSource.insertPersonalDataInDataBase();
  }

  Future<Either<Map<String, dynamic>, bool>> getPersonalDataFromCloud() async {
    return remoteDataSource.getPersonalData();
  }

  Future<List<Map<String, dynamic>>> getAllFavoritProducts() async {
    return getDataLocalDataSource.getAllFavoritProducts();
  }

  Future<List<Map<String, dynamic>>> getProductsInBorder(int borderId) async {
    return getDataLocalDataSource.getProductsInBorder(borderId);
  }

  Future<Either<List<Map<String, dynamic>>, bool>>
      getAllBorderProducts() async {
    return getDataLocalDataSource.getBorderProducts();
  }

  Future<List<Map<String, dynamic>>> getBorderByName(String borderName) async {
    return getDataLocalDataSource.getBorderByName(borderName);
  }

  Future<List<Map<String, dynamic>>> getTrendyProducts() async {
    return getDataLocalDataSource.getTrendyProducts();
  }

  Future<Either<List<Map<String, dynamic>>, bool>> getBorders() async {
    return getDataLocalDataSource.getBorders();
  }

  Future<bool> getOrdersFromCloud() async {
    return remoteDataSource.getOrdersFromCloud();
  }

  Future<List<Map<String, dynamic>>> getLocationByName(
      String addressName) async {
    return getDataLocalDataSource.getLocationByName(addressName);
  }

  Future<List<Map<String, dynamic>>> getOrders() async {
    return getDataLocalDataSource.getOrders();
  }

  Future<List<Map<String, dynamic>>> getProductsByIds(String ordersIds) async {
    return getDataLocalDataSource.getProductsByIds(ordersIds);
  }

  Future<bool> getProductsFormCloudDataBase() async {
    var res = await remoteDataSource.getProducts();
    return res.fold((l) {
      return insertDataLocalDataSource.insertProductsIntoLocalDataBase(
          l, false);
    }, (r) => false);
  }

  Future<List<Map<String, dynamic>>> getLocations() async {
    return getDataLocalDataSource.getLocations();
  }

  Future<Either<List<Map<String, dynamic>>, bool>>
      getAddToCartProducts() async {
    return getDataLocalDataSource.getAddToCartProduct();
  }

  Future<Map<String, dynamic>> getAddToCartProductById(int id) async {
    return getDataLocalDataSource.getAddToCartProductById(id);
  }

  Future<Map<String, dynamic>> getProductById(int id) async {
    return getDataLocalDataSource.getProductById(id);
  }

  Future<List<Map<String, dynamic>>> getDiscountsProducts() {
    return getDataLocalDataSource.getDiscountProduct();
  }

  Future<List<Map<String, dynamic>>> getSimilarProducts(
      ProductModel product) async {
    return getDataLocalDataSource.getSimilarProducts(product);
  }

  Future<List<Map<String, dynamic>>> getReviews(int id) async {
    return getDataLocalDataSource.getReviews(id);
  }

  Future<List<Map<String, dynamic>>> getSearchHistory() async {
    return getDataLocalDataSource.getSearchHistory();
  }

//! this section for deleting and updating data
  Future<bool> updatePersonalData(UserModel user) async {
    return remoteDataSource.updatePersonalData(user);
  }

  Future<void> clearLocationsTable() async {
    return updateDeleteLocalDataSource.clearLocationsTable();
  }

  Future<void> clearOrdersTable() async {
    return updateDeleteLocalDataSource.clearOrdersTable();
  }

  Future<bool> updateLocationInCloud(AddressModel address) async {
    return remoteDataSource.updateLocationInCloud(address);
  }

  Future<bool> deleteLocationFromCloud(AddressModel address) async {
    return remoteDataSource.deleteLocationFromCloud(address);
  }

  Future<void> updateProductToNotDiscountUpdated(String productName) async {
    return updateDeleteLocalDataSource
        .updateProductToNotDiscountUpdated(productName);
  }

  Future<void> deleteBorder(int borderId) async {
    return updateDeleteLocalDataSource.deleteBorder(borderId);
  }

  Future<void> updateProductToNotNew(String productName) async {
    return updateDeleteLocalDataSource.updateProductToNotNew(productName);
  }

  Future<void> updateReviews() async {
    return updateDeleteLocalDataSource.updateReviews();
  }

  Future<Either<Map<String, List<Document>>, bool>> updateDataBase() async {
    return updateDeleteLocalDataSource.updateDataBase();
  }

  Future<Either<String, bool>> deleteAddress(AddressModel address) async {
    return updateDeleteLocalDataSource.deleteAddress(address);
  }

  Future<void> deleteFromPorderBroducts(int productId) async {
    return updateDeleteLocalDataSource.deleteProductFromBorder(productId);
  }

  Future<void> clearAddToCartTable() async {
    return updateDeleteLocalDataSource.clearAddToCartTable();
  }

  Future<void> clearProductsTable() async {
    return updateDeleteLocalDataSource.clearProductsTable();
  }

  Future<void> clearBordersTable() async {
    return updateDeleteLocalDataSource.clearBordersTable();
  }

  Future<void> clearBorderProductsTable() async {
    return updateDeleteLocalDataSource.clearBorderPoducts();
  }

  Future<void> removeItemFromAddToCartProducts(int id) async {
    updateDeleteLocalDataSource.removeItemFromAddToCartProducts(id);
  }

  Future<void> updateQuantity(int id, int quantity) async {
    updateDeleteLocalDataSource.updateQuantity(id, quantity);
  }

  Future<void> deleteWordFormSearchHistory(String word) async {
    return updateDeleteLocalDataSource.deleteWordFormSearchHistory(word);
  }

  Future<bool> updateAddress(
      AddressModel address, String oldAddressName) async {
    return updateDeleteLocalDataSource.updateAddress(address, oldAddressName);
  }

//! this section for searching
  Future<List<Map<String, dynamic>>> searchInTrendy(
      String selectedCategory,
      String? searchWord,
      double minPrice,
      double maxPrice,
      List<Map<String, dynamic>> trendyProducts,
      List<bool> discountFilter,
      List<bool> ratingFilter,
      List<bool> colorFilter) {
    return searchDataSource.searchInTrendyProducts(
        selectedCategory,
        searchWord,
        minPrice,
        maxPrice,
        trendyProducts,
        discountFilter,
        ratingFilter,
        colorFilter);
  }

  Future<List<Map<String, Object?>>> searchInCategory({
    required double minPrice,
    required double maxPrice,
    String? searchWord,
    required List<bool> discountFilter,
    required String selectedCategory,
    required List<bool> ratingFilter,
    required List<bool> colorFilter,
  }) async {
    return searchDataSource.searchInCategory(
      discountfilter: discountFilter,
      minPrice: minPrice,
      maxPrice: maxPrice,
      searchWord: searchWord,
      selectedCategory: selectedCategory,
      ratingFilter: ratingFilter,
      colorFilter: colorFilter,
    );
  }

  Future<List<Map<String, Object?>>> searchInDiscountProducts({
    required double minPrice,
    required double maxPrice,
    String? searchWord,
    required String selectedCategory,
    required List<bool> discountFilter,
    required List<bool> ratingFilter,
    required List<bool> colorFilter,
  }) {
    return searchDataSource.searchInDiscountProducts(
        minPrice: minPrice,
        maxPrice: maxPrice,
        searchWord: searchWord,
        discountFilter: discountFilter,
        ratingFilter: ratingFilter,
        colorFilter: colorFilter,
        selectedCategory: selectedCategory);
  }

  Future<List<Map<String, Object?>>> searchProducts({
    required String searchWord,
    required double minPrice,
    required double maxPrice,
    required List<bool> discountFilter,
    required String selectedCategory,
    required List<bool> ratingFilter,
    required List<bool> colorFilter,
  }) async {
    return searchDataSource.searchProducts(
      discountfilter: discountFilter,
      searchWord: searchWord,
      minPrice: minPrice,
      maxPrice: maxPrice,
      selectedCategory: selectedCategory,
      ratingFilter: ratingFilter,
      colorFilter: colorFilter,
    );
  }
}
