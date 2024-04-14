// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';

// class CameraPage extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const CameraPage(this.cameras);

//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {
//   late CameraController _controller;
//   int selectedCameraIdx = 0;

//   @override
//   void initState() {
//     super.initState();
//     _initCameraController();
//   }

//   void _initCameraController() async {
//     _controller = CameraController(
//       widget.cameras[selectedCameraIdx],
//       ResolutionPreset.medium,
//     );
//     await _controller.initialize();
//     if (mounted) {
//       setState(() {});
//     }
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     if (!_controller.value.isInitialized) {
//       return Container();
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Camera'),
//       ),
//       body: CameraPreview(_controller),
//       // floatingActionButton: FloatingActionButton(
//       //   onPressed: () {
//       //     // Add functionality to capture image or start/stop video recording
//       //   },
//       //   child: const Icon(Icons.camera),
//       // ),
//       // floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }

import 'dart:ui';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tflite/tflite.dart';

class CameraPage extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraPage(this.cameras);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  late CameraController _controller;
  late List<dynamic> _recognitions = [];
  bool _inferenceBusy = false; // Track inference status
  final int _inferenceCooldownMs = 100;

  @override
  void initState() {
    super.initState();
    _initCameraController();
    _loadModel();
  }

  void _initCameraController() async {
    _controller = CameraController(
      widget.cameras[0],
      ResolutionPreset.medium,
    );
    await _controller.initialize();
    if (mounted) {
      setState(() {});
    }
    _controller.startImageStream(_processCameraImage);
  }

  Future<void> _loadModel() async {
    String? res = await Tflite.loadModel(
      model: 'assets/detect.tflite',
      labels: 'assets/labelmap.txt',
    );
    print('Model loaded: $res');
  }

    void _processCameraImage(CameraImage image) async {
    if (_inferenceBusy) {
      return; // Skip inference if it's busy
    }
    _inferenceBusy = true;

    List<dynamic>? recognitions = await Tflite.runModelOnFrame(
      bytesList: image.planes.map((plane) => plane.bytes).toList(),
      imageHeight: image.height,
      imageWidth: image.width,
      numResults: 10,
    );

    if (mounted) {
      setState(() {
        _recognitions = recognitions ?? [];
        _inferenceBusy = false;
      });
    }

    // Throttle inference requests
    await Future.delayed(Duration(milliseconds: _inferenceCooldownMs));
  }

  @override
  void dispose() {
    _controller.stopImageStream();
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
      body: Stack(
        children: [
          CameraPreview(_controller),
          _buildResultsWidget(Size(_controller.value.previewSize!.width, _controller.value.previewSize!.height)),
        ],
      ),
    );
  }

  Widget _buildResultsWidget(Size imageSize) {
    if (_recognitions == null || _recognitions.isEmpty) {
      return Container();
    }
    return CustomPaint(
      painter: BoundingBoxPainter(imageSize, _recognitions),
    );
  }
}

class BoundingBoxPainter extends CustomPainter {
  final Size imageSize;
  final List<dynamic> recognitions;

  BoundingBoxPainter(this.imageSize, this.recognitions);

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / imageSize.width;
    final double scaleY = size.height / imageSize.height;

    for (dynamic recognition in recognitions) {
      final int classId = recognition['index'];
      final double confidence = recognition['confidence'];
      final Rect boundingBox = Rect.fromLTRB(
        recognition['rect']['x'] * scaleX,
        recognition['rect']['y'] * scaleY,
        recognition['rect']['w'] * scaleX,
        recognition['rect']['h'] * scaleY,
      );

      final Paint paint = Paint()
        ..color = Colors.red
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0;

      canvas.drawRect(boundingBox, paint);

      // Draw text indicating class and confidence
      TextSpan span = TextSpan(
        text: 'Class: $classId\nConfidence: ${confidence.toStringAsFixed(2)}',
        style: TextStyle(color: Colors.white, fontSize: 16.0),
      );
      TextPainter tp = TextPainter(
        text: span,
        textAlign: TextAlign.left,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(boundingBox.left + 5, boundingBox.top - tp.height - 5));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}