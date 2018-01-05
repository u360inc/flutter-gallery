import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

class GalleryDrawer extends StatelessWidget {
  const GalleryDrawer({
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
  Widget build(BuildContext context) {
    final Widget androidItem = new RadioListTile<TargetPlatform>(
      secondary: new Icon(Icons.android),
      title: new Text('Android'),
      value: TargetPlatform.android,
      groupValue: Theme.of(context).platform,
      onChanged: onPlatformChanged,
      selected: Theme.of(context).platform == TargetPlatform.android,
    );

    final Widget iosItem = new RadioListTile<TargetPlatform>(
      secondary: new Icon(Icons.phone_iphone),
      title: new Text('iOS'),
      value: TargetPlatform.iOS,
      groupValue: Theme.of(context).platform,
      onChanged: onPlatformChanged,
      selected: Theme.of(context).platform == TargetPlatform.iOS,
    );

    final Widget sendFeedbackItem = new ListTile(
      leading: const Icon(Icons.report),
      title: const Text('Send feedback'),
      onTap: onSendFeedback ??
          () {
            launch('https://github.com/u360inc/flutter_gallery/issues/new');
          },
    );

    final Widget aboutItem = new AboutListTile(
        //icon: const FlutterLogo(),
        applicationVersion: 'January 2018',
        //applicationIcon: const FlutterLogo(),
        applicationLegalese: '© 2018 U360 CO. LTD,',
        aboutBoxChildren: <Widget>[
          new Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: new RichText(text: new TextSpan(children: <TextSpan>[])))
        ]);

    final List<Widget> allDrawerItems = <Widget>[
      androidItem,
      iosItem,
      const Divider(),
    ];

    bool addedOptionalItem = false;
    if (onCheckerboardOffscreenLayersChanged != null) {
      allDrawerItems.add(new CheckboxListTile(
        title: const Text('Checkerboard Offscreen Layers'),
        value: checkerboardOffscreenLayers,
        onChanged: onCheckerboardOffscreenLayersChanged,
        secondary: const Icon(Icons.assessment),
        selected: checkerboardOffscreenLayers,
      ));
      addedOptionalItem = true;
    }

    if (onCheckerboardRasterCacheImagesChanged != null) {
      allDrawerItems.add(new CheckboxListTile(
        title: const Text('Checkerboard Raster Cache Images'),
        value: checkerboardRasterCacheImages,
        onChanged: onCheckerboardRasterCacheImagesChanged,
        secondary: const Icon(Icons.assessment),
        selected: checkerboardRasterCacheImages,
      ));
      addedOptionalItem = true;
    }

    if (onShowPerformanceOverlayChanged != null) {
      allDrawerItems.add(new CheckboxListTile(
        title: const Text('Performance Overlay'),
        value: showPerformanceOverlay,
        onChanged: onShowPerformanceOverlayChanged,
        secondary: const Icon(Icons.assessment),
        selected: showPerformanceOverlay,
      ));
      addedOptionalItem = true;
    }

    if (addedOptionalItem) allDrawerItems.add(const Divider());

    allDrawerItems.addAll(<Widget>[
      sendFeedbackItem,
      aboutItem,
    ]);

    return new Drawer(
        child: new ListView(primary: false, children: allDrawerItems));
  }
}
