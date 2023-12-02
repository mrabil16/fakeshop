import 'package:flutter/material.dart';
import '../../core/constant/app_color.dart';

class ModalProgress extends StatelessWidget {
  final bool? inAsyncCall;
  final double? opacity;
  final Color? color;
  final Widget? progressIndicator;
  final Offset? offset;
  final bool? dismissible;
  final Widget? child;

  ModalProgress({
    Key? key,
    @required this.inAsyncCall,
    this.opacity = 0.3,
    this.color = Colors.grey,
    this.progressIndicator = const CircularProgressIndicator(
      color: colorPrimary,
    ),
    this.offset,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child!);
    if (inAsyncCall!) {
      Widget layOutProgressIndicator;
      if (offset == null)
        layOutProgressIndicator = Center(
          child: Container(
            height: 150,
            width: 150,
            // decoration: BoxDecoration(
            //   borderRadius: BorderRadius.all(Radius.circular(20)),
            //   image: DecorationImage(
            //       image: AssetImage("assets/images/loading.gif"), fit: BoxFit.cover
            //   ),
            //   color: Colors.white
            // ),
          ),
        );
      //   else {
      //     layOutProgressIndicator = Positioned(
      //       child: Container(
      //         height: 150,
      //         width: 150,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.all(Radius.circular(20)),
      //           image: DecorationImage(
      //               image: AssetImage("assets/images/loading.gif"), fit: BoxFit.cover
      //           ),
      //           color: Colors.white
      //         ),
      //       ),
      //       left: offset!.dx,
      //       top: offset!.dy,
      //     );
      //   }
      //   final modal = [
      //     new Opacity(
      //       child: new ModalBarrier(dismissible: dismissible!, color: color),
      //       opacity: opacity!,
      //     ),
      //     layOutProgressIndicator
      //   ];
      //   widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}
