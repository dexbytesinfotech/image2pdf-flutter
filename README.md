# PDF creation library for dart/flutter

This library is divided into two parts:

- a low-level PDF creation library that takes care of the PDF bits generation.
- a Widgets system similar to Flutter's, for easy high-level PDF creation.

|               | Android   | iOS    |
| :-------------| :---------| :------|
| **Support**   | SDK 21+   | 10.0+  |

# image2pdf Implementation Guide

## Features

Use this plugin in your Flutter app to:

* Create Pfd with multi pages by selecting images.
* Share created PDF.

## Getting started

This plugin relies on the flutter core.

## Usage

To use the plugin you just need to add image2pdf-flutter: ^1.0.0+3 into your pubspec.yaml file and run
pub get.

## Add following into your package's pubspec.yaml (and run an implicit dart pub get):

image2pdf-flutter: ^1.0.0+3

## Multi Step Form UI Sample

[comment]: <> (![alt text]&#40;https://github.com/dexbytes/dynamic_multi_step_form/blob/master/lib/ui_image/multi_step_form.png?raw=true&#41;)

[comment]: <> (Credit for sample UI: )

## Example
 
    import 'dart:async';
    import 'package:image2pdf_flutter/image_to_pdf.dart';

    Future<void> main() async {
       WidgetsFlutterBinding.ensureInitialized();
       await ImageToPdfMain.initValue();
       Configuration.instance!.editDocumentNameTextStyle = Configuration .instance!.editDocumentNameTextStyle!.copyWith(fontSize: 14, color: Colors.black);
       Configuration.instance!.cameraIconBgColor = Colors.black; // Configuration.instance!.cameraIcon =
       Icon(Icons.add, size: 80);
       runApp(ImageToPdfMain(pdfPathCallBack: (String pdfPath) {}));
    }

## Changelog

All notable changes to this project will be documented in [this file](./CHANGELOG.md).

## Issues

To report your issues, submit them directly in
the [Issues](https://github.com/dexbytesinfotech/image2pdf-flutter/issues) section.

## License

[this file](./LICENSE).

