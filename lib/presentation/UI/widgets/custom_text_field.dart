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
  final bool enabled;
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
    this.enabled = true,
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
                    enabled: enabled,
                    maxLines: maxLines,
                    keyboardType: keyboardType,
                    inputFormatters: inputFormatters,
                    maxLength: maxLength,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: label,
                      labelStyle: enabled? null:TextStyle(color: Colors.black),
                      hintText: hint,
                      counter: const SizedBox.shrink(),
                      suffixIcon: isPswd? InkWell(
                        onTap: (){
                          hideContent.value = !hideContent.value;
                        },
                        child: Icon(Icons.visibility),
                        ):null,
                      border: OutlineInputBorder(),
                      disabledBorder: OutlineInputBorder(),
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                    ),
                    validator: (value) {
                      return validator.call(value);
                    },
                  );
      }
    );
  }
}