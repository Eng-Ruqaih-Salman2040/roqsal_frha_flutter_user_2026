import 'package:flutter/material.dart';



class level {
  final String id;
  final List<String> categories;
  final String title;
  final String image;

  

  const level({
    required this.id,
    required this.categories,
    required this.title,
    required this.image, required List<String> sections,
  });
}
