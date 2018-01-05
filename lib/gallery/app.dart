import 'package:flutter/foundation.dart' show defaultTargetPlatform;
import 'package:flutter/material.dart';

import 'home.dart';

final ThemeData _kGalleryLightTheme = new ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue,
);

class GalleryApp extends StatefulWidget {
  const GalleryApp(
      {this.enablePerformanceOverlay: true,
      this.checkerboardRasterCacheImages: true,
      this.checkerboardOffscreenLayers: true,
      this.onSendFeedback,
      Key key})
      : super(key: key);

  final bool enablePerformanceOverlay;

  final bool checkerboardRasterCacheImages;

  final bool checkerboardOffscreenLayers;

  final VoidCallback onSendFeedback;

  @override
  GalleryAppState createState() => new GalleryAppState();
}

class GalleryAppState extends State<GalleryApp> {
  bool _showPerformanceOverlay = false;
  bool _checkerboardRasterCacheImages = false;
  bool _checkerboardOffscreenLayers = false;
  TargetPlatform _platform;

  @override
  Widget build(BuildContext context) {
    Widget home = new GalleryHome(
      showPerformanceOverlay: _showPerformanceOverlay,
      onShowPerformanceOverlayChanged: widget.enablePerformanceOverlay
          ? (bool value) {
              setState(() {
                _showPerformanceOverlay = value;
              });
            }
          : null,
      checkerboardRasterCacheImages: _checkerboardRasterCacheImages,
      onCheckerboardRasterCacheImagesChanged:
          widget.checkerboardRasterCacheImages
              ? (bool value) {
                  setState(() {
                    _checkerboardRasterCacheImages = value;
                  });
                }
              : null,
      checkerboardOffscreenLayers: _checkerboardOffscreenLayers,
      onCheckerboardOffscreenLayersChanged: widget.checkerboardOffscreenLayers
          ? (bool value) {
              setState(() {
                _checkerboardOffscreenLayers = value;
              });
            }
          : null,
      onPlatformChanged: (TargetPlatform value) {
        setState(() {
          _platform = value == defaultTargetPlatform ? null : value;
        });
      },
      onSendFeedback: widget.onSendFeedback,
    );

    final Map<String, WidgetBuilder> _kRoutes = <String, WidgetBuilder>{};

    return new MaterialApp(
      title: 'Gallery',
      color: Colors.grey,
      theme: _kGalleryLightTheme.copyWith(
          platform: _platform ?? defaultTargetPlatform),
      showPerformanceOverlay: _showPerformanceOverlay,
      checkerboardRasterCacheImages: _checkerboardRasterCacheImages,
      checkerboardOffscreenLayers: _checkerboardOffscreenLayers,
      routes: _kRoutes,
      home: home,
    );
  }
}
