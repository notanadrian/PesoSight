import 'package:flutter/material.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                  // Add functionality here
                Navigator.pop(context);
                },
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: Colors.blue,
                  size: 50,
                ),
              ),

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

              Container(
                width: 400,
                height: 250,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('About PesoSight',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text('PesoSight is a mobile application specifically designed to address the challenges faced by the visually impaired in handling Philippine currency. The application is intended to offer a user-friendly solution, allowing visually impaired users to easily recognize and calculate the total value of their currency with the use of smartphones.',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.normal,
                      ),
                    )
                  ],
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}