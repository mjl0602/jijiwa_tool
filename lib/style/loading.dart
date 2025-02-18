// import 'package:extended_image/extended_image.dart';
// import 'package:fconsole/fconsole.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:m_ring/style/color.dart';

/// 创建loading动画
// Widget? Function(ExtendedImageState)? imageLoadingStyle({
//   double size = 12,
//   double failIconSize = 12,
//   Color color = ColorPlate.white,
// }) =>
//     (ExtendedImageState state) {
//       if (state.extendedImageLoadState == LoadState.loading) {
//         return Container(
//           margin: EdgeInsets.all(12),
//           child: SpinKitFadingCircle(
//             size: size,
//             color: color,
//           ),
//         );
//       }
//       if (state.extendedImageLoadState == LoadState.failed) {
//         if (state.imageProvider is ExtendedNetworkImageProvider) {
//           var imageProvider =
//               (state.imageProvider as ExtendedNetworkImageProvider);
//           fconsole.error('加载图片链接失败: ${imageProvider.url}');
//         }
//         return Container(
//           margin: EdgeInsets.all(2),
//           child: Icon(
//             Icons.broken_image_rounded,
//             color: ColorPlate.white,
//             size: failIconSize,
//           ),
//         );
//       }
//       return null;
//     };

// Widget? Function(ExtendedImageState)? loadStateChangedMini =
//     imageLoadingStyle();
// Widget? Function(ExtendedImageState)? loadStateChangedBig =
//     imageLoadingStyle(size: 32, failIconSize: 32);
