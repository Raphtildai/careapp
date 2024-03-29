// ignore_for_file: prefer_typing_uninitialized_variables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final iconImagePath;
  final String categoryName;

  const CategoryCard({required this.iconImagePath, required this.categoryName});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25.0),
      child: Container(
        padding: const EdgeInsets.all(20),  
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.deepPurple[100],
        ),
        child: Row(
          children: [
            Image.asset(
              iconImagePath,
              height: 30,
            ),

            const SizedBox(width: 10,),

            Text(categoryName),
          ],
        ),
      ),
    );
  }
}