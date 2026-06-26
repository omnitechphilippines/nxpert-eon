import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../app/modules/layout/views/layout_view.dart';

class PlatformLayoutWrapper extends StatelessWidget {
  final Widget child;

  const PlatformLayoutWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      return LayoutView(child: child);
    }
    return child;
  }
}
