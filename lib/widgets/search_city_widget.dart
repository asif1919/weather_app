import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class SearchCardWidget extends StatelessWidget {
  SearchCardWidget(
      {required this.controller, required this.function, super.key});
  TextEditingController controller;
  VoidCallback function;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xff061827),
      child: SizedBox(
        width: double.infinity,
        child: TextField(
          style: TextStyle(color: Colors.white.withOpacity(0.5)),
          controller: controller,
          decoration: InputDecoration(
            hintText: 'Search by city',
            hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            prefixStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
            prefixIcon: IconButton(
              icon: const Icon(Icons.search, color: Colors.white),
              onPressed: function,
            ),
            border: const OutlineInputBorder(borderSide: BorderSide.none),
          ),
        ),
      ),
    );
  }
}
