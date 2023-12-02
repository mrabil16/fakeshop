import 'package:apps.technical.sera_astra/core/viewmodel/home_viewmodel.dart';
import 'package:apps.technical.sera_astra/ui/view/base_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/app_color.dart';
import '../../core/viewmodel/account_viewmodel.dart';
import '../widget/fade_route.dart';
import '../widget/gradient_button.dart';
import 'login_view.dart';

class CartView extends StatefulWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  _CartViewState createState() => _CartViewState();
}


class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: colorPrimary,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      body: BaseView<HomeViewModel>(
        onModelReady: (data) async {
          await data.init(context);
        },
        builder: (context, data, child) {
          return Container(
            child: data.isLogin == false
                ? Container(
                    padding: const EdgeInsets.all(20),
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/img_login.png",
                          width: 300,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "Oppsss...",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        const Text(
                          "Anda belum login\nsilahkan login terlebih dahulu",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        ButtonTheme(
                          child: RaisedGradientButton(
                            width: 200,
                            gradient: const LinearGradient(
                              colors: <Color>[
                                colorPrimary,
                                colorPrimary,
                              ],
                            ),
                            onPressed: () async {
                              Navigator.push(
                                context,
                                FadeRoute(
                                  page: LoginView(),
                                ),
                              ).then(
                                (value) async {
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (prefs.getBool('is_login') == true) {
                                    await data.getUser(context);
                                    setState(() {
                                      data.isLogin = true;
                                    });
                                  }
                                },
                              );
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                : data.cart == null
                    ? const Center(child: CircularProgressIndicator())
                    : data.cart!.isEmpty
                        ? Container(
                            padding: const EdgeInsets.all(20),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 30,
                                ),
                                Image.asset(
                                  "assets/images/empty.png",
                                  width: 300,
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                const Text(
                                  "Data Anda masih kosong",
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                )
                              ],
                            ),
                          )
                        : Stack(
                            children: [
                              Container(),
                              Positioned.fill(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: data.cart!.length,
                                  padding: const EdgeInsets.all(8),
                                  itemBuilder: (context, index) => Card(
                                    elevation: 0,
                                    child: Container(
                                      height: 110,
                                      padding: const EdgeInsets.all(8.0),
                                      width: 100,
                                      margin: const EdgeInsets.all(4.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(data
                                                      .product![index].image!)),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    data.product![index].title!,
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      data.product![index]
                                                          .description!,
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                  Text(
                                                    "\$${data.product![index].price!}",
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                color: Colors.grey[200],
                                                child: const Icon(Icons.remove),
                                              ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(data.cart![index]
                                                    .products![index].quantity
                                                    .toString()),
                                              ),
                                              Container(
                                                color: Colors.grey[200],
                                                child: const Icon(Icons.add),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                left: 0,
                                right: 0,
                                child: Container(
                                  color: Colors.white,
                                  padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16,
                                    bottom: 8.0,
                                    top: 4.0,
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Text(
                                            "Subtotal",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                "\$ ${data.totalPrice.toStringAsFixed(2)}",
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                              const Text(
                                                "Subtotal does not include shipping",
                                                style: TextStyle(
                                                  color: Colors.grey,
                                                  fontSize: 12.0,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 32,
                                                  vertical: 16.0,
                                                ),
                                                primary:
                                                    const Color(0xFFFF6600),
                                                elevation: 0,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                  side: const BorderSide(
                                                    color: Color(0xFFFF6600),
                                                  ),
                                                ),
                                              ),
                                              onPressed: () {},
                                              child: const Text("Check out"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
          );
        },
      ),
    );
  }

}
