import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _AboutFadeInContent();
  }
}

class _AboutFadeInContent extends StatefulWidget {
  const _AboutFadeInContent();

  @override
  State<_AboutFadeInContent> createState() => _AboutFadeInContentState();
}

class _AboutFadeInContentState extends State<_AboutFadeInContent> {
  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final padding = EdgeInsets.symmetric(horizontal: isMobile ? 16 : 30, vertical: 60);

    return VisibilityDetector(
      key: const Key('about-page'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_visible) {
          setState(() => _visible = true);
        }
      },
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 600),
        opacity: _visible ? 1 : 0,
        curve: Curves.easeOut,
        child: SingleChildScrollView(
          child: Padding(
            padding: padding,
            child: const _AboutContent(),
          ),
        ),
      ),
    );
  }
}

class _AboutContent extends StatelessWidget {
  const _AboutContent();

  double fs(BuildContext context, double base) {
    return MediaQuery.of(context).size.width < 600 ? base - 1 : base;
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    final image = Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Image.asset(
          'assets/flower2.jpeg',
          height: isMobile ? 200 : 240,
          width: isMobile ? 200 : 240, // 👈 make it square
          fit: BoxFit.cover,
          alignment: const Alignment(0, -0.3), // 👈 shift view upward slightly
        ),
      ),
    );

    final text = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Founded right here in Central Oregon, ProClean Bend is a locally owned and operated commercial cleaning company built on reliability, trust, and results. From office buildings to Airbnb turnovers, we bring consistency and professionalism to every job.',
          style: TextStyle(fontSize: fs(context, 18)),
        ),
        const SizedBox(height: 20),
        Text(
          'We’ve been proudly serving the Central Oregon area for the last decade — never missing a scheduled cleaning and maintaining strong communication with every client along the way. Our reputation has been built on reliability, professionalism, and results our clients can count on.',
          style: TextStyle(fontSize: fs(context, 18)),
        ),
        const SizedBox(height: 20),
        Text(
          'We understand that every space is unique — that’s why we offer customizable service plans tailored to your schedule and your priorities. Whether it’s a daily office clean or a last-minute Airbnb flip, we show up with an eye for detail.',
          style: TextStyle(fontSize: fs(context, 18)),
        ),
        const SizedBox(height: 20),
        Text(
          'We’re fully licensed, bonded, and insured, and we pride ourselves on keeping communication clear and simple. Our mission is to make your space shine, so you can focus on what matters most.',
          style: TextStyle(fontSize: fs(context, 18)),
        ),
      ],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'About ProClean Bend',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: fs(context, 36),
            fontWeight: FontWeight.bold,
            color: Colors.teal[800],
          ),
        ),
        const SizedBox(height: 30),
        image,
        const SizedBox(height: 20),
        text,
        SizedBox(height: isMobile ? 30 : 60),
        ElevatedButton(
          onPressed: () => context.go('/contact'),
          child: Text(
            'Request a Quote',
            style: TextStyle(fontSize: fs(context, 16)),
          ),
        ),
      ],
    );
  }
}
