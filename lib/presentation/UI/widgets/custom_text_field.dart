import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?) validator;
  final bool isPswd;
  const CustomTextField({
    this.hint,
    this.label,
    this.controller,
    required this.validator,
    this.isPswd = false,
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
                    decoration: InputDecoration(
                      labelText: label,
                      hintText: hint,
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