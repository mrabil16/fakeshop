// ignore_for_file: use_build_context_synchronously

import 'dart:async';

import 'package:apps.technical.sera_astra/core/model/cart_model.dart';
import 'package:apps.technical.sera_astra/core/model/product_model.dart';
import 'package:apps.technical.sera_astra/core/repository/cart_repository.dart';
import 'package:apps.technical.sera_astra/core/repository/product_repository.dart';

import '/core/constant/viewstate.dart';

import '../../core/model/user_model.dart';
import '../../core/repository/account_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../locator.dart';
import 'base_viewmodel.dart';

class HomeViewModel extends BaseViewModel {
  AccountRepository accountRepository = locator<AccountRepository>();
  ProductRepository productRepository = locator<ProductRepository>();
  CartRepository cartRepository = locator<CartRepository>();

  UserModel? user;
  List<ProductModel>? product;
  List<CartModel>? cart;

  bool isLogin = false;
  bool showGrid = true;
  int totalItems = 0;
  double totalPrice = 0.0;

  void toggleGrid() {
    showGrid = !showGrid;
    notifyListeners();
  }

  Future init(BuildContext context) async {
    getProduct(context);
    await checkSessionLogin();
    if (isLogin == true) {
      await getUser(context);
      await getAllCarts(context);
    }
  }

  Future<void> checkSessionLogin() async {
    setState(ViewState.Busy);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_login') ?? false;
    notifyListeners();
    setState(ViewState.Idle);
  }

  Future getUser(BuildContext context) async {
    try {
      setState(ViewState.Busy);
      user = await accountRepository.getUser(context);
      notifyListeners();
      setState(ViewState.Idle);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getProduct(BuildContext context) async {
    try {
      setState(ViewState.Busy);
      product = await productRepository.getProduct(context);
      notifyListeners();
      setState(ViewState.Idle);
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future getAllCarts(BuildContext context) async {
    try {
      setState(ViewState.Busy);
      int totalItemsa = 0;
      double totalPricea = 0.0;

      cart = await cartRepository.getAllCarts(context);
      if (cart != null) {
        for (var cartItem in cart!) {
          List<Product>? products = cartItem.products!
              .where((products) => cartItem.userId == 1)
              .toList();

          totalItemsa += products!.length;
          for (var products in product!) {
            totalPricea += products.price!;
          }
        }
        totalItems = totalItemsa;
        totalPrice = totalPricea;
      }
      notifyListeners();
      setState(ViewState.Idle);
    } catch (e) {
      print(e);
    }
  }
}
