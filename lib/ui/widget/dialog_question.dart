import 'package:flutter/material.dart';

enum SomeMode { Lottie, Network, Asset }

class ButtonConfig {
  final String? dialogDone, dialogCancel;
  Color? buttonCancelColor, buttonDoneColor, labelCancelColor, labelDoneColor;

  ButtonConfig(
      {this.dialogDone = 'Done',
      this.dialogCancel = 'Cancel',
      this.buttonCancelColor,
      this.buttonDoneColor}) {
    if (buttonCancelColor == null) buttonCancelColor = Color(0xffF4F4F8);
    if (buttonDoneColor == null) buttonDoneColor = Color(0xff5841BF);
    if (labelCancelColor == null) labelCancelColor = Colors.black;
    if (labelDoneColor == null) labelDoneColor = Colors.white;
  }
}

class DialogQuestion {
  final String? path;
  final String? title;
  final String? content;
  final double? dialogHeight;
  final double? imageHeight;
  final double? imageWidth;
  final Function submit;
  final BuildContext context;

  String? appName;
  ButtonConfig? buttonConfig;
  SomeMode? mode = SomeMode.Lottie;

  DialogQuestion(
      {Key? key,
      required this.context,
      required this.path,
      required this.title,
      required this.content,
      required this.submit,
      @required this.mode,
      this.buttonConfig,
      this.imageHeight = 150,
      this.imageWidth = 150,
      this.dialogHeight = 310,
      this.appName = "TaniQu Dialog"}) {
    if (buttonConfig == null) buttonConfig = new ButtonConfig();

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(16))),
              contentPadding: EdgeInsets.fromLTRB(16, 24, 16, 8),
              content: Container(
                width: double.maxFinite,
                height: dialogHeight,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 16),
                    Center(
                      child: Image.asset(
                        "$path",
                        width: imageWidth,
                        height: imageHeight,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '$title',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      '$content',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.black,
                      ),
                    ),
                    Expanded(
                      child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 22),
                                          decoration: BoxDecoration(
                                              color: buttonConfig!.buttonCancelColor,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Text(
                                            "${buttonConfig!.dialogCancel}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  buttonConfig!.labelCancelColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 4),
                                      InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                          submit();
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 12, horizontal: 26),
                                          decoration: BoxDecoration(
                                              color:
                                                  buttonConfig!.buttonDoneColor,
                                              borderRadius:
                                                  BorderRadius.circular(16)),
                                          child: Text(
                                            "${buttonConfig!.dialogDone}",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.bold,
                                              color:
                                                  buttonConfig!.labelDoneColor,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
