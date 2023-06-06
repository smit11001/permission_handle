import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Permission Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  void _showAlertDialog(BuildContext context, Permission permission) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(permission.toString()),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ElevatedButton(
                onPressed: () async {
                  PermissionStatus status = await permission.status;
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Status: $status'),
                    ),
                  );
                },
                child: Text('Check Permission Status'),
              ),
              ElevatedButton(
                onPressed: () async {
                  PermissionStatus status = await permission.request();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Status: $status'),
                    ),
                  );
                },
                child: Text('Request Permission'),
              ),
              ElevatedButton(
                onPressed: () {
                  openAppSettings();
                },
                child: Text('Open App Settings'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _showAlertDialog(context, Permission.location);
              },
              child: Text('Location Permission'),
            ),
            ElevatedButton(
              onPressed: () {
                _showAlertDialog(context, Permission.camera);
              },
              child: Text('Camera Permission'),
            ),
            ElevatedButton(
              onPressed: () {
                _showAlertDialog(context, Permission.microphone);
              },
              child: Text('Microphone Permission'),
            ),
          ],
        ),
      ),
    );
  }
}
