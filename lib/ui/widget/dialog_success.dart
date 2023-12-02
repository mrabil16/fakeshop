import 'package:flutter/material.dart';
import '../../core/constant/app_color.dart';

class SuccessDialog {
  final String? path;
  final String? title;
  final String? content;
  final double? dialogHeight;
  final double? imageHeight;
  final double? imageWidth;
  final BuildContext context;

  SuccessDialog(
      {Key? key,
      required this.context,
      this.path,
      required this.title,
      required this.content,
      this.imageHeight = 150,
      this.imageWidth = 150,
      this.dialogHeight = 310}) {
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
                        '$path',
                        width: 150,
                        height: 150,
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
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: colorPrimary,
                      ),
                    )
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

class LoadingDialog {
  // final String? path;
  final String? title;
  final String? content;
  final double? dialogHeight;
  // final double? imageHeight;
  // final double? imageWidth;
  final BuildContext context;

  LoadingDialog(
      {Key? key,
      required this.context,
      // this.path,
      required this.title,
      required this.content,
      // this.imageHeight = 150,
      // this.imageWidth = 150,
      this.dialogHeight = 310}) {
    showDialog(
        context: context,
        builder: (context) => AbsorbPointer(
              child: new AlertDialog(
                actions: [
                  Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$title',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'poppins',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '$content',
                              style: TextStyle(
                                color: Colors.black,
                                height: 150 / 100,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(bottom: 16),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: colorPrimary,
                            ),
                          )),
                    ],
                  ),
                ],
              ),
            ));
  }
}
