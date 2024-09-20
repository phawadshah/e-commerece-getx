import 'package:flutter/material.dart';
import 'package:shop/app/modules/categories/data/models/category.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({
    super.key,
    required this.categories,
    this.onTap,
  });

  final List<CategoryModel> categories;
  final Function(CategoryModel)? onTap;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: categories.length,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 25,
        mainAxisSpacing: 10,
        mainAxisExtent: 100,
        childAspectRatio: 1,
      ),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            onTap?.call(categories[index]);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.grey.shade300,
              ),
            ),
            child: Center(
              child: Text(
                categories[index].name,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
