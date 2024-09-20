import 'package:flutter/material.dart';
import 'package:shop/app/modules/home/data/models/product.dart';
import 'package:shop/app/utils/helper.dart';

class HistoryWidget extends StatelessWidget {
  const HistoryWidget({
    super.key,
    required this.previousSearches,
    this.onTap,
    this.onClearHistoryTap,
    this.onClearAllTap,
  });

  final List<Product> previousSearches;
  final Function(Product)? onTap;
  final Function(Product)? onClearHistoryTap;
  final Function()? onClearAllTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text(
              "Recent searches",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            TextButton(
                onPressed: onClearAllTap,
                child: const Text(
                  "Clear all",
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        ),
        ListView.separated(
          itemCount: previousSearches.length,
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
                onTap?.call(previousSearches[index]);
              },
              child: Row(
                children: [
                  const Icon(
                    Icons.history,
                    color: Colors.black38,
                  ),
                  addHorizontalSpace(10),
                  Expanded(
                    child: Text(
                      previousSearches[index].title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      onClearHistoryTap?.call(previousSearches[index]);
                    },
                    child: const Icon(
                      Icons.clear,
                      color: Colors.black38,
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
