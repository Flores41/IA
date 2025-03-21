import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final String? errorMessage;
  final bool obscureText;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Function(String)? onFieldSubmitted;
  final String? labelText;
  final Widget? prefixIcon;
  final TextEditingController? controller;

  const CustomTextFormField(
      {super.key,
      this.label,
      this.hint,
      this.errorMessage,
      this.obscureText = false,
      this.keyboardType = TextInputType.text,
      this.onChanged,
      this.validator,
      this.onFieldSubmitted,
      this.labelText,
      this.prefixIcon,
      this.controller});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final border = OutlineInputBorder(
        borderSide: BorderSide(color: colors.primary),
        borderRadius: BorderRadius.circular(10));

    // const borderRadius = Radius.circular(15);

    return TextFormField(
      controller: controller,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      validator: validator,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: TextStyle(
        fontSize: 18,
        color: colors.primary,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        floatingLabelStyle: TextStyle(
          color: colors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 17),
        enabledBorder: border,
        focusedBorder: border,
        errorBorder: border.copyWith(
            borderSide: BorderSide(
          color: colors.primary,
        )),
        focusedErrorBorder: border.copyWith(
            borderSide: BorderSide(
          color: colors.primary,
        )),
        isDense: true,
        label: label != null ? Text(label!) : null,
        hintText: hint,
        errorText: errorMessage,
        focusColor: colors.primary,
        // icon: Icon( Icons.supervised_user_circle_outlined, color: colors.primary, )
      ),
    );
  }
}
