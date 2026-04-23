import 'package:flutter/material.dart';

class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  final List<Map<String, String>> services = const [
    {
      "title": "Photography",
      "subtitle": "Professional wedding & event photography",
      "image": "assets/services/photography.png",
    },
    {
      "title": "Videography",
      "subtitle": "Cinematic event videography",
      "image": "assets/services/videography.png",
    },
    {
      "title": "Catering",
      "subtitle": "Veg & Non-Veg menu options",
      "image": "assets/services/catering.png",
    },
    {
      "title": "Decoration",
      "subtitle": "Flower & theme decorations",
      "image": "assets/services/decoration.png",
    },
    {
      "title": "DJ & Sound",
      "subtitle": "Music, DJ & sound system",
      "image": "assets/services/dj.png",
    },
    {
      "title": "Lighting",
      "subtitle": "Event lighting setup",
      "image": "assets/services/lighting.png",
    },
    {
      "title": "Event Planning",
      "subtitle": "Complete event management",
      "image": "assets/services/planning.png",
    },
    {
      "title": "Entertainment",
      "subtitle": "Anchors, performers & shows",
      "image": "assets/services/entertainment.png",
    },
    {
      "title": "Makeup Artists",
      "subtitle": "Bridal & event makeup services",
      "image": "assets/services/makeup.png",
    },
    {
      "title": "Invitation Design",
      "subtitle": "Digital & printed invitations",
      "image": "assets/services/invitation.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5EFE6),

      appBar: AppBar(
        title: const Text("Additional Services"),
        backgroundColor: const Color(0xFF7B001C),
      ),

      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: services.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final service = services[index];

          return Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                )
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  service["image"]!,
                  height: 60,
                ),

                const SizedBox(height: 10),

                Text(
                  service["title"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  service["subtitle"]!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}