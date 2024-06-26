import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../injection.dart';
import '../../../../data_source/data_source.dart';

part 'products_state.dart';

class AddToCartCubit extends Cubit<AddToCartState> {
  AddToCartCubit() : super(ProductsInitial());

  List<Map<String, dynamic>> products = [];
  void removeElement(int id) {
    sl
        .get<DataSource>()
        .removeItemFromAddToCartProducts(id)
        .then((value) async {
      products = [];
      var res = await sl.get<DataSource>().getAddToCartProducts();
      res.fold((l) {
        products = l;
        return true;
      }, (r) => false);
      emit(ProductsRemoveElement());
    });
  }

  void addElement(Map<String, dynamic> item) {
    var data = Map.of(item);
    var p = List.of(products);
    p.add(data);
    products = p;
    emit(ProductsAddElement());
  }

  void fetchData() {
    emit(ProductsFetchData());
  }

  double totalPrice() {
    double total = 0;
    for (var element in products) {
      total += element['price'] * element['quantity'];
    }
    return total;
  }

  Future<bool> getAddToCartProducts() async {
    products = [];
    var res = await sl.get<DataSource>().getAddToCartProducts();
    bool s = res.fold((l) {
      products = l;
      return true;
    }, (r) => false);
    return s;
  }

  bool _isProceedButtonLoading = false;
  set setIsProceedButtonLoading(value) {
    _isProceedButtonLoading = value;
    emit(IsProceedButtinLoading());
  }

  get getIsProceedButtonLoading => _isProceedButtonLoading;
}
