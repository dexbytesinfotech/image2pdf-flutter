part of image2pdf_flutter;

/// Developer will set pages background, TextStyle, and icon from this configuration class.
class Configuration {
  ///One instance, needs factory
  static Configuration? instance = new Configuration._();
  factory Configuration() => instance ??= new Configuration._();
  Configuration._();

  Widget? cameraIcon;
  TextStyle documentListTextStyle =
      TextStyle(color: Colors.green, fontSize: 15);

  TextStyle documentListTimeTextStyle =
      TextStyle(color: Colors.black, fontSize: 12);
  Decoration documentListImageDecoration = BoxDecoration(
    color: Colors.deepOrange,
    border: Border.all(
      color: Colors.grey,
      width: 0.0,
    ),
  );
  Color cameraIconBgColor = Colors.blue;

  Widget shareIcon = Icon(
    Icons.share,
    color: Colors.white,
    size: 30,
  );
  Widget editPdfNameEditIcon = Icon(Icons.edit, color: Colors.white);
  Widget editPdfNameSaveIcon = Icon(Icons.save, color: Colors.white);
  Widget backArrowIcon = Icon(Icons.arrow_back_ios_sharp, color: Colors.white);
  Widget deleteDocumentIcon = Icon(Icons.close, color: Colors.white);
  TextStyle? editDocumentNameTextStyle =
      TextStyle(fontSize: 14, color: Colors.white);
  Color shareIconBgColor = Colors.blue;
  Color appBarBgColor = Colors.blue;

  Widget importImgIcon = Icon(Icons.image, color: Colors.white);
  Widget takeImgIcon = SizedBox(
    height: 50,
    width: 50,
    child: Container(
      padding: EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(width: 0, color: Colors.transparent),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(width: 2, color: Colors.black),
        ),
      ),
    ),
  );
  Widget closeCameraIcon = Icon(
    Icons.close,
    color: Colors.white,
    size: 35.0,
  );
  Color cameraBgColor = Colors.black;
  Color imageBgColor = Colors.black26;
  Color imageBottomBgColor = Colors.black26;
  ShapeBorder imageCardShape = RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(15),
        topLeft: Radius.circular(15),
        bottomRight: Radius.circular(15),
        bottomLeft: Radius.circular(15)),
  );
  Decoration imageCardBottomShape = ShapeDecoration(
    color: Colors.black26,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(15), bottomLeft: Radius.circular(15)),
    ),
    // side: new BorderSide(color: Colors.white)
  );
  TextStyle importTextStyle = TextStyle(fontSize: 10, color: Colors.white);
}
