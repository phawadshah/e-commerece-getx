import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shop/app/common/widgets/loading.dart';

class KImage extends StatelessWidget {
  const KImage({
    super.key,
    required this.src,
    this.fit = BoxFit.contain,
  });

  final String src;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      child: CachedNetworkImage(
        color: Colors.white,
        fit: BoxFit.contain,
        imageUrl: src,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.contain,
            ),
          ),
        ),
        placeholder: (context, url) => const Center(
          child: KLoadingWidget(),
        ),
        errorWidget: _buldErrorBuilder,
      ),
    );
  }
}

Widget _buldErrorBuilder(context, error, stackTrace) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(8)),
      color: Colors.grey.shade300,
    ),
    child: const Center(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Icon(
          Icons.error,
          color: Colors.red,
        ),
      ),
    ),
  );
}

class Skeleton extends StatelessWidget {
  const Skeleton(
      {super.key, this.height, this.width, this.layer = 1, this.radious = 8});

  final double? height, width;
  final int layer;
  final double radious;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(16 / 2),
      decoration: BoxDecoration(
          color: Theme.of(context).iconTheme.color!.withOpacity(0.04 * layer),
          borderRadius: BorderRadius.all(Radius.circular(radious))),
    );
  }
}
