import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 700;
          final horizontalPadding = isMobile ? 16.0 : 30.0;

          double fs(double desktopSize) => isMobile ? desktopSize - 2 : desktopSize;

          return Column(
            children: [
              // Hero Section
              Stack(
                children: [
                  SizedBox(
                    height: 400,
                    width: double.infinity,
                    child: Image.asset(
                      'assets/office1.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 400,
                    width: double.infinity,
                    color: const Color.fromRGBO(158, 158, 158, 0.4),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'First Impressions Start With a Clean Space',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fs(42),
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 8, color: Colors.black54)],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Reliable commercial cleaning tailored to your space.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: fs(20),
                            color: Colors.white,
                            shadows: [Shadow(blurRadius: 6, color: Colors.black38)],
                          ),
                        ),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () => context.go('/contact'),
                          child: const Text('Request a Quote'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // Services Preview
              Padding(
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: horizontalPadding),
                child: Column(
                  children: [
                    Text(
                      'Commercial Cleaning Services',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fs(36),
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Proudly serving Central Oregon',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fs(16),
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                      spacing: 30,
                      runSpacing: 30,
                      alignment: WrapAlignment.center,
                      children: const [
                        ServiceCard(title: 'Full-Service Cleaning', icon: Icons.cleaning_services),
                        ServiceCard(title: 'Deep Cleaning', icon: Icons.sanitizer),
                        ServiceCard(title: 'Custom Requests', icon: Icons.edit_note),
                        ServiceCard(title: 'Vacation Turnover', icon: Icons.bed),
                      ],
                    ),
                  ],
                ),
              ),

              // Why Choose Us
              Container(
                color: Colors.grey.shade100,
                padding: EdgeInsets.symmetric(vertical: 60, horizontal: horizontalPadding),
                child: Column(
                  children: [
                    Text(
                      'Why Choose Us',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fs(32),
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Wrap(
                      spacing: 30,
                      runSpacing: 20,
                      alignment: WrapAlignment.center,
                      children: const [
                        FeatureCard(text: 'Locally owned & operated'),
                        FeatureCard(text: 'Licensed, bonded & insured'),
                        FeatureCard(text: 'Satisfaction guaranteed'),
                        FeatureCard(text: 'Flexible scheduling'),
                      ],
                    ),
                  ],
                ),
              ),

              // Testimonial Section
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: horizontalPadding),
                child: Column(
                  children: [
                    Text(
                      'What Our Clients Say',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fs(28),
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                      ),
                      child: Text(
                        '“We’ve used ProClean Bend for several years now — they’re consistent, detail-oriented, and always communicate if anything comes up. Highly recommend.”\n— Taylor, Office Manager, Bend OR',
                        style: TextStyle(
                          fontSize: fs(16),
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

              // Final CTA
              Padding(
                padding: EdgeInsets.symmetric(vertical: 40, horizontal: horizontalPadding),
                child: Column(
                  children: [
                    Text(
                      'Ready for a cleaner space?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: fs(28),
                        fontWeight: FontWeight.bold,
                        color: Colors.teal[800],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => context.go('/contact'),
                      child: const Text('Get Your Free Quote'),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  const ServiceCard({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: Card(
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Icon(icon, size: 48, color: Colors.teal[700]),
              const SizedBox(height: 16),
              Text(title, style: const TextStyle(fontSize: 18)),
            ],
          ),
        ),
      ),
    );
  }
}

class FeatureCard extends StatelessWidget {
  final String text;
  const FeatureCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal.shade300),
        color: Colors.white,
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16),
      ),
    );
  }
}
