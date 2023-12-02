// ignore_for_file: use_build_context_synchronously

import 'package:apps.technical.sera_astra/ui/widget/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/constant/app_color.dart';
import '../../core/viewmodel/account_viewmodel.dart';
import '../widget/dialog_question.dart';
import '../widget/dialog_success.dart';
import '../widget/fade_route.dart';
import '../widget/gradient_button.dart';
import '../widget/menu.dart';
import '../widget/separator.dart';
import 'base_view.dart';
import 'login_view.dart';

class AccountView extends StatefulWidget {
  @override
  _AccountViewState createState() => _AccountViewState();
}

class _AccountViewState extends State<AccountView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  bool isLogin = false;
  final LocalAuthentication auth = LocalAuthentication();
  bool _isAuthenticating = false;

  Future<bool> checkSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLogin = prefs.getBool('is_login') ?? false;
    return isLogin;
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
      });
      authenticated = await auth.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          useErrorDialogs: true,
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print('$e');
      return;
    }
    if (!mounted) {
      return;
    }
    if (authenticated) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool('biometric_login', true);
      SuccessDialog(
        context: context,
        path: 'assets/images/img_success.png',
        title: "Sukses",
        content: "Fingerprint di aktifkan",
        imageHeight: 100,
        imageWidth: 100,
        dialogHeight: 280,
      );
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context);
      });
      setState(() {
        _isAuthenticating = true;
      });
      print("login biometric aktif");
    }
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('biometric_login', false);
    SuccessDialog(
      context: context,
      title: "Sukses",
      path: 'assets/images/img_success.png',
      content: "Fingerprint di non - aktifkan",
      imageHeight: 100,
      imageWidth: 100,
      dialogHeight: 280,
    );
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pop(context);
    });
    setState(() {
      _isAuthenticating = false;
    });
    print("biometric login dinonaktifkan, false");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0.0),
        child: AppBar(
          backgroundColor: colorPrimary,
          foregroundColor: Colors.transparent,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      extendBody: true,
      body: FutureBuilder(
        future: checkSessionLogin(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData) {
            return BaseView<AccountViewModel>(
              onModelReady: (data) async {
                data.init(context);
              },
              builder: (context, data, child) {
                if (isLogin == false) {
                  return _loginPage(data, context);
                } else {
                  if (data.user == null) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: colorPrimary,
                      ),
                    );
                  } else {
                    return _profilePage(data, context);
                  }
                }
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: colorPrimary,
              ),
            );
          }
        },
      ),
    );
  }

  Widget _loginPage(AccountViewModel data, BuildContext context) {
    return Container(
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
                        isLogin = true;
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
    );
  }

  Widget _profilePage(AccountViewModel data, BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                      child: Image.asset(
                    "assets/images/default_avatar.png",
                    fit: BoxFit.cover,
                    width: 80,
                    height: 80,
                  )),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "${data.user!.name!.firstname} ${data.user!.name!.lastname}",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${data!.user!.email}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    "${data!.user!.address!.city} ${data!.user!.address!.street} ${data!.user!.address!.number}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                  Text(
                    "${data!.user!.phone}",
                    style: const TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              color: Colors.white,
              child: const Text(
                "PENGATURAN AKUN",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  MenuWidget(
                    title: "Ubah Profil",
                    icon: FontAwesomeIcons.idCard,
                    onTap: () {
                      Toasts.toastMessage('Coming soon');
                    },
                  ),
                  _separator(),
                  MenuWidget(
                    title: "Ubah Kata Sandi",
                    icon: Icons.lock,
                    onTap: () {
                      Toasts.toastMessage('Coming soon');
                    },
                  ),
                  _separator(),
                  MenuWidget(
                    title: "Login Cepat",
                    icon: Icons.fingerprint,
                    onTap: () async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      if (prefs.getBool('biometric_login') == false) {
                        DialogQuestion(
                          context: context,
                          path: "assets/images/fingerprint_succes.png",
                          content:
                              "Apakah anda ingin mengaktifkan \nfingerprint ?",
                          title: "Fingerprint",
                          appName: "",
                          imageHeight: 100,
                          imageWidth: 100,
                          dialogHeight: 260,
                          buttonConfig: ButtonConfig(
                            dialogDone: "Yakin",
                            dialogCancel: "Batal",
                            buttonDoneColor: colorPrimary,
                          ),
                          submit: () {
                            _authenticate();
                          },
                          mode: null,
                        );
                      } else {
                        DialogQuestion(
                          context: context,
                          path: "assets/images/fingerprint_failed.png",
                          content:
                              "Apakah anda ingin menonaktifkan \nfingerprint ?",
                          title: "Fingerprint",
                          appName: "",
                          imageHeight: 100,
                          imageWidth: 100,
                          dialogHeight: 260,
                          buttonConfig: ButtonConfig(
                            dialogDone: "Yakin",
                            dialogCancel: "Batal",
                            buttonDoneColor: colorPrimary,
                          ),
                          submit: () {
                            _cancelAuthentication();
                          },
                          mode: null,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              color: Colors.white,
              child: const Text(
                "TENTANG APLIKASI",
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  MenuWidget(
                    title: "Shop Mobile",
                    icon: FontAwesomeIcons.mobileAlt,
                    onTap: () {
                      Toasts.toastMessage('Coming soon');
                    },
                  ),
                  SeparatorWidget(),
                  MenuWidget(
                    title: "Kebijakan Privasi",
                    icon: FontAwesomeIcons.lock,
                    onTap: () {
                      Toasts.toastMessage('Coming soon');
                    },
                  ),
                  SeparatorWidget(),
                  MenuWidget(
                    title: "Syarat & Ketentuan",
                    icon: FontAwesomeIcons.fileInvoice,
                    onTap: () {
                      Toasts.toastMessage('Coming soon');
                    },
                  ),
                  SeparatorWidget(),
                  MenuWidget(
                    title: 'Logout',
                    icon: Icons.logout_outlined,
                    onTap: () {
                      DialogQuestion(
                        context: context,
                        path: "assets/images/img_failed.png",
                        content:
                            "Apakah anda yakin ingin keluar \ndari akun ini ?",
                        title: "Logout",
                        appName: "",
                        imageHeight: 100,
                        imageWidth: 100,
                        dialogHeight: 260,
                        buttonConfig: ButtonConfig(
                          dialogDone: "Yakin",
                          dialogCancel: "Batal",
                          buttonDoneColor: colorPrimary,
                        ),
                        submit: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.remove('is_login');

                          setState(() {
                            isLogin = false;
                          });
                          checkSessionLogin();
                          SuccessDialog(
                            context: context,
                            title: "Sukses",
                            path: 'assets/images/img_success.png',
                            content: "Berhasil keluar dari akun",
                            imageHeight: 100,
                            imageWidth: 100,
                            dialogHeight: 280,
                          );
                          Future.delayed(
                            const Duration(seconds: 1),
                            () {
                              Navigator.pop(context);
                            },
                          );
                        },
                        mode: null,
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _separator() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      height: 1,
      color: Colors.grey[300],
    );
  }
}
