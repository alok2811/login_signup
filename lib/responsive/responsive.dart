import 'package:flutter/widgets.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget tablet;
  final Widget desktop;
  
  const ResponsiveWidget({Key? key,
    required this.mobile,
    required this.tablet,
    required this.desktop,
  }) : super(key: key);


  // This isMobile, isTablet, isDesktop helep us later
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 650;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width < 1100 &&
          MediaQuery.of(context).size.width >= 650;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1100;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints){
      if (constraints.maxWidth >= 1100) {
        return desktop;
      }
      // If width it less then 1100 and more then 650 we consider it as tablet
      else if (constraints.maxWidth >= 650) {
        return tablet;
      }
      // Or less then that we called it mobile
      else {
        return mobile;
      }
    });
  }
}
