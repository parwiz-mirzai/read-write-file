import 'package:flutter/material.dart';
import 'package:read_and_write_file/file_servicce.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Read/Write App',
      home: FileReadWriteScreen(),
    );
  }
}

class FileReadWriteScreen extends StatefulWidget {
  @override
  _FileReadWriteScreenState createState() => _FileReadWriteScreenState();
}

class _FileReadWriteScreenState extends State<FileReadWriteScreen> {
  final FileService _fileService = FileService();
  final TextEditingController _controller = TextEditingController();
  String _savedText = '';

  void _writeToFile() async {
    await _fileService.writeFile(_controller.text);
    setState(() {
      _savedText = _controller.text;
    });
    _controller.clear();
  }

  void _readFromFile() async {
    String contents = await _fileService.readFile();
    setState(() {
      _controller.text += contents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text('File Read/Write'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter text to save',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _writeToFile,
              child: Text('Save to File'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _readFromFile,
              child: Text('Read from File'),
            ),
            SizedBox(height: 20),
            Text(
              'Saved Text:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              _savedText,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
