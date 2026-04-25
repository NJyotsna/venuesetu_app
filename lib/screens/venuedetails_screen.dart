import 'package:flutter/material.dart';

// ─── Brand Colors ─────────────────────────────────────────────────────────────
const Color kMaroon = Color(0xFF610021);
const Color kRed = Color(0xFF8B0032);
const Color kGold = Color(0xFFFCC340);
const Color kCream = Color(0xFFFFF8F1);
const Color kOnSurface = Color(0xFF1E1B17);

// ─── Data ─────────────────────────────────────────────────────────────────────
class _Amenity {
  final IconData icon;
  final String label;
  const _Amenity(this.icon, this.label);
}

const _amenities = [
  _Amenity(Icons.wifi_rounded, 'High-Speed WiFi'),
  _Amenity(Icons.ac_unit_rounded, 'Central AC'),
  _Amenity(Icons.directions_car_rounded, 'Valet Parking'),
  _Amenity(Icons.restaurant_rounded, 'In-house Catering'),
  _Amenity(Icons.auto_awesome_rounded, 'Bridal Suite'),
];

class _Review {
  final String name;
  final String avatar;
  final Color color;
  final String text;
  const _Review(this.name, this.avatar, this.color, this.text);
}

const _reviews = [
  _Review(
    'Ananya S.',
    'A',
    kGold,
    'Absolutely breathtaking venue. The attention to detail in the decor was unmatched. Truly a royal affair.',
  ),
  _Review(
    'Rahul V.',
    'R',
    kMaroon,
    'Great location and excellent catering. Highly recommended for evening receptions.',
  ),
];

// ─── VenueDetails Screen ──────────────────────────────────────────────────────
class VenueDetailsScreen extends StatefulWidget {
  final VoidCallback onBack;
  const VenueDetailsScreen({super.key, required this.onBack});

  @override
  State<VenueDetailsScreen> createState() => _VenueDetailsScreenState();
}

class _VenueDetailsScreenState extends State<VenueDetailsScreen> {
  int _selectedPackage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kCream,
      body: SafeArea(
        child: Column(
          children: [
            _TopBar(onBack: widget.onBack),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _Gallery(),
                    const SizedBox(height: 28),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _TitleRow(),
                          const SizedBox(height: 32),
                          const _SectionTitle('About the Venue'),
                          const SizedBox(height: 12),
                          _AboutText(),
                          const SizedBox(height: 32),
                          const _SectionTitle('Amenities'),
                          const SizedBox(height: 16),
                          _AmenitiesWrap(),
                          const SizedBox(height: 32),
                          _ReviewsSection(),
                          const SizedBox(height: 32),
                          _BookingCard(
                            selectedPackage: _selectedPackage,
                            onPackageChanged: (v) =>
                                setState(() => _selectedPackage = v),
                          ),
                          const SizedBox(height: 16),
                          const _NeedHelpCard(),
                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Top Bar ──────────────────────────────────────────────────────────────────
class _TopBar extends StatelessWidget {
  final VoidCallback onBack;
  const _TopBar({required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: kCream.withOpacity(0.95),
        border: Border(bottom: BorderSide(color: kMaroon.withOpacity(0.06))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onBack,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: kMaroon,
              size: 24,
            ),
            splashRadius: 22,
          ),
          const Text(
            'VenueSetu',
            style: TextStyle(
              fontStyle: FontStyle.italic,
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: kMaroon,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.share_rounded, color: kMaroon, size: 22),
            splashRadius: 22,
          ),
        ],
      ),
    );
  }
}

// ─── Gallery ──────────────────────────────────────────────────────────────────
class _Gallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1519741497674-611481863552?w=1200',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(color: Colors.grey[200]),
          ),
          // Gradient overlay
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.28)],
                ),
              ),
            ),
          ),
          // +12 Photos badge
          Positioned(
            bottom: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Row(
                children: [
                  Icon(
                    Icons.photo_library_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  SizedBox(width: 6),
                  Text(
                    '+12 Photos',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Title Row ────────────────────────────────────────────────────────────────
class _TitleRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Expanded(
              child: Text(
                'The Grand Palace',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: kMaroon,
                  height: 1.1,
                ),
              ),
            ),
            const SizedBox(width: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: kGold,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                    color: kGold.withOpacity(0.4),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: const Row(
                children: [
                  Icon(Icons.star_rounded, size: 14, color: kMaroon),
                  SizedBox(width: 4),
                  Text(
                    '4.9',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                      color: kMaroon,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            const Icon(Icons.location_on_rounded, size: 18, color: kMaroon),
            const SizedBox(width: 6),
            Text(
              'Heritage Block, Royal Enclave, Jaipur',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}

// ─── Section Title ────────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        color: kMaroon,
      ),
    );
  }
}

// ─── About Text ───────────────────────────────────────────────────────────────
class _AboutText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Experience the epitome of ethnic luxury at The Grand Palace. This heritage property blends '
      'traditional Rajputana architecture with modern world-class amenities. Perfect for grand '
      'weddings, exclusive corporate retreats, and milestone celebrations, our venue offers an '
      'unforgettable ambiance bathed in warm lighting, rich maroon accents, and golden detailing.',
      style: TextStyle(fontSize: 15, color: Colors.grey[600], height: 1.7),
    );
  }
}

// ─── Amenities Wrap ───────────────────────────────────────────────────────────
class _AmenitiesWrap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: _amenities
          .map(
            (a) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: kMaroon.withOpacity(0.08)),
                boxShadow: [
                  BoxShadow(
                    color: kMaroon.withOpacity(0.04),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(a.icon, size: 18, color: kMaroon),
                  const SizedBox(width: 8),
                  Text(
                    a.label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}

// ─── Reviews Section ──────────────────────────────────────────────────────────
class _ReviewsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const _SectionTitle('Guest Reviews'),
            GestureDetector(
              onTap: () {},
              child: const Text(
                'See all 124 reviews',
                style: TextStyle(
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  color: kMaroon,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        ..._reviews.map(
          (r) => Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _ReviewCard(review: r),
          ),
        ),
      ],
    );
  }
}

class _ReviewCard extends StatelessWidget {
  final _Review review;
  const _ReviewCard({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: kMaroon.withOpacity(0.05)),
        boxShadow: [
          BoxShadow(
            color: kMaroon.withOpacity(0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: review.color,
                ),
                child: Center(
                  child: Text(
                    review.avatar,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: Color(0xFF2D2D2D),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: List.generate(
                      5,
                      (_) => const Icon(
                        Icons.star_rounded,
                        size: 13,
                        color: kGold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(
            '"${review.text}"',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Booking Card ─────────────────────────────────────────────────────────────
class _BookingCard extends StatelessWidget {
  final int selectedPackage;
  final ValueChanged<int> onPackageChanged;

  const _BookingCard({
    required this.selectedPackage,
    required this.onPackageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: kMaroon.withOpacity(0.06)),
        boxShadow: [
          BoxShadow(
            color: kMaroon.withOpacity(0.10),
            blurRadius: 40,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Price
          Text(
            'STARTING FROM',
            style: TextStyle(
              fontSize: 10,
              letterSpacing: 1.8,
              fontWeight: FontWeight.w900,
              color: kGold.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 4),
          RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: '₹2,50,000',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    color: kMaroon,
                  ),
                ),
                TextSpan(
                  text: ' / day',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          const Text(
            'Available Packages',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: Color(0xFF2D2D2D),
            ),
          ),
          const SizedBox(height: 12),

          _PackageOption(
            selected: selectedPackage == 0,
            title: 'Gold Package',
            desc: 'Venue + Basic Decor + Standard Catering (up to 200 pax)',
            onTap: () => onPackageChanged(0),
          ),
          const SizedBox(height: 10),
          _PackageOption(
            selected: selectedPackage == 1,
            title: 'Platinum Package',
            desc: 'Venue + Premium Decor + Elite Catering + Photography',
            onTap: () => onPackageChanged(1),
          ),

          const SizedBox(height: 24),

          // Book Now
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: kMaroon,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
                elevation: 6,
                shadowColor: kMaroon.withOpacity(0.30),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Book Now',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward_rounded, size: 20),
                ],
              ),
            ),
          ),

          const SizedBox(height: 10),
          Center(
            child: Text(
              "You won't be charged yet",
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[400],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Package Option ───────────────────────────────────────────────────────────
class _PackageOption extends StatelessWidget {
  final bool selected;
  final String title;
  final String desc;
  final VoidCallback onTap;

  const _PackageOption({
    required this.selected,
    required this.title,
    required this.desc,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: selected ? kMaroon.withOpacity(0.05) : Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: selected ? kMaroon : kMaroon.withOpacity(0.10),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Custom radio
            Container(
              margin: const EdgeInsets.only(top: 2),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? kMaroon : Colors.grey[400]!,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kMaroon,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                      color: selected ? kMaroon : const Color(0xFF2D2D2D),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Need Help Card ───────────────────────────────────────────────────────────
class _NeedHelpCard extends StatefulWidget {
  const _NeedHelpCard();

  @override
  State<_NeedHelpCard> createState() => _NeedHelpCardState();
}

class _NeedHelpCardState extends State<_NeedHelpCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _pressed
              ? kMaroon.withOpacity(0.10)
              : kMaroon.withOpacity(0.05),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: kMaroon.withOpacity(0.10)),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: kGold.withOpacity(0.12),
                border: Border.all(color: kGold.withOpacity(0.25)),
              ),
              child: const Icon(
                Icons.headset_mic_rounded,
                color: kMaroon,
                size: 26,
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Need Help?',
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                    color: kMaroon,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Talk to our event specialist',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
