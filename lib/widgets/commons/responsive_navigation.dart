
// widgets/common/responsive_navigation.dart
import 'package:flutter/material.dart';
import '../../utils/responsive_breakpoints.dart';
import '../../utils/route_generator.dart';
import '../../screens/home_screen.dart';
import '../../screens/post_detail_screen.dart';
import '../../screens/user_profile_screen.dart';

class ResponsiveNavigation extends StatefulWidget {
  final int initialIndex;

  const ResponsiveNavigation({Key? key, this.initialIndex = 0}) : super(key: key);

  @override
  _ResponsiveNavigationState createState() => _ResponsiveNavigationState();
}

class _ResponsiveNavigationState extends State<ResponsiveNavigation> {
  int selectedIndex = 0;

  final List<AppDestination> appDestinations = [
    AppDestination(
      label: 'Home',
      icon: Icons.home_outlined,
      selectedIcon: Icons.home,
      page: HomeScreen(),
    ),
    AppDestination(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      page: UserScreen(),
    ),
  ];

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    if (ResponsiveBreakpoints.isDesktop(context)) {
      return _buildDesktopLayout();
    } else if (ResponsiveBreakpoints.isTablet(context)) {
      return _buildTabletLayout();
    } else {
      return _buildMobileLayout();
    }
  }

  Widget _buildDesktopLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            extended: true,
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: appDestinations.map(_buildRailDestination).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _buildNestedNavigator()),
        ],
      ),
    );
  }

  Widget _buildTabletLayout() {
    return Scaffold(
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: selectedIndex,
            onDestinationSelected: _onDestinationSelected,
            destinations: appDestinations.map(_buildRailDestination).toList(),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: _buildNestedNavigator()),
        ],
      ),
    );
  }

  Widget _buildMobileLayout() {
    return Scaffold(
      body: _buildNestedNavigator(),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: _onDestinationSelected,
        destinations: appDestinations.map(_buildBottomDestination).toList(),
      ),
    );
  }

  NavigationRailDestination _buildRailDestination(AppDestination dest) {
    return NavigationRailDestination(
      icon: Icon(dest.icon),
      selectedIcon: Icon(dest.selectedIcon),
      label: Text(dest.label),
    );
  }

  NavigationDestination _buildBottomDestination(AppDestination dest) {
    return NavigationDestination(
      icon: Icon(dest.icon),
      selectedIcon: Icon(dest.selectedIcon),
      label: dest.label,
    );
  }

  void _onDestinationSelected(int index) {
    if (index != selectedIndex) {
      setState(() {
        selectedIndex = index;
      });
     
    }
  }

  String _routeForIndex(int index) {
    switch (index) {
      case 1:
        return RouteGenerator.home;
      case 2:
        return RouteGenerator.postdetail;
      case 3:
        return RouteGenerator.profile;
      case 0:
      default:
        return RouteGenerator.initial;
    }
  }

  Widget _buildNestedNavigator() {
    return Navigator(
      key: ValueKey<int>(selectedIndex), // keep state per tab
      onGenerateRoute: (RouteSettings settings) {
        // Return the page matching selectedIndex
        return MaterialPageRoute(
          builder: (context) => appDestinations[selectedIndex].page,
        );
      },
    );
  }
}

/// Custom data class – renamed to avoid conflict with Flutter's NavigationDestination
class AppDestination {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget page;

  const AppDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.page,
  });
}
