import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// 🔵 MAIN APP
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

Widget trustItem(IconData icon, String text) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFF5E6D3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.brown, size: 20),
      ),
      SizedBox(height: 6),
      SizedBox(
        width: 75,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 11),
        ),
      )
    ],
  );
}

Widget serviceItem(IconData icon, String text) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Color(0xFFF5E6D3),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.brown),
      ),
      SizedBox(height: 5),
      Text(
        text,
        style: TextStyle(fontSize: 11),
      )
    ],
  );
}

// 🏠 HOME SCREEN
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFDF6F0),

      body: SingleChildScrollView(
        child: Column(
          children: [

            // 🔴 HEADER SECTION
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
              decoration: BoxDecoration(
                color: Color(0xFF800020),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "VenueSetu",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Find. Check Availability. Book Instantly.",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(height: 20),

                  // 🧾 FORM CARD
                  Container(
                    padding: EdgeInsets.all(15),
                    margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        )
                      ],
                    ),
                    child: Column(
                      children: [

                        // 📍 LOCATION
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_on),
                            hintText: "Mumbai, Delhi, Bangalore...",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        // 📅 DATE
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.calendar_today),
                            hintText: "Select date",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),

                        // 👥 GUESTS
                        TextField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.people),
                            hintText: "Number of guests",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 15),

                        // 🟡 BUTTON
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD4AF37),
                              padding: EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25),
                              ),
                            ),
                            child: Text(
                              "Check Live Availability",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 20),

// 🔐 TRUST SECTION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Trust & Emotion Section",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      trustItem(Icons.verified, "Verified Venues"),
                      trustItem(Icons.currency_rupee, "Transparent Pricing"),
                      trustItem(Icons.block, "No Broker"),
                      trustItem(Icons.family_restroom, "Family Friendly"),
                    ],
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    "Services",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      serviceItem(Icons.home, "Venues"),
                      serviceItem(Icons.restaurant, "Catering"),
                      serviceItem(Icons.brush, "Decoration"),
                      serviceItem(Icons.camera_alt, "Photography"),
                      serviceItem(Icons.event, "Planning"),
                    ],
                  ),
                ],
              ),
            ),

          ],
        ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Color(0xFF800020),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: "Venues",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: "Bookings",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.miscellaneous_services),
            label: "Services",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}