import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'drawer.dart';

const double _kFlexibleSpaceMaxHeight = 256.0;
const String _kGalleryAssetsPackage = 'flutter_gallery_assets';

class GalleryHome extends StatefulWidget {
  const GalleryHome({
    Key key,
    this.showPerformanceOverlay,
    this.onShowPerformanceOverlayChanged,
    this.checkerboardRasterCacheImages,
    this.onCheckerboardRasterCacheImagesChanged,
    this.checkerboardOffscreenLayers,
    this.onCheckerboardOffscreenLayersChanged,
    this.onPlatformChanged,
    this.onSendFeedback,
  })
      : super(key: key);

  final bool showPerformanceOverlay;
  final ValueChanged<bool> onShowPerformanceOverlayChanged;

  final bool checkerboardRasterCacheImages;
  final ValueChanged<bool> onCheckerboardRasterCacheImagesChanged;

  final bool checkerboardOffscreenLayers;
  final ValueChanged<bool> onCheckerboardOffscreenLayersChanged;

  final ValueChanged<TargetPlatform> onPlatformChanged;

  final VoidCallback onSendFeedback;

  @override
  GalleryHomeState createState() => new GalleryHomeState();
}

class GalleryHomeState extends State<GalleryHome>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();

  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new AnimationController(
      duration: const Duration(milliseconds: 600),
      debugLabel: 'preview banner',
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget home = new Scaffold(
        key: _scaffoldKey,
        drawer: new GalleryDrawer(
          showPerformanceOverlay: widget.showPerformanceOverlay,
          onShowPerformanceOverlayChanged:
              widget.onShowPerformanceOverlayChanged,
          checkerboardRasterCacheImages: widget.checkerboardRasterCacheImages,
          onCheckerboardRasterCacheImagesChanged:
              widget.onCheckerboardRasterCacheImagesChanged,
          checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
          onCheckerboardOffscreenLayersChanged:
              widget.onCheckerboardOffscreenLayersChanged,
          onPlatformChanged: widget.onPlatformChanged,
          onSendFeedback: widget.onSendFeedback,
        ),
        body: new CustomScrollView(
          slivers: <Widget>[
            const SliverAppBar(
              pinned: true,
              expandedHeight: _kFlexibleSpaceMaxHeight,
              flexibleSpace: const FlexibleSpaceBar(
                title: const Text('Gallery'),
              ),
            ),
          ],
        ));

    // In checked mode our MaterialApp will show the default "slow mode" banner.
    // Otherwise show the "preview" banner.
    bool showPreviewBanner = false;
    assert(() {
      showPreviewBanner = false;
      return true;
    }());

    if (showPreviewBanner) {
      home = new Stack(fit: StackFit.expand, children: <Widget>[
        home,
        new FadeTransition(
            opacity: new CurvedAnimation(
                parent: _controller, curve: Curves.easeInOut),
            child: const Banner(
              message: 'PREVIEW',
              location: BannerLocation.topEnd,
            )),
      ]);
    }

    return home;
  }
}
