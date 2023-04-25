part of image2pdf_flutter;

class ImageToPdfMain extends StatelessWidget {
  final Function(String)? pdfPathCallBack;

  const ImageToPdfMain({Key? key, this.pdfPathCallBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: ImageToPdfHome(pdfPathCallBack: pdfPathCallBack));
  }

  ///Init value
  static Future<void> initValue() async {
    await packageUtil.getDataListFromLocal();
    return;
  }
}

final Map<String, DocumentPathModel> documentList = {};

///Set Document details
set setDocument(DocumentPathModel value) {
  String key = value.documentSaveId!;
  packageUtil.storeDocumentInLocal = value;
  documentList[key] = value;
}

///Return document list
List<DocumentPathModel> get getDocumentList {
  return packageUtil.getDataList.values.toList();
}

///Return document
DocumentPathModel? getSelectedDocument(String documentId) {
  return packageUtil.getDataList[documentId];
}

class ImageToPdfHome extends StatefulWidget {
  final Function(String)? pdfPathCallBack;

  /// Default Constructor
  const ImageToPdfHome({Key? key, this.pdfPathCallBack}) : super(key: key);

  @override
  State<ImageToPdfHome> createState() {
    return _ImageToPdfHomeState();
  }
}

class _ImageToPdfHomeState extends State<ImageToPdfHome> {
  List<DocumentPathModel> documentList = getDocumentList;

  _ImageToPdfHomeState() {
    if (documentList.isNotEmpty) {
      documentList = new List.from(documentList.reversed);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 20, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: documentList.isEmpty
                        ? Center(
                            child: SizedBox(
                              child: Text(
                                "No documents found",
                                style: TextStyle(
                                    color: Colors.black26, fontSize: 15),
                              ),
                            ),
                          )
                        : ListView.builder(
                            itemCount: documentList.length,
                            itemBuilder: (BuildContext context, int index) {
                              DocumentPathModel documentPathModel =
                                  documentList[index];
                              int fileCount = documentPathModel
                                  .documentImagePathList!.length;
                              String filePath = fileCount > 0
                                  ? documentPathModel
                                      .documentImagePathList![fileCount - 1]
                                  : "";
                              String selectedDocumentId =
                                  documentPathModel.documentSaveId!;
                              return fileCount <= 0
                                  ? SizedBox()
                                  : InkWell(
                                      onTap: () {
                                        ///Redirect to share pdf list screen
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (_) => SharePdfScreen(
                                                    selectedDocumentId:
                                                        selectedDocumentId,
                                                    pdfPathCallBack: widget
                                                        .pdfPathCallBack))).then(
                                            (value) {
                                          setState(() {
                                            documentList = getDocumentList;
                                            documentList = new List.from(
                                                getDocumentList.reversed);
                                          });
                                        });
                                      },
                                      child: ListTile(
                                          leading: SizedBox(
                                            height: 80,
                                            width: 60,
                                            child: Image.file(File(filePath)),
                                          ),
                                          title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${documentPathModel.documentName}",
                                                style: Configuration.instance!
                                                    .documentListTextStyle,
                                              ),
                                              Text(
                                                "${documentPathModel.documentSaveDateAndTime}",
                                                style: Configuration.instance!
                                                    .documentListTimeTextStyle,
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Icon(Icons.file_copy),
                                                  Text("$fileCount"),
                                                ],
                                              )
                                            ],
                                          )),
                                    );
                            }),
                  ),
                  Align(
                    child: Configuration.instance!.cameraIcon != null
                        ? InkWell(
                            onTap: () {
                              ///Redirect to open camera
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Camera(
                                          pdfPathCallBack: widget
                                              .pdfPathCallBack))).then((value) {
                                setState(() {
                                  documentList =
                                      new List.from(getDocumentList.reversed);
                                });
                              });
                            },
                            child: Configuration.instance!.cameraIcon,
                          )
                        : FloatingActionButton(
                            backgroundColor:
                                Configuration.instance!.cameraIconBgColor,
                            onPressed: () {
                              ///Redirect to open camera
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => Camera(
                                          pdfPathCallBack: widget
                                              .pdfPathCallBack))).then((value) {
                                setState(() {
                                  documentList =
                                      new List.from(getDocumentList.reversed);
                                });
                              });
                            },
                            child: Center(
                              child: Icon(Icons.camera, color: Colors.white),
                            ),
                          ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

///Document model to store images
class DocumentPathModel {
  String? documentName;
  String? documentSaveDateAndTime;
  String? documentSaveId;
  List<dynamic>? documentImagePathList;

  DocumentPathModel(
      {this.documentName,
      this.documentSaveDateAndTime,
      this.documentSaveId,
      this.documentImagePathList});

  DocumentPathModel.fromJson(Map<String, dynamic> json) {
    documentName = json['document_name'];
    documentSaveDateAndTime = json['document_save_date_and_time'];
    documentSaveId = json['document_save_id'];
    documentImagePathList = json['document_image_path_list'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['document_name'] = this.documentName;
    data['document_save_date_and_time'] = this.documentSaveDateAndTime;
    data['document_save_id'] = this.documentSaveId;
    data['document_image_path_list'] = this.documentImagePathList;
    return data;
  }
}

///Get shar
get shareablePdfLink {
  String path = "";

  return path;
}
