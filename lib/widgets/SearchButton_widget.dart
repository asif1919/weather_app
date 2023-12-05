import 'package:flutter/material.dart';

class SearchButtonWidget extends StatelessWidget {
 SearchButtonWidget({required this.function, super.key});
  
  VoidCallback function;
  @override
  Widget build(BuildContext context) {
    return InkWell(
                  onTap: function,
                  child: Card(
                    color: Colors.white.withOpacity(0.1),
                    child: const SizedBox(
                      width: 100,
                      height: 50,
                      child: Center(
                          child: Text("Search",
                              style: TextStyle(color: Colors.white))),
                    ),
                  ),
                );
  }
}