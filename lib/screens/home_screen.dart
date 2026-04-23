import 'package:flutter/material.dart';
import '../widgets/header.dart';
import '../widgets/search_card.dart';
import '../widgets/trust_section.dart';
import '../widgets/services_section.dart';
import '../services/location_service.dart';
import '../services/supabase_service.dart';
import 'venues_screen.dart';
import 'services_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> venues = [];

  // 📌 Screens list
  List<Widget> get _screens => [
    // 🏠 HOME
    SingleChildScrollView(
      child: Column(
        children: [
          const Header(),
          Transform.translate(
            offset: const Offset(0, -40),
            child: const SearchCard(),
          ),
          const SizedBox(height: 10),
          const TrustSection(),
          const SizedBox(height: 10),
          const ServicesSection(),
        ],
      ),
    ),

    // 📍 VENUES
    VenuesScreen(venues: venues),

    // 📖 BOOKINGS (placeholder)
    const Center(child: Text("Bookings coming soon")),

    // 🛠 SERVICES
    const ServicesScreen(),

    // 👤 PROFILE
    const Center(child: Text("Profile coming soon")),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),

      // 🔥 CHANGE HERE
      body: _screens[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.grey,

        onTap: (index) async {
          setState(() {
            _selectedIndex = index;
          });

          // 📍 Fetch venues when clicking venues tab
          if (index == 1) {
            final locationService = LocationService();
            final supabaseService = SupabaseService();

            try {
              final position = await locationService.getUserLocation();

              final data = await supabaseService.getNearbyVenues(
                userLat: position.latitude,
                userLng: position.longitude,
                guests: 100,
              );

              setState(() {
                venues = data;
              });
            } catch (e) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Location permission needed"),
                ),
              );
            }
          }
        },

        items: const [
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