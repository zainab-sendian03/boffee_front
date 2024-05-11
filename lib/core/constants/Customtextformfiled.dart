import 'package:flutter/material.dart';
import 'package:flutter_application_test/core/constants/colors.dart';
import 'functions/validInput.dart';

class CustomTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final int min;
  final int max;
  final bool visPassword;
  final bool showVisPasswordToggle;
  final void Function()? onTapIcon;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.min,
    required this.max,
    this.visPassword = true,
    this.showVisPasswordToggle = false,
    this.onTapIcon,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late bool _visPassword;

  @override
  void initState() {
    super.initState();
    _visPassword = widget.visPassword;
  }

  void _handleTapIcon() {
    if (widget.onTapIcon != null) {
      widget.onTapIcon!();
    }

    setState(() {
      _visPassword = !_visPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: (valid) => validinput(valid!, widget.max, widget.min),
      obscureText: _visPassword,
      decoration: InputDecoration(
        errorMaxLines: 2,
        suffixIcon: widget.showVisPasswordToggle
            ? IconButton(
                icon: Icon(
                  _visPassword ? Icons.visibility_off : Icons.visibility,
                  color: Colorss.buttomColor,
                  size: 21,
                ),
                onPressed: _handleTapIcon,
              )
            : null,
        hintText: widget.hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          borderSide: BorderSide(color: Color(0xFFB8937E), width: 2.0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
