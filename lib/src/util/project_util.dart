import 'dart:convert';
import 'dart:io';

import 'package:image2pdf_flutter/src/util/shared_pref.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../parts.dart';

class PackageUtil {
  static Map<String, DocumentPathModel> documentList = {};
  static Map<String, dynamic> documentListTemp = {};

  //Store new Document in local
  set storeDocumentInLocal(DocumentPathModel value) {
    String key = value.documentSaveId!;
    documentList[key] = value;
    String encodedData = json.encode(documentList);
    print("$encodedData");
    localStorage.saveStr("image2pdf_flutter_data_list", encodedData);
  }

  //Delete document from local
  set deleteDocument(DocumentPathModel value) {
    String key = value.documentSaveId!;
    if (value.documentImagePathList!.isEmpty) {
      documentList.remove(key);
    } else {
      documentList[key] = value;
    }
    String encodedData = json.encode(documentList);
    localStorage.saveStr("image2pdf_flutter_data_list", encodedData);
  }

  //Update PDF name
  bool updatePdfName(String documentId, String documentName) {
    try {
      String key = documentId;
      DocumentPathModel? currentDocument = documentList[documentId];
      if (currentDocument != null) {
        currentDocument.documentName = documentName;
        documentList[key] = currentDocument;
        String encodedData = json.encode(documentList);
        localStorage.saveStr("image2pdf_flutter_data_list", encodedData);
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }

  Future<dynamic> getDataListFromLocal() async {
    try {
      String value = await localStorage.readStr("image2pdf_flutter_data_list");
      if (value.isNotEmpty) {
        Map<String, dynamic> tempData = json.decode(value);
        tempData.forEach((key, value) {
          documentList[key] = DocumentPathModel.fromJson(value);
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Map<String, DocumentPathModel> get getDataList => documentList;

  Future<String> pdfGenerator(List<dynamic> filesPathList,
      {String documentName = "", Function(double)? progressCallBac}) async {
    documentName = documentName.replaceAll(' ', '');
    if (documentName.contains(":")) {
      documentName = documentName.replaceAll(':', '_');
    }
    if (documentName.contains("/")) {
      documentName = documentName.replaceAll('/', '_');
    }
    double perFileProgress = 100 / filesPathList.length;
    double currentProgress = 0;
    progressCallBac?.call(currentProgress);
    String pdfPath = "";
    final pdf = pw.Document();
    for (var filePath in filesPathList) {
      File file = new File(filePath);
      pdf.addPage(pw.Page(build: (pw.Context context) {
        return pw.Center(
          child: pw.Image(
            pw.MemoryImage(
              file.readAsBytesSync(),
            ),
          ),
        ); // Center
      }));
      currentProgress += perFileProgress;
      progressCallBac?.call(currentProgress);
    }
    Directory tempDir = await getTemporaryDirectory();
    try {
      tempDir.createSync();
      final file = File("${tempDir.path}/$documentName.pdf");
      await file.writeAsBytes(await pdf.save());
      pdfPath = file.path;
    } catch (e) {}

    return pdfPath;
  }
}

PackageUtil packageUtil = PackageUtil();
