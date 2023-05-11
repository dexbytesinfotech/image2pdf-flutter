part of image2pdf_flutter;

/// Developer calls the screen to display PDF images and share generated PDF file.
class SharePdfScreen extends StatefulWidget {
  final String selectedDocumentId;
  final Function(String)? pdfPathCallBack;
  final Function(Map<String, dynamic>)? currentDocumentCallBack;
  final Function(Map<String, dynamic>)? saveCurrentDocumentCallBack;

  /// Default Constructor
  const SharePdfScreen(
      {Key? key,
      required this.selectedDocumentId,
      this.pdfPathCallBack,
      this.currentDocumentCallBack,
      this.saveCurrentDocumentCallBack})
      : super(key: key);

  @override
  State<SharePdfScreen> createState() {
    return _SharePdfScreenState(selectedDocumentId: selectedDocumentId);
  }
}

class _SharePdfScreenState extends State<SharePdfScreen> {
  String selectedDocumentId;
  DocumentPathModel? document;
  String? documentName = "";
  List<dynamic>? documentImagePathList;
  int? documentCount;
  String pdfPathToShare = "";
  BuildContext? contextShareLoader;

  TextEditingController controller = TextEditingController();
  FocusNode inputNode = FocusNode();

  bool isNameEdited = false;

  _SharePdfScreenState({required this.selectedDocumentId}) {
    document = getSelectedDocument(this.selectedDocumentId);
    if (document == null) {
      document = DocumentPathModel();
    }
    documentName = document!.documentName ?? "";
    documentImagePathList = document!.documentImagePathList ?? [];
    documentCount = documentImagePathList!.length + 1;
    controller.text = documentName ?? "";
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Widget addMoreImage() {
    Color textColor = Colors.black26;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(12),
        padding: EdgeInsets.all(6),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          child: Container(
            child: Center(
                child: Stack(
              alignment: Alignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => Camera(
                                selectedDocumentId: widget.selectedDocumentId,
                                pdfPathCallBack: widget.pdfPathCallBack))).then(
                        (value) {
                      // Navigator.pop(context);
                      try {
                        setState(() {
                          document =
                              getSelectedDocument(this.selectedDocumentId);
                          documentName = document!.documentName;
                          documentImagePathList =
                              document!.documentImagePathList;
                          documentCount = documentImagePathList!.length + 1;
                        });
                      } catch (e) {
                        print(e);
                      }
                    });
                  },
                  child: Align(
                    alignment: Alignment.center,
                    child: Wrap(
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Text(
                                  "Tap ",
                                  style: TextStyle(color: textColor),
                                ),
                                Icon(
                                  Icons.add_a_photo_outlined,
                                  color: textColor,
                                  size: 15,
                                ),
                                Text(
                                  " to add",
                                  style: TextStyle(color: textColor),
                                ),
                              ],
                            ),
                            Text(
                              "new pages",
                              style: TextStyle(color: textColor),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            )),
          ),
        ),
      ),
    );
  }

  ///Close icon
  Widget closeWidget(int index) {
    return Align(
      alignment: Alignment.topRight,
      child: InkWell(
        onTap: () {
          setState(() {
            documentImagePathList!.removeAt(index);
            documentCount = documentImagePathList!.length + 1;

            document!.documentImagePathList = documentImagePathList!;

            packageUtil.deleteDocument = document!;
          });
        },
        child: Container(
          padding: EdgeInsets.all(5),
          margin: EdgeInsets.only(top: 4, right: 4),
          child: Icon(
            Icons.close,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  ///Update Document name
  updatePdfName() {
    packageUtil.updatePdfName(document!.documentSaveId!, documentName!);
  }

  ///Done click
  onDoneClick() {
    String updateName = controller.text.toString().trim();
    if (updateName.isNotEmpty &&
        packageUtil.updatePdfName(document!.documentSaveId!, updateName)) {
      setState(() {
        documentName = updateName;
        isNameEdited = false;
      });
    }
  }

  ///App bar input field
  Widget nameInput() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Center(
        child: SizedBox(
          height: 40,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  autofocus: true,
                  focusNode: inputNode,
                  cursorColor: Colors.white,
                  enabled: isNameEdited,
                  style: Configuration.instance!.editDocumentNameTextStyle,
                  controller: controller,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                      // contentPadding: EdgeInsets.only(left: 5, right: 5),
                      border: InputBorder.none,
                      hintText: 'Enter a document name'),
                  onSubmitted: (value) {
                    onDoneClick();
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: InkWell(
                    onTap: () {
                      if (isNameEdited) {
                        onDoneClick();
                      } else {
                        setState(() {
                          isNameEdited = true;
                        });
                        FocusScope.of(context).requestFocus(inputNode);
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 5),
                      child: isNameEdited
                          ? Configuration.instance!.editPdfNameSaveIcon
                          : Configuration.instance!.editPdfNameEditIcon,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white.withOpacity(0.85),
        appBar: AppBar(
          backgroundColor: Configuration.instance!.appBarBgColor,
          leadingWidth: 40,
          leading: InkWell(
              onTap: () {
                Navigator.pop(context, true);
              },
              child: Container(
                  child: Center(child: Configuration.instance!.backArrowIcon))),
          title: nameInput(),
          titleSpacing: 0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(bottom: 10, top: 10),
                child: documentCount! <= 0
                    ? const SizedBox()
                    : GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                        ),
                        itemCount: documentCount,
                        itemBuilder: (BuildContext context, int index) {
                          String filePath = "";
                          int count = index + 1;
                          if (index < documentCount! - 1) {
                            filePath = documentImagePathList![index];
                          }
                          return filePath.isNotEmpty
                              ? Card(
                                  color: Configuration.instance!.imageBgColor,
                                  shape: Configuration.instance!.imageCardShape,
                                  child: Center(
                                      child: Stack(
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          child: Image.file(File(filePath),
                                              fit: BoxFit.fill),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.bottomCenter,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: Configuration
                                                  .instance!
                                                  .imageCardBottomShape,
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Icon(
                                                    Icons.file_copy,
                                                    color: Colors.white,
                                                  ),
                                                  Text(
                                                    "$count",
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      closeWidget(index)
                                    ],
                                  )),
                                )
                              : addMoreImage();
                        }),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Container(
                padding: EdgeInsets.only(right: 10, bottom: 10),
                child: widget.saveCurrentDocumentCallBack != null
                    ? FloatingActionButton(
                        backgroundColor:
                            Configuration.instance!.shareIconBgColor,
                        onPressed: () {
                          saveAndCallBack();
                        },
                        child: Configuration.instance!.saveIcon,
                      )
                    : FloatingActionButton(
                        backgroundColor:
                            Configuration.instance!.shareIconBgColor,
                        onPressed: () {
                          sharePdf();
                        },
                        child: Configuration.instance!.shareIcon,
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }

  saveAndCallBack() {
    Map<String, dynamic> documentDetails = document!.toJson();
    widget.saveCurrentDocumentCallBack?.call(documentDetails);
    Navigator.pop(context, true);
  }

  ///Share created PDF
  sharePdf() async {
    if (pdfPathToShare.isEmpty) {
      showLoaderDialog(context);
      pdfPathToShare = await packageUtil.pdfGenerator(documentImagePathList!,
          documentName: documentName!);
      Navigator.pop(contextShareLoader!);
    }
    widget.pdfPathCallBack?.call(pdfPathToShare);

    // _onShare method:
    final box = context.findRenderObject() as RenderBox?;

    await Share.shareXFiles(
      [XFile(pdfPathToShare, name: "abcd")],
      subject: 'Example share',
      text: 'Example share text',
      sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
    );
  }

  /// Show loader while generating image to PDF
  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Preparing PDF..")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        contextShareLoader = context;
        return alert;
      },
    );
  }
}
