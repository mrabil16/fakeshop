class Api {
  static const endpoint = 'https://fakestoreapi.com/';
  final timeout = 20;

  String getProduct = endpoint + 'products';
  String getByCategories = endpoint + 'products/category/';
  String getAllChart = endpoint + 'carts/user/';
  String getUser = endpoint + 'users/';
  String login = endpoint + 'auth/login';
}
