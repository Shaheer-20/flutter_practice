import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

void main() {
  runApp(const FileReaderApp());
}

class FileReaderApp extends StatelessWidget {
  const FileReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Method to pick and open files based on the type
  Future<void> pickFile(String fileType) async {
    FilePickerResult? result;

    switch (fileType) {
      case 'PDF':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['pdf'],
        );
        break;
      case 'Word':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['doc', 'docx'],
        );
        break;
      case 'Excel':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['xls', 'xlsx'],
        );
        break;
      case 'CSV':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['csv'],
        );
        break;
      case 'Image':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['jpg', 'jpeg', 'png'],
        );
        break;
      case 'HTML':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['html', 'htm'],
        );
        break;
      case 'ZIP':
        result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['zip'],
        );
        break;
      default:
        result = null;
    }

    if (result != null && result.files.single.path != null) {
      File file = File(result.files.single.path!);
      if (kDebugMode) {
        print('Picked file: ${file.path}');
      }
      // Handle the picked file as needed
    } else {
      if (kDebugMode) {
        print('User canceled the picker or file path is null');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universal Document Reader'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          children: [
            buildButton(context, 'PDF', Icons.picture_as_pdf),
            buildButton(context, 'Word', Icons.description),
            buildButton(context, 'Excel', Icons.table_chart),
            buildButton(context, 'CSV', Icons.grid_on),
            buildButton(context, 'Image', Icons.image),
            buildButton(context, 'HTML', Icons.web),
            buildButton(context, 'ZIP', Icons.folder_zip),
          ],
        ),
      ),
    );
  }

  // Helper method to create buttons
  Widget buildButton(BuildContext context, String fileType, IconData icon) {
    return ElevatedButton(
      onPressed: () => pickFile(fileType),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.teal,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: const EdgeInsets.all(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40, color: Colors.white),
          const SizedBox(height: 10),
          Text(fileType, style: const TextStyle(color: Colors.white, fontSize: 16)),
        ],
      ),
    );
  }
}
