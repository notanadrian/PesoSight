import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage(this.cameras);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  int selectedCameraIdx = 0;

  @override
  void initState() {
    super.initState();
    _initCameraController();
  }

  void _initCameraController() async {
    _controller = CameraController(
      widget.cameras[selectedCameraIdx],
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Camera'),
      ),
      body: CameraPreview(_controller),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add functionality to capture image or start/stop video recording
        },
        child: const Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
