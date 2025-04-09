import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isObscure;
  final VoidCallback? onToggle;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    required this.hintText,
    required this.icon,
    this.isObscure = false,
    this.onToggle,
    this.controller,
    this.validator,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: TextStyle(color: Colors.white),
      validator: validator,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(16),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
          borderRadius: BorderRadius.circular(16),
        ),
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white),
        suffixIcon: onToggle != null
            ? IconButton(
          icon: Icon(
            isObscure ? Icons.visibility_off : Icons.visibility,
            color: Colors.white,
          ),
          onPressed: onToggle,
        )
            : null,
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      ),
    );
  }
}
