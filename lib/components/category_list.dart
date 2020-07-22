import 'package:flutter/material.dart';
import 'package:shutterhouse/model/category.dart';

class CategoryList {
  static List<Category> getCategories(){
    List<Category> categoryList = [];
    categoryList.add(Category(id: 'category_photo',name: 'Photo'));
    categoryList.add(Category(id: 'category_video',name: 'Video'));
    categoryList.add(Category(id: 'category_gopro',name: 'Go Pro'));
    categoryList.add(Category(id: 'category_tripod',name: 'Tripod'));
    categoryList.add(Category(id: 'category_lens',name: 'Lens'));
    categoryList.add(Category(id: 'category_shutter',name: 'Remote Shutter'));
    categoryList.add(Category(id: 'category_light',name: 'Lighting'));
    categoryList.add(Category(id: 'category_storage',name: 'Storage'));
    categoryList.add(Category(id: 'category_accessories',name: 'Accessories'));
    categoryList.add(Category(id: 'category_props',name: 'Props'));
    categoryList.add(Category(id: 'category_printer',name: 'Printer'));
    categoryList.add(Category(id: 'category_backdrops',name: 'Backdrops'));
    return categoryList;
  }
}
