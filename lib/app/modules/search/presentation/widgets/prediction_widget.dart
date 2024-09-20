import 'package:flutter/material.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/helper.dart';

class PredictionWidget extends StatelessWidget {
  const PredictionWidget({
    super.key,
    required this.searchResults,
    this.onTap,
  });

  final List<Product> searchResults;
  final Function(Product)? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          itemCount: searchResults.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (_, __) => Column(
            children: [
              addVerticleSpace(10),
              const Divider(),
            ],
          ),
          itemBuilder: (_, index) {
            return GestureDetector(
              onTap: () {
                onTap?.call(searchResults[index]);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.search,
                    color: Colors.black38,
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: Text(
                      searchResults[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
