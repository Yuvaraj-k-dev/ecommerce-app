import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'package:ecommerce/ui/shimmer_box.dart';

class _ProductImageCacheManager extends CacheManager with ImageCacheManager {
  static const _key = 'productImages';
  static final _ProductImageCacheManager instance =
      _ProductImageCacheManager._();

  factory _ProductImageCacheManager() => instance;

  _ProductImageCacheManager._()
    : super(
        Config(
          _key,
          stalePeriod: const Duration(days: 14),
          maxNrOfCacheObjects: 250,
        ),
      );
}

class ProductImage extends StatelessWidget {
  final String url;
  final BoxFit fit;
  final double? height;
  final double? width;
  final int? memCacheWidth;
  final int? memCacheHeight;

  const ProductImage({
    super.key,
    required this.url,
    this.fit = BoxFit.contain,
    this.height,
    this.width,
    this.memCacheWidth,
    this.memCacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    final trimmedUrl = url.trim();
    if (trimmedUrl.isEmpty) {
      return SizedBox(
        height: height,
        width: width,
        child: const Center(child: Icon(Icons.broken_image_outlined)),
      );
    }

    return CachedNetworkImage(
      imageUrl: trimmedUrl,
      cacheManager: _ProductImageCacheManager.instance,
      height: height,
      width: width,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      maxWidthDiskCache: memCacheWidth,
      maxHeightDiskCache: memCacheHeight,
      fadeInDuration: const Duration(milliseconds: 120),
      fadeOutDuration: const Duration(milliseconds: 120),
      useOldImageOnUrlChange: true,
      placeholder: (context, _) {
        return ShimmerBox(height: height, width: width);
      },
      errorWidget: (context, failedUrl, error) {
        debugPrint('ProductImage failed: $failedUrl');
        debugPrint('ProductImage error: $error');
        return SizedBox(
          height: height,
          width: width,
          child: const Center(child: Icon(Icons.broken_image_outlined)),
        );
      },
      fit: fit,
    );
  }
}
