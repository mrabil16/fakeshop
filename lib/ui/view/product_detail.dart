import 'package:apps.technical.sera_astra/core/constant/app_color.dart';
import 'package:apps.technical.sera_astra/core/model/product_model.dart';
import 'package:apps.technical.sera_astra/main.dart';
import 'package:apps.technical.sera_astra/ui/widget/gradient_button.dart';
import 'package:apps.technical.sera_astra/ui/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductDetailView extends StatefulWidget {
  final ProductModel? data;

  const ProductDetailView({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<ProductDetailView> createState() => _ProductDetailViewState();
}

class _ProductDetailViewState extends State<ProductDetailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
          centerTitle: true,
          title: const Text(
            'Product Detail',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: 140,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: NetworkImage(widget.data!.image!),
                              fit: BoxFit.contain)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.data!.title!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.data!.category!.toString(),
                            style: const TextStyle(
                                color: Colors.black45,
                                fontSize: 16,
                                fontWeight: FontWeight.w800),
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.star,
                                // color: Color.fromARGB(255, 202, 184, 20),
                                color: Colors.yellow,
                              ),
                              Text(
                                widget.data!.rating!.rate.toString(),
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                '(' +
                                    widget.data!.rating!.count.toString() +
                                    ' Reviews)',
                                style: const TextStyle(
                                    color: Colors.black45,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '\$ ' + widget.data!.price!.toString(),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 23,
                            fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'Description',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.data!.description!,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 7,
                        style: const TextStyle(
                            color: Colors.black45,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                /*
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 15, horizontal: 25.0),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(
                          //   '\$ ' + widget.data!.price!.toString(),
                          //   overflow: TextOverflow.ellipsis,
                          //   maxLines: 2,
                          //   style: const TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 23,
                          //       fontWeight: FontWeight.w800),
                          // ),
                          Container(
                            alignment: Alignment.center,
                            // color: const Color(0xff0F172A),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorPrimary,
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 25, vertical: 10),
                              child: Row(
                                children: [
                                  Text(
                                    'Add To Cart',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Icon(
                                    Icons.add_shopping_cart,
                                    color: Colors.white,
                                    // size: 20,
                                  )
                                ],
                              ),
                            ),
                          )
                        ]),
                  ),
                )
                 */
              ],
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Row(
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(left: 10, right: 20),
                height: 50,
                width: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: colorPrimary,
                  ),
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.shopping_cart,
                  ),
                  onPressed: () {
                    Toasts.toastMessage('Coming Soon');
                  },
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Toasts.toastMessage('Coming Soon');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    backgroundColor: colorPrimary,
                  ),
                  child: Text(
                    "Buy  Now".toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
