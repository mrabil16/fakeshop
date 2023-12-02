// ignore_for_file: use_build_context_synchronously

import 'package:apps.technical.sera_astra/ui/widget/dialog_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/app_color.dart';
import '../../core/constant/viewstate.dart';
import '../../core/viewmodel/auth_viewmodel.dart';
import '../widget/dialog_success.dart';
import '../widget/fade_route.dart';
import '../widget/gradient_button.dart';
import '../widget/modal_progress.dart';
import 'base_view.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final TextEditingController _txtEmailController = TextEditingController();
  final TextEditingController _txtPasswordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  Future<bool> _authenticate() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
    } on PlatformException catch (e) {
      return authenticated;
    }
    if (!mounted) {
      return authenticated;
    }
    if (authenticated) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(
        'is_login',
        true,
      );
      SuccessDialog(
        context: context,
        title: "Sukses",
        path: 'assets/images/img_success.png',
        content: "Fingerprint di aktifkan",
        imageHeight: 100,
        imageWidth: 100,
        dialogHeight: 280,
      );
      Future.delayed(new Duration(seconds: 1), () {
        Navigator.pop(context);
        Navigator.pop(context);
      });
      print("login biometric aktif");
    }

    return authenticated;
  }

  /*
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted)
      setState(() {
        _packageInfo = info;
      });
  }
  */

  @override
  void initState() {
    //_initPackageInfo();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
      onModelReady: (data) {
        data.init(context);
      },
      builder: (context, data, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: colorPrimary,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        body: ModalProgress(
          inAsyncCall: data.state == ViewState.Busy ? true : false,
          child: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    height: 100,
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: colorPrimary,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50,
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          top: 60,
                          left: 20,
                          right: 20,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Center(
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 24,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Center(
                              child: Text(
                                "masukan username dan password anda",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: IconButton(
                                icon: const Icon(
                                  Icons.fingerprint,
                                  color: Colors.grey,
                                ),
                                highlightColor: Colors.white,
                                iconSize: 80,
                                onPressed: () async {
                                  print("login fingerprint");
                                  SharedPreferences prefs =
                                      await SharedPreferences.getInstance();
                                  if (prefs.getBool('biometric_login') ==
                                      true) {
                                    print("biometric login aktif");
                                    if (await _authenticate() != true) {
                                      data.checkSessionLogin();
                                    }
                                  } else {
                                    print('biometric login belum aktif');
                                    DialogQuestion(
                                      context: context,
                                      path:
                                          "assets/images/fingerprint_failed.png",
                                      content:
                                          "Aktifkan fingerprint \ndi akun anda ?",
                                      title: "Informasi",
                                      appName: "",
                                      imageHeight: 100,
                                      imageWidth: 100,
                                      dialogHeight: 260,
                                      buttonConfig: ButtonConfig(
                                        dialogDone: "Oke",
                                        buttonDoneColor: colorPrimary,
                                      ),
                                      submit: () {},
                                      mode: null,
                                    );
                                  }
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _txtEmailController,
                              autofillHints: [AutofillHints.username],
                              decoration: InputDecoration(
                                hintText: 'Username',
                                labelText: 'Username',
                                contentPadding: const EdgeInsets.fromLTRB(
                                  20.0,
                                  10.0,
                                  20.0,
                                  10.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFormField(
                              controller: _txtPasswordController,
                              obscureText: data.hidePass,
                              autofillHints: [AutofillHints.password],
                              decoration: InputDecoration(
                                hintText: 'Kata Sandi',
                                labelText: 'Kata Sandi',
                                contentPadding: const EdgeInsets.fromLTRB(
                                  20.0,
                                  10.0,
                                  20.0,
                                  10.0,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30.0),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    data.hidePass
                                        ? FontAwesomeIcons.eyeSlash
                                        : FontAwesomeIcons.eye,
                                    color: Colors.black,
                                    size: 12,
                                  ),
                                  onPressed: () => data.changeHidePass(),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.push(
                                  //   context,
                                  //   FadeRoute(
                                  //     page: ForgotPasswordView(),
                                  //   ),
                                  // );
                                },
                                child: const Text(
                                  "Lupa Kata Sandi ?",
                                  style: TextStyle(
                                      color: colorPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            ButtonTheme(
                              minWidth: MediaQuery.of(context).size.width,
                              child: RaisedGradientButton(
                                gradient: const LinearGradient(
                                  colors: <Color>[
                                    colorPrimary,
                                    colorPrimary,
                                  ],
                                ),
                                onPressed: () async {
                                  var login = await data.checkLogin(
                                    _txtEmailController.text,
                                    _txtPasswordController.text,
                                    context,
                                  );
                                  if (login) {
                                    SuccessDialog(
                                      context: context,
                                      title: "Sukses",
                                      content:
                                          "Selamat datang di aplikasi Mobile Shop",
                                      imageHeight: 100,
                                      imageWidth: 100,
                                      dialogHeight: 280,
                                      path: 'assets/images/img_success.png',
                                    );
                                    Future.delayed(
                                      new Duration(
                                        seconds: 2,
                                      ),
                                      () {
                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                        data.checkSessionLogin();
                                      },
                                    );
                                  }
                                },
                                child: const Text(
                                  "Masuk",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  "Belum memiliki akun ? ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.pushReplacement(
                                    //   context,
                                    //   FadeRoute(
                                    //     page: RegisterView(),
                                    //   ),
                                    // );
                                  },
                                  child: const Text(
                                    "Daftar disini",
                                    style: TextStyle(
                                      color: colorPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: Center(
                      child: Container(
                        width: 80,
                        height: 80,
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Image.asset(
                            "assets/images/logo1.png",
                            color: Color(0xFFFF6600),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          width: double.infinity,
          height: 50,
          child: const Text(
            "Version: 1.0.0",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
