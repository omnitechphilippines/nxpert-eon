// lib/utils/web_title_web.dart
@JS('document')
library;

import 'dart:js_interop';

@JS('title')
external set documentTitle(String title);

void setPageTitle(String title) {
  documentTitle = title;
}
