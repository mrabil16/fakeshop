import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/api.dart';
import '../../../../core/model/product_model.dart';
import '../../ui/widget/toast.dart';
import '../helper/dio_exception.dart';

class ProductRepository extends ChangeNotifier {
  Response? response;
  Dio dio = new Dio();

  Future<List<ProductModel>?> getProduct(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      response = await dio
          .get(
            Api().getProduct,
            options: Options(headers: {}),
          )
          .timeout(Duration(seconds: Api().timeout));
      if (response!.statusCode == 200) {
        notifyListeners();
        Iterable data = response!.data;
        List<ProductModel> listData =
            data.map((map) => ProductModel.fromJson(map)).toList();
        return listData;
      }
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      prefs.setString('message', errorMessage);
      Toasts.toastMessage(errorMessage);
      return null;
    }
  }
}
