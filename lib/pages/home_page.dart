// import 'package:flutter/material.dart';
// import 'package:pesosight/pages/info_page.dart';
// import 'package:camera/camera.dart';

// class HomePage extends StatefulWidget { 
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(25.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Welcome to',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 22,
//                         ),
//                       ),
//                       Text(
//                         'PesoSight',
//                         style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),

//                 GestureDetector(
//                   onTap: () {
//                   // Add functionality here
//                 Navigator.push(
//                 context,
//                   MaterialPageRoute(builder: (context) => const InfoPage()),
//                   );
//                 },
//                 child: const Icon(
//                   Icons.info,
//                   color: Colors.blue,
//                   size: 50,
//                 ),
//               ),

//               // GestureDetector(
//               //   onTap: () {
//               //     // Add functionality here
//               //   },
//               //   child: Container(
//               //     height: 55,
//               //     width: 55,
//               //     decoration: BoxDecoration(
//               //       color: Colors.blueAccent,
//               //       borderRadius: BorderRadius.circular(30.0),
//               //     ),
//               //     child: Column(
//               //       mainAxisSize: MainAxisSize.min,
//               //       mainAxisAlignment: MainAxisAlignment.center,
//               //       children: [
//               //         Icon(
//               //           Icons.groups_rounded,
//               //           color: Colors.white,
//               //           size: 35,
//               //         ),
//               //         Text(
//               //           'About Us',
//               //           style: TextStyle(
//               //             color: Colors.white,
//               //             fontSize: 9,
//               //             fontWeight: FontWeight.normal,
//               //           ),
//               //         ),
//               //       ],
//               //     ),
//               //   ),
//               // ),

                  
//                   // Container(
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.blueAccent,
//                   //     borderRadius: BorderRadius.circular(40),
//                   //   ),
//                   //   padding: const EdgeInsets.all(2),
//                   //   child: IconButton(
//                   //     onPressed: null,
//                   //     icon: Icon(
//                   //       Icons.groups_rounded,
//                   //       color: Colors.white,
//                   //     ),
//                   //     iconSize: 30,
//                   //   ),
//                   // ),
//                 ],
//               ),
//               const SizedBox(height: 50),
//               Container(
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(20.0),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.white.withOpacity(0.3),
//                       spreadRadius: 5,
//                       blurRadius: 7,
//                       offset: const Offset(0, 3),
//                     ),
//                   ],
//                 ),
//                 child: Image.asset('images/pesosightlogo.png', width: 350, height: 350),
//               ),

//               const SizedBox(height: 70),
              
//               GestureDetector(
//                 onTap: () async {
//                   // Add functionality here
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 300,
//                   decoration: BoxDecoration(
//                     color: Colors.blueAccent,
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                   child: const Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Icon(
//                         Icons.camera_alt_rounded,
//                         color: Colors.white,
//                         size: 150,
//                       ),
//                       Text(
//                         'Start Camera',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 40,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:pesosight/pages/camera_page.dart';
import 'package:pesosight/pages/info_page.dart';
import 'package:camera/camera.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<CameraDescription> cameras;

  @override
  void initState() {
    super.initState();
    initializeCamera();
  }

  Future<void> initializeCamera() async {
    cameras = await availableCameras();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome to',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                      ),
                      Text(
                        'PesoSight',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const InfoPage()),
                      );
                    },
                    child: const Icon(
                      Icons.info,
                      color: Colors.blue,
                      size: 50,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Image.asset('images/pesosightlogo.png', width: 350, height: 350),
              ),
              const SizedBox(height: 70),
              GestureDetector(
                onTap: () {
                  if (cameras.isNotEmpty) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CameraPage(cameras)),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('No camera available.'),
                      ),
                    );
                  }
                },
                child: Container(
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt_rounded,
                        color: Colors.white,
                        size: 150,
                      ),
                      Text(
                        'Start Camera',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
