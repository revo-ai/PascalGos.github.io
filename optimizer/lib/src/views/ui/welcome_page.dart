import 'package:fluent_ui/fluent_ui.dart';
import 'package:optimizer/src/views/ui/configuration_Selection/configuration_selection_page.dart';
import 'package:optimizer/src/views/ui/home_page.dart';

typedef void IndexCallback(int index);

class WelcomePage extends StatefulWidget {
  IndexCallback indexCallback;

  WelcomePage({Key? key, required this.indexCallback}) : super(key: key);

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

  bool disabled = false;

  double imageSizeBig = 100;
  double imageSizeSmall = 70;

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
        header: PageHeader(
          title: Text(
            '',
            style: FluentTheme.of(context).typography.titleLarge,
          ),
        ),
        content: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: PageHeader.horizontalPadding(context),
            ),
            children: [
              Wrap(
                spacing: 50,
                runSpacing: 50,
                children: [
                  MediaQuery.of(context).size.width < 1350
                      ? ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.6,
                          ),
                          child: Column(
                            children: [
                              Container(
                                child: Row(children: [
                                  Container(
                                      child: Padding(
                                    padding: const EdgeInsets.only(top: 3.5),
                                    child: ClipRect(
                                      child: Align(
                                        heightFactor: 0.5,
                                        child: FluentTheme.of(context)
                                                .brightness
                                                .isLight
                                            ? Image.asset(
                                                'assets/revoAI_logo_white.png',
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                height: imageSizeSmall,

                                                //colorBlendMode: BlendMode.srcOver,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : Image.asset(
                                                'assets/revoAI_logo_white.png',
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                //color: Color.fromARGB(255, 36, 47, 94),
                                                height: imageSizeSmall,

                                                fit: BoxFit.fitWidth,
                                              ),
                                      ),
                                    ),
                                  )),
                                  Text(
                                    "Explorer",
                                    style: TextStyle(
                                        fontSize: 28,
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Making Machines safe",
                                      style: FluentTheme.of(context)
                                          .typography
                                          .bodyLarge,
                                    ),
                                    SizedBox(height: 50),
                                    Text(
                                      'Start',
                                      style: FluentTheme.of(context)
                                          .typography
                                          .title,
                                    ),
                                    TextButton(
                                      child: Row(
                                        children: [
                                          Icon(FluentIcons.edit_note),
                                          Text('New Scenario'),
                                        ],
                                      ),
                                      onPressed: disabled
                                          ? null
                                          : () {
                                              this.widget.indexCallback(1);
                                            },
                                    ),
                                    TextButton(
                                      child: Row(
                                        children: [
                                          Icon(FluentIcons.edit_note),
                                          Text('Load Scenario Settings'),
                                        ],
                                      ),
                                      onPressed: false
                                          ? null
                                          : () {
                                              print('pressed text button');
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width * 0.35,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 80),
                              Container(
                                child: Row(children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.5),
                                    child: ClipRect(
                                      child: Align(
                                        heightFactor: 0.5,
                                        child: FluentTheme.of(context)
                                                .brightness
                                                .isLight
                                            ? Image.asset(
                                                'assets/revoAI_logo_white.png',
                                                color: Color.fromARGB(
                                                    255, 0, 0, 0),
                                                height: imageSizeBig,

                                                //colorBlendMode: BlendMode.srcOver,
                                                fit: BoxFit.fitWidth,
                                              )
                                            : Image.asset(
                                                'assets/revoAI_logo_white.png',
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                                //color: Color.fromARGB(255, 36, 47, 94),
                                                height: imageSizeBig,

                                                fit: BoxFit.fitWidth,
                                              ),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Explorer",
                                    style: TextStyle(
                                        fontSize: 36,
                                        fontWeight: FontWeight.w400),
                                  )
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Making Machines safe",
                                      style: FluentTheme.of(context)
                                          .typography
                                          .bodyLarge,
                                    ),
                                    SizedBox(height: 50),
                                    Text(
                                      'Start',
                                      style: FluentTheme.of(context)
                                          .typography
                                          .title,
                                    ),
                                    TextButton(
                                      child: Row(
                                        children: [
                                          Icon(FluentIcons.edit_note),
                                          Text(' New Scenario'),
                                        ],
                                      ),
                                      onPressed: disabled
                                          ? null
                                          : () {
                                              this.widget.indexCallback(1);
                                            },
                                    ),
                                    TextButton(
                                      child: Row(
                                        children: [
                                          Icon(FluentIcons.settings_add),
                                          Text(' Load Scenario Settings'),
                                        ],
                                      ),
                                      onPressed: false
                                          ? null
                                          : () {
                                              print('pressed text button');
                                            },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ]));
  }
}
