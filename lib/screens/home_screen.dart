import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../widgets/header.dart';
import '../widgets/search_card.dart';
import '../widgets/trust_section.dart';
import '../widgets/services_section.dart';
import '../services/location_service.dart';
import '../services/supabase_service.dart';
import 'venues_screen.dart';
import 'services_screen.dart';
import 'service_detail_screen.dart';
import 'profile_screen.dart';
import 'venuedetails_screen.dart';
import 'booking_screen.dart';

// ─── Brand Colors ─────────────────────────────────────────────────────────────
const Color kMaroon = Color(0xFF610021);
const Color kRed = Color(0xFF8B0032);
const Color kGold = Color(0xFFFCC340);
const Color kCream = Color(0xFFFFF8F1);

// ─── Nav Tab Model ────────────────────────────────────────────────────────────
class _NavTab {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  const _NavTab(this.icon, this.activeIcon, this.label);
}

const _tabs = [
  _NavTab(Icons.home_outlined, Icons.home_rounded, 'Home'),
  _NavTab(Icons.location_city_outlined, Icons.location_city_rounded, 'Venues'),
  _NavTab(
    Icons.calendar_today_outlined,
    Icons.calendar_today_rounded,
    'Bookings',
  ),
  _NavTab(Icons.celebration_outlined, Icons.celebration_rounded, 'Services'),
  _NavTab(Icons.person_outline_rounded, Icons.person_rounded, 'Profile'),
];

// ─── HomeScreen ───────────────────────────────────────────────────────────────
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

  // Venues state
  List<Map<String, dynamic>> venues = [];
  bool isFromLocation = true;
  bool showVenueDetails = false;
  String selectedVenueId = '';

  // Services state
  String selectedService = '';
  bool showServiceDetails = false;

  // Loading state for venues tab
  bool _venuesLoading = false;

  // ── Screen builder ──────────────────────────────────────────────────────────
  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return _HomeTab();

      case 1:
        if (showVenueDetails) {
          return VenueDetailsScreen(
            onBack: () => setState(() => showVenueDetails = false),
          );
        }
        if (_venuesLoading) {
          return const _LoadingPlaceholder(message: 'Finding venues near you…');
        }
        return VenuesScreen(
          venues: venues,
          isFromLocation: isFromLocation,
          onSelectVenue: (id) => setState(() {
            selectedVenueId = id;
            showVenueDetails = true;
          }),
        );

      case 2:
        return const BookingsScreen();

      case 3:
        if (showServiceDetails) {
          return ServiceDetailScreen(
            serviceName: selectedService,
            onBack: () => setState(() => showServiceDetails = false),
          );
        }
        return ServicesScreen(
          onServiceClick: (service) => setState(() {
            selectedService = service;
            showServiceDetails = true;
          }),
        );

      case 4:
        return const ProfileScreen();

      default:
        return const SizedBox.shrink();
    }
  }

  // ── Tab tap handler ──────────────────────────────────────────────────────────
  Future<void> _onTabTap(int index) async {
    HapticFeedback.lightImpact();

    // Reset sub-navigation when switching away
    if (index != 1) setState(() => showVenueDetails = false);
    if (index != 3) setState(() => showServiceDetails = false);

    if (index == 1 && venues.isEmpty) {
      setState(() {
        _selectedIndex = index;
        _venuesLoading = true;
      });

      try {
        final locationService = LocationService();
        final supabaseService = SupabaseService();
        final position = await locationService.getUserLocation();
        final data = await supabaseService.getNearbyVenues(
          userLat: position.latitude,
          userLng: position.longitude,
          guests: 100,
        );
        if (!mounted) return;
        setState(() {
          venues = data;
          isFromLocation = true;
          _venuesLoading = false;
        });
      } catch (e) {
        if (!mounted) return;
        setState(() => _venuesLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Location permission needed'),
            backgroundColor: kMaroon,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
      }
    } else {
      setState(() => _selectedIndex = index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      extendBody: true, // lets content slide under the nav bar

      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 260),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.03),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
        child: KeyedSubtree(
          key: ValueKey(
            '$_selectedIndex-$showVenueDetails-$showServiceDetails',
          ),
          child: _buildScreen(_selectedIndex),
        ),
      ),

      bottomNavigationBar: _BottomNav(
        selectedIndex: _selectedIndex,
        onTap: _onTabTap,
      ),
    );
  }
}

// ─── Home Tab Content ─────────────────────────────────────────────────────────
class _HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          const SizedBox(height: 100), // bottom nav clearance
        ],
      ),
    );
  }
}

// ─── Bottom Nav ───────────────────────────────────────────────────────────────
class _BottomNav extends StatelessWidget {
  final int selectedIndex;
  final Future<void> Function(int) onTap;

  const _BottomNav({required this.selectedIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.97),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
        boxShadow: [
          BoxShadow(
            color: kMaroon.withOpacity(0.08),
            blurRadius: 24,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(
              _tabs.length,
              (i) => _NavItem(
                tab: _tabs[i],
                isActive: selectedIndex == i,
                onTap: () => onTap(i),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Nav Item ─────────────────────────────────────────────────────────────────
class _NavItem extends StatelessWidget {
  final _NavTab tab;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItem({
    required this.tab,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? kMaroon.withOpacity(0.08) : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 200),
              child: Icon(
                isActive ? tab.activeIcon : tab.icon,
                key: ValueKey(isActive),
                color: isActive ? kMaroon : Colors.grey[400],
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              tab.label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive ? kMaroon : Colors.grey[400],
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Loading Placeholder ──────────────────────────────────────────────────────
class _LoadingPlaceholder extends StatelessWidget {
  final String message;
  const _LoadingPlaceholder({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(color: kMaroon, strokeWidth: 3),
          ),
          const SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}


