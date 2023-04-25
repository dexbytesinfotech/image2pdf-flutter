// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';

import 'package:image2pdf_flutter/image_to_pdf.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Init Image PDF it must required to get saved PDF.
  await ImageToPdfMain.initValue();

  /// Set icon and some another configuration setting.
  /// Set document name text style.
  Configuration.instance!.editDocumentNameTextStyle = Configuration
      .instance!.editDocumentNameTextStyle!
      .copyWith(fontSize: 14, color: Colors.black);

  /// Set camera icon background.
  Configuration.instance!.cameraIconBgColor = Colors.black;
  // Configuration.instance!.cameraIcon = Icon(Icons.add, size: 80);

  /// Open main screen of PDF.
  runApp(ImageToPdfMain(pdfPathCallBack: (String pdfPath) {}));
}
