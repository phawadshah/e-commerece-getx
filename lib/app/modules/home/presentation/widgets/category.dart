import 'package:flutter/material.dart';
import 'package:shop/app/utils/helper.dart';

import '../../../categories/data/models/category.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({
    super.key,
    required this.categories,
    this.onTap,
  });

  final List<CategoryModel> categories;
  final Function(CategoryModel)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Popular Categories",
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        addVerticleSpace(10),
        SizedBox(
          height: 100,
          child: ListView.separated(
              itemCount: categories.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    onTap?.call(categories[index]);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    width: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        categories[index].name,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              }),
        )
      ],
    );
  }
}
