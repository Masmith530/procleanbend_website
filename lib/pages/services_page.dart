import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:go_router/go_router.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                Text(
                  'What We Do',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal[800],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Reliable commercial cleaning tailored to your needs. Always thorough. Always professional.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),

          const ServiceSection(
            title: 'Full-Service Cleaning',
            description:
                'We provide reliable, detail-focused cleaning tailored to your workspace. Every new client starts with a walkthrough to create a personalized plan and schedule. With consistent communication and flexible hours, your space always leaves a great impression.',
            bulletPoints: [
              'Custom daily, weekly, or monthly plans',
              'Workstations, lobbies, and kitchens cleaned',
              'Glass, handles, and touchpoints sanitized',
              'Trash removal with fresh liners',
              'Floors vacuumed and mopped',
              'Desks, shelves, and baseboards dusted',
              'Restroom cleaning and restocking',
            ],
            imagePath: 'assets/coffman.jpg',
            imageLeft: true,
          ),

          const ServiceSection(
            title: 'Deep Cleaning Service',
            description:
                'When your space needs more than just the routine, our deep cleaning service delivers. Ideal for seasonal resets, post-event cleanups, or periodic refreshes, we target areas that benefit from a more thorough approach.',
            bulletPoints: [
              'Detailed baseboard and trim cleaning',
              'Vents, behind furniture, and under desks',
              'Window sill and partition spot-cleaning',
              'Dusting light fixtures and ceiling corners',
              'Extra grime and buildup removal (sinks, tiles, edges)',
              'Recommended quarterly or monthly for high-use spaces',
            ],
            imagePath: 'assets/nwlobby.jpg',
            imageLeft: false,
            backgroundColor: Color(0xFFF8F9FA),
          ),

          const ServiceSection(
            title: 'Custom Cleaning Requests',
            description:
                'Have something unique in mind? We’re happy to tailor our services to match your business or property’s specific needs, whether it’s a one-time special job or recurring extras.',
            bulletPoints: [
              'Additional tasks during scheduled cleanings',
              'One-time cleaning requests',
              'Special support for unique spaces',
              'Flexible solutions beyond routine service',
            ],
            imagePath: 'assets/medchair.jpg',
            imageLeft: true,
          ),

          const ServiceSection(
            title: 'Vacation Rental Turnover Cleaning',
            description:
                'Airbnb and short-term rental cleanings between guests — done fast, thoroughly, and ready for 5-star reviews.',
            bulletPoints: [
              'Complete surface, floor, and bathroom cleaning',
              'Bed resets with fresh linens (laundry optional if arranged)',
              'Trash removal, restocking, and supply checklists (if provided)',
              'Flexible accommodations for guest-specific needs or requests',
            ],
            imagePath: 'assets/bed.jpg',
            imageLeft: false,
            backgroundColor: Color(0xFFF8F9FA),
          ),

          const SizedBox(height: 60),

          Center(
            child: ElevatedButton(
              onPressed: () => context.go('/contact'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
              child: const Text('Request a Quote', style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}

class ServiceSection extends StatefulWidget {
  final String title;
  final String description;
  final List<String> bulletPoints;
  final String imagePath;
  final bool imageLeft;
  final Color? backgroundColor;

  const ServiceSection({
    super.key,
    required this.title,
    required this.description,
    required this.bulletPoints,
    required this.imagePath,
    this.imageLeft = true,
    this.backgroundColor,
  });

  @override
  State<ServiceSection> createState() => _ServiceSectionState();
}

class _ServiceSectionState extends State<ServiceSection> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final isWide = width > 700;

    final image = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset(
        widget.imagePath,
        width: double.infinity,
        height: isWide ? 450 : 220,
        fit: BoxFit.cover,
      ),
    );

    final text = Padding(
      padding: EdgeInsets.symmetric(horizontal: isWide ? 20 : 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.teal[800],
            ),
          ),
          const SizedBox(height: 12),
          Text(widget.description, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 12),
          ...widget.bulletPoints.map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• ', style: TextStyle(fontSize: 16)),
                  Expanded(child: Text(point, style: const TextStyle(fontSize: 16))),
                ],
              ),
            ),
          ),
        ],
      ),
    );

    final sectionContent = AnimatedOpacity(
      duration: const Duration(milliseconds: 600),
      opacity: _visible ? 1.0 : 0.0,
      curve: Curves.easeOut,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40),
        child: isWide
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.imageLeft ? [Flexible(flex: 1, child: image), Flexible(flex: 2, child: text)] : [Flexible(flex: 2, child: text), Flexible(flex: 1, child: image)],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  image,
                  const SizedBox(height: 20),
                  text,
                ],
              ),
      ),
    );

    return VisibilityDetector(
      key: Key(widget.title),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.2 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: widget.backgroundColor == null
          ? sectionContent
          : Container(
              color: widget.backgroundColor,
              width: double.infinity,
              child: sectionContent,
            ),
    );
  }
}
