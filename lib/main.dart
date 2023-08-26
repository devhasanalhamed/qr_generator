import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QR Generator',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const MyHomePage(title: 'QR Generator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var dataMap = {
    'firstName': '',
    'lastName': '',
    'orgName': '',
    'title': '',
    'prefix': '',
    'extension': '',
    'phone': '',
    'email': '',
    'url': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  label: Text('الأسم الأول'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['firsName'] = value,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  label: Text('أسم العائلة'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['lastName'] = value,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  label: Text('الشركة'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['orgName'] = value,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  label: Text('المسمى الوظيفي'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['title'] = value,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  label: Text('سابقة الإسم'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['prefix'] = value,
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('وصلة الهاتف'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['extension'] = value,
              ),
              const SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  label: Text('الجوال'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['phone'] = value,
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: const InputDecoration(
                  label: Text('الإيميل'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['email'] = value,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: dataMap['url'],
                decoration: const InputDecoration(
                  label: Text('الموقع الإلكتروني'),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                onChanged: (value) => dataMap['url'] = value,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => showDialog(
                  context: context,
                  builder: (x) => Dialog(
                    child: Container(
                      height: 340,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(24),
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          QrImageView(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.all(30.0),
                            data: 'BEGIN:VCARD\n'
                                'VERSION:3.0\n'
                                'N:${dataMap['lastName']};${dataMap['firsName']};;${dataMap['prefix']};\n'
                                'FN:${dataMap['firsName']} ${dataMap['lastName']}\n'
                                'ORG:${dataMap['orgName']}\n'
                                'TITLE:${dataMap['title']}\n'
                                'TEL;TYPE=Work:+967${dataMap['phone']}\n'
                                'TEL;TYPE=Work:+9675327773,${dataMap['extension']}\n'
                                'EMAIL:${dataMap['email']}\n'
                                'URL:${dataMap['url']}\n'
                                'END:VCARD',
                            version: QrVersions.auto,
                            size: 220.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () => _shareScreenshot(
                                      context: context,
                                      shareWidget: QrImageView(
                                        backgroundColor: Colors.white,
                                        padding: const EdgeInsets.all(30.0),
                                        data: 'BEGIN:VCARD\n'
                                            'VERSION:3.0\n'
                                            'N:${dataMap['lastName']};${dataMap['firsName']};;${dataMap['prefix']};\n'
                                            'FN:${dataMap['firsName']} ${dataMap['lastName']}\n'
                                            'ORG:${dataMap['orgName']}\n'
                                            'TITLE:${dataMap['title']}\n'
                                            'TEL;TYPE=Work:+967${dataMap['phone']}\n'
                                            'TEL;TYPE=Work:+9675327773,${dataMap['extension']}\n'
                                            'EMAIL:${dataMap['email']}\n'
                                            'URL:${dataMap['url']}\n'
                                            'END:VCARD',
                                        version: QrVersions.auto,
                                        size: 220.0,
                                      ),
                                    ),
                                    icon: const Icon(
                                      Icons.share,
                                    ),
                                  ),
                                  const Text('مشاركة'),
                                ],
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () => (shareWidget) async {
                                      final box = context.findRenderObject()
                                          as RenderBox?;

                                      ScreenshotController()
                                          .captureFromWidget(shareWidget)
                                          .then((Uint8List bytes) async {
                                        final Directory dir =
                                            await getApplicationSupportDirectory();
                                        final String ts = DateTime.now()
                                            .millisecondsSinceEpoch
                                            .toString();

                                        final String filePath =
                                            '${dir.path}/$ts.png';
                                        await XFile.fromData(bytes)
                                            .saveTo(filePath);
                                        await Share.shareXFiles(
                                          [XFile(filePath)],
                                          sharePositionOrigin:
                                              box!.localToGlobal(Offset.zero) &
                                                  box.size,
                                        );
                                        Directory? externalStorageDirectory =
                                            await getExternalStorageDirectory();

                                        File file = File(path.join(
                                            externalStorageDirectory!.path,
                                            path.basename('fsfs')));

                                        await file
                                            .writeAsBytes(bytes)
                                            .then((value) {});
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.download,
                                    ),
                                  ),
                                  const Text('تنزيل'),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                child: const Text('Generate'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _shareScreenshot({
    required BuildContext context,
    required Widget shareWidget,
  }) async {
    final box = context.findRenderObject() as RenderBox?;

    ScreenshotController()
        .captureFromWidget(shareWidget)
        .then((Uint8List bytes) async {
      final Directory dir = await getApplicationSupportDirectory();
      final String ts = DateTime.now().millisecondsSinceEpoch.toString();

      final String filePath = '${dir.path}/$ts.png';
      await XFile.fromData(bytes).saveTo(filePath);
      await Share.shareXFiles(
        [XFile(filePath)],
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    });
  }
}
