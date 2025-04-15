import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';

// Import page content
import 'pages/home_page.dart';
import 'pages/services_page.dart';
import 'pages/about_page.dart';
import 'pages/contact_page.dart';

void main() {
  runApp(const CleaningWebsite());
}

// Custom brand colors
const Color blushPink = Color(0xFFF9D6D4);
const Color tealAccent = Color(0xFF4CA6A8);
const Color darkTeal = Color(0xFF2C6A6A);

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const AppShell(child: HomePage()),
    ),
    GoRoute(
      path: '/services',
      builder: (context, state) => const AppShell(child: ServicesPage()),
    ),
    GoRoute(
      path: '/about',
      builder: (context, state) => const AppShell(child: AboutPage()),
    ),
    GoRoute(
      path: '/contact',
      builder: (context, state) => const AppShell(child: ContactPage()),
    ),
  ],
);

class CleaningWebsite extends StatelessWidget {
  const CleaningWebsite({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        primaryColor: tealAccent,
        textTheme: GoogleFonts.openSansTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: tealAccent,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: tealAccent, width: 2),
            borderRadius: BorderRadius.circular(8),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          labelStyle: const TextStyle(color: darkTeal),
          floatingLabelStyle: const TextStyle(color: tealAccent),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.black, // ✅ this is the correct place for cursor color
          selectionColor: Color(0xFFB2DFDB), // optional: light teal selection
          selectionHandleColor: tealAccent, // optional: teal selection handle
        ),
      ),
    );
  }
}

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 700;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 2,
            titleSpacing: 16,
            automaticallyImplyLeading: false, // ❌ disables default hamburger
            title: Container(
              height: kToolbarHeight, // Ensures full AppBar height
              alignment: Alignment.centerLeft,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/logo.png',
                    height: 60,
                    filterQuality: FilterQuality.high,
                  ),
                  const SizedBox(width: 12),
                  Padding(
                    padding: const EdgeInsets.only(top: 2), // small nudge if needed
                    child: Text(
                      'ProClean Bend',
                      style: GoogleFonts.greatVibes(
                        textStyle: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          color: darkTeal,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: isMobile
                ? [
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: darkTeal),
                        onPressed: () => Scaffold.of(context).openEndDrawer(),
                      ),
                    ),
                  ]
                : [
                    NavButton(label: 'Home', onTap: () => context.go('/')),
                    NavButton(label: 'Services', onTap: () => context.go('/services')),
                    NavButton(label: 'About Us', onTap: () => context.go('/about')),
                    NavButton(label: 'Contact', onTap: () => context.go('/contact')),
                    const SizedBox(width: 16),
                  ],
          ),
          endDrawer: isMobile
            ? SizedBox(
                width: MediaQuery.of(context).size.width * 0.65, // ~65% of screen width
                child: Drawer(
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Container(
                        color: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'ProClean Bend',
                            style: GoogleFonts.greatVibes(
                              textStyle: const TextStyle(fontSize: 28, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        title: const Text('Home'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/');
                        },
                      ),
                      ListTile(
                        title: const Text('Services'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/services');
                        },
                      ),
                      ListTile(
                        title: const Text('About Us'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/about');
                        },
                      ),
                      ListTile(
                        title: const Text('Contact'),
                        onTap: () {
                          Navigator.pop(context);
                          context.go('/contact');
                        },
                      ),
                    ],
                  ),
                ),
              )
            : null,
          body: child,
        );
      },
    );
  }
}

class NavButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const NavButton({super.key, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        label,
        style: const TextStyle(
          color: darkTeal,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
