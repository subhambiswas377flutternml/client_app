import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final bool isPswd;
  final int maxLines;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  const CustomTextField({
    this.hint,
    this.label,
    this.controller,
    required this.validator,
    this.isPswd = false,
    this.maxLines = 1,
    this.keyboardType,
    this.inputFormatters,
    this.maxLength,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    final ValueNotifier<bool> hideContent = ValueNotifier<bool>(isPswd?true:false);

    return ValueListenableBuilder<bool>(
      valueListenable: hideContent,
      builder: (context, showPswd, child) {
        return TextFormField(
                    controller: controller,
                    obscureText: showPswd,
                    maxLines: maxLines,
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    maxLength: maxLength,
                    decoration: InputDecoration(
                      labelText: label,
                      hintText: hint,
                      counter: const SizedBox.shrink(),
                      suffixIcon: isPswd? InkWell(
                        onTap: (){
                          hideContent.value = !hideContent.value;
                        },
                        child: Icon(Icons.visibility),
                        ):null,
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      return validator.call(value);
                    },
                  );
      }
    );
  }
}