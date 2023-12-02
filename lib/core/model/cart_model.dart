class CartModel {
  int? id;
  int? userId;
  String? date;
  List<Product>? products;

  CartModel({
    this.id,
    this.userId,
    this.date,
    this.products,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    date = json['date'];
    // products = json['products'] != null
    //     ? new Product.fromJson(json['productId'])
    //     : null;
    products = (json['products'] as List<dynamic>?)
        ?.map((productJson) => Product.fromJson(productJson))
        .toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['date'] = this.date;
    if (this.products != null) {
      data['products'] = products?.map((product) => product!.toJson()).toList();
    }
    return data;
  }
}

class Product {
  int? productId;
  int? quantity;

  Product({
    this.productId,
    this.quantity,
  });

  Product.fromJson(Map<String, dynamic> json) {
    productId = json['productId'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productId'] = this.productId;
    data['quantity'] = this.quantity;
    return data;
  }
}
