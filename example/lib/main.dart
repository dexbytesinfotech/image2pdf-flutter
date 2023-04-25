// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.
import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:image2pdf_flutter/image_to_pdf.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final e = E();
  e.b = true;
  await ImageToPdfMain.initValue();

  Configuration.instance!.editDocumentNameTextStyle = Configuration
      .instance!.editDocumentNameTextStyle!
      .copyWith(fontSize: 14, color: Colors.black);

  Configuration.instance!.cameraIconBgColor = Colors.black;
  // Configuration.instance!.cameraIcon = Icon(Icons.add, size: 80);

  runApp(ImageToPdfMain(pdfPathCallBack: (String pdfPath) {}));
}

/// Test class.
class E with EquatableMixin {
  /// Test bool.
  late bool b;
  @override
  List<Object> get props => [b];
}
