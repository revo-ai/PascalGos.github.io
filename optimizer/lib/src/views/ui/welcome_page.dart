import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as material;

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final FlyoutController controller = FlyoutController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  static const int numItems = 10;
  List<bool> selected = List<bool>.generate(numItems, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
          title: Text('Welcome'),
        ),
        content: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: PageHeader.horizontalPadding(context),
            ),
            children: []));
  }
}
