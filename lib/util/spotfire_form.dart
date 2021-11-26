import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpotfireFormField {
  static Widget buildTextFormField({
    required String label,
    required TextEditingController textEditingController,
    TextInputType? keyboardType,
    required TextInputAction action,
    Widget? suffix,
    required Function focus,
    Widget? prefix,
    bool obscureText = false,
    int? maxLength,
    bool last = false,
    FormFieldValidator<String>? validator,
    ValueChanged<String>? onChanged,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return TextFormField(
      controller: textEditingController,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        labelStyle: const TextStyle(
          color: Colors.grey,
        ),
        prefixIcon: prefix ?? const SizedBox(),
        suffix: suffix ?? const SizedBox(),
        labelText: label,
        border: last ? InputBorder.none : const UnderlineInputBorder(),
      ),
      onChanged: onChanged,
      obscureText: obscureText,
      maxLength: maxLength,
      validator: validator ??
          (String? v) {
            if (v!.trim().isEmpty) {
              return 'Informe um $label válido';
            } else {
              return null;
            }
          },
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: action,
      onEditingComplete: () => focus(),
    );
  }
}
