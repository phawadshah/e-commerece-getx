import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:shop/app/common/widgets/product.dart';
import 'package:shop/app/utils/helper.dart';

import '../../modules/home/data/models/product.dart';

class KBrowseWidget extends StatelessWidget {
  const KBrowseWidget({
    super.key,
    required this.products,
    required this.wislist,
    required this.onTap,
    required this.onFavTap,
  });

  final List<Product> products;
  final RxList<int> wislist;
  final Function(Product)? onTap;
  final Function(Product)? onFavTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Items you previously viewed",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          addVerticleSpace(10),
          SizedBox(
            height: 230,
            child: ListView.separated(
              itemCount: products.length,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) {
                return const SizedBox(width: 10);
              },
              itemBuilder: (context, index) {
                final product = products[index];
                return Obx(
                  () => KProductCard(
                    width: 130,
                    product: Product.copyWith(
                      product,
                      isFav: wislist.any((w) => w == product.id),
                    ),
                    onTap: () {
                      onTap?.call(product);
                    },
                    onIconTap: () {
                      onFavTap?.call(product);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
