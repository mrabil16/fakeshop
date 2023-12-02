import 'package:apps.technical.sera_astra/core/constant/viewstate.dart';
import 'package:apps.technical.sera_astra/core/model/product_model.dart';
import 'package:apps.technical.sera_astra/core/viewmodel/home_viewmodel.dart';
import 'package:apps.technical.sera_astra/ui/view/product_detail.dart';
import 'package:apps.technical.sera_astra/ui/widget/modal_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../core/constant/app_color.dart';
import '../widget/category_widget.dart';
import 'base_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  ScrollController scrollController = ScrollController();
  Color appBarColors = Colors.transparent;
  int _value = 0;
  List<ProductModel>? products;
  String _text = "";

  List<String> Categorietitle = [
    "All",
    "electronics",
    "jewelery",
    "men's clothing",
    "women's clothing"
  ];

  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: colorPrimary,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      body: BaseView<HomeViewModel>(onModelReady: (data) async {
        await data.getProduct(context);
        if (data.product!.isNotEmpty) {
          products = data.product;
        }
      }, builder: (context, data, child) {
        return ModalProgress(
          inAsyncCall: data.state == ViewState.Busy ? true : false,
          child: RefreshIndicator(
            onRefresh: () async {},
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.grey,
                                size: 26,
                              ),
                              suffixIcon: const Icon(
                                Icons.mic,
                                color: colorPrimary,
                                size: 26,
                              ),
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelText: "Electronics, Casual, Jewelery",
                              labelStyle: const TextStyle(color: Colors.grey),
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              isDense: true,
                            ),
                            maxLines: 1,
                            onChanged: (value) {
                              setState(
                                () {
                                  _text = value;
                                  products = data.product!.where((product) {
                                    return product.category!
                                        .toUpperCase()
                                        .contains(_text.toUpperCase());
                                  }).toList();

                                  products = data.product!.where((product) {
                                    return product.title!
                                        .toUpperCase()
                                        .contains(_text.toUpperCase());
                                  }).toList();
                                },
                              );
                            },
                          ),
                        ),
                      ),
                      IconButton(
                          onPressed: () {
                            data.toggleGrid();
                          },
                          icon: const Icon(Icons.filter_list)),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15),
                    width: MediaQuery.of(context).size.width,
                    child: SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(Categorietitle.length, (index) {
                          return MyRadioListTile<int>(
                            value: index,
                            groupValue: _value,
                            leading: Categorietitle[index],
                            onChanged: (value) async {
                              setState(() {
                                _value = value!;
                                if (_value == 0) {
                                  products = data.product!;
                                } else {
                                  products = data.product!.where((product) {
                                    return product.category ==
                                        Categorietitle[index];
                                  }).toList();
                                }
                              });
                            },
                          );
                        }),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  products != null
                      ? Expanded(
                          child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: data.showGrid == true
                                  ? GridView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: products!.length,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 20,
                                              crossAxisCount: 2),
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        return InkWell(
                                          onTap: (() {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductDetailView(
                                                            data: products![
                                                                index])));
                                          }),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              products![index]
                                                                  .image!),
                                                          fit: BoxFit.contain)),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                products![index].title!,
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                '\$${products![index].price}',
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 1,
                                                style: const TextStyle(
                                                    color: Color.fromARGB(
                                                        255, 253, 104, 104),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Row(
                                                children: [
                                                  const Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 16,
                                                  ),
                                                  Text(
                                                    products![index]
                                                        .rating!
                                                        .rate
                                                        .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Text(
                                                    '${products![index].rating!.count} Reviews',
                                                    style: const TextStyle(
                                                        color: Colors.black45,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                      })
                                  : ListView.builder(
                                      itemCount: products!.length,
                                      padding: const EdgeInsets.only(top: 16),
                                      itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductDetailView(
                                                          data: products![
                                                              index])));
                                        },
                                        child: Card(
                                          elevation: 0.0,
                                          child: Container(
                                            height: 120,
                                            padding: const EdgeInsets.all(16),
                                            margin: const EdgeInsets.only(
                                                bottom: 8.0),
                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          products![index]
                                                              .image!),
                                                      fit: BoxFit.fill,
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          products![index]
                                                              .title!,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        Expanded(
                                                          child: Text(
                                                            products![index]
                                                                .description!,
                                                            maxLines: 3,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                          ),
                                                        ),
                                                        Text(
                                                          "\$${products![index].price}",
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    )),
                        )
                      : const Expanded(
                          child: Center(
                          child: CircularProgressIndicator(),
                        )),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
