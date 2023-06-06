import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:d_locker/Modals/file_modal.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewer extends StatefulWidget {
  FileModel file;
  PdfViewer(this.file);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  late File pdfFile;
  bool initialise=false;
  loadpdfFile(FileModel file)async{
    final response = await http.get(Uri.parse(file.url));
    final bytes = response.bodyBytes;
    return storeFile(file,bytes);
  }
  storeFile(FileModel file,List<int> bytes)async{
    final dir = await getApplicationDocumentsDirectory();
    final filename = File("${dir.path}/${file.name}");
    await filename.writeAsBytes(bytes,flush: true);
    return filename;
  }


  initializePDF()async{
pdfFile = await loadpdfFile(widget.file);
  initialise=true;
  setState(() {
  });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePDF();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: initialise?PDFView(
        filePath:pdfFile.path,
        fitEachPage: false,
      ):Container(),
    );
  }
}
