class SliderModel {
  String? image;

  SliderModel(
    this.image,
  );

  SliderModel.fromJson(Map<String, dynamic> json) {
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['image'] = this.image;
    return data;
  }
}

List<SliderModel> slides =
    slideData.map((item) => SliderModel.fromJson(item)).toList();

var slideData = [
  {
    "image": "assets/images/banner1.png",
  },
  {
    "image": "assets/images/banner2.png",
  },
];
