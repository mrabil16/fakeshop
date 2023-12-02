import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/constant/regex_validation.dart';

class TextFieldWidget extends StatelessWidget {
  final String? initialValue;
  final Function(dynamic)? onChange;
  final FocusNode? focusNode;
  final TextCapitalization? textCapitalization;
  final bool? readOnly;
  final bool? enabled;
  final TextInputType? textInputType;
  final int? limitLength;
  final int? maxLines;
  final String? labelText;
  final String? hintText;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextInputAction? onAction;
  final bool? obsecureText;
  final TextEditingController? controller;
  final double? radius;
  final bool? withBorder;
  final List<RegexValidation>? validation;

  TextFieldWidget(
      {this.initialValue,
      this.onChange,
      this.focusNode,
      this.textCapitalization = TextCapitalization.none,
      this.readOnly = false,
      this.enabled = true,
      this.textInputType,
      this.limitLength,
      this.maxLines,
      this.labelText,
      this.hintText,
      this.suffixIcon,
      this.maxLength,
      this.onAction,
      this.obsecureText,
      this.controller,
      this.radius = 0,
      this.withBorder = true,
      this.validation = const []});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (withBorder == true) ...[
          if (labelText != null) ...[
            Text(
              "$labelText",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ]
        ],
        TextFormField(
          controller: controller,
          initialValue: initialValue,
          onChanged: onChange,
          focusNode: focusNode ?? null,
          textCapitalization: textCapitalization!,
          readOnly: readOnly!,
          enabled: enabled,
          keyboardType: textInputType,
          obscureText: obsecureText ?? false,
          inputFormatters: limitLength != null
              ? [LengthLimitingTextInputFormatter(limitLength)]
              : [],
          maxLength: maxLength,
          maxLines: maxLines,
          validator: (String? value) {
            String? error;
            validation!.forEach((element) {
              RegExp regExp = new RegExp(element.regex!);
              if (!regExp.hasMatch(value!)) {
                error = element.errorMesssage;
              }
            });
            return error;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            labelText: withBorder == true ? null : labelText,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey),
            counterText: "",
            suffixIcon: suffixIcon,
            suffixIconConstraints: BoxConstraints(
              minWidth: 20,
              minHeight: 20,
            ),
            filled: withBorder == true ? true : false,
            fillColor: Color(0xfff5f6f8),
            focusColor: Color(0xfff5f6f8),
            hoverColor: Color(0xfff5f6f8),
            //isDense: true,
            enabledBorder: withBorder == true
                ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(radius!))
                : UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
                  ),
            focusedBorder: withBorder == true
                ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.orange),
                    borderRadius: BorderRadius.circular(radius!))
                : UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.orange),
                  ),
            disabledBorder: withBorder == true
                ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(radius!))
                : UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
                  ),
            errorBorder: withBorder == true
                ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(radius!))
                : UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
                  ),
            focusedErrorBorder: withBorder == true
                ? OutlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(radius!))
                : UnderlineInputBorder(
                    borderSide: BorderSide(width: 1, color: Colors.grey[300]!),
                  ),
          ),
          textInputAction: onAction,
        )
      ],
    );
  }
}
