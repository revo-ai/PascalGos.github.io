import 'package:fluent_ui/fluent_ui.dart';

class Forms extends StatefulWidget {
  const Forms({Key? key}) : super(key: key);

  @override
  _FormsState createState() => _FormsState();
}

class _FormsState extends State<Forms> {
  final autoSuggestBox = TextEditingController();

  final _clearController = TextEditingController();
  bool _showPassword = false;

  final values = ['Blue', 'Green', 'Yellow', 'Red'];
  String? comboBoxValue;

  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage(
      header: PageHeader(title: Text('Forms showcase')),
      content: ListView(
        padding: EdgeInsets.only(
          bottom: kPageDefaultVerticalPadding,
          left: PageHeader.horizontalPadding(context),
          right: PageHeader.horizontalPadding(context),
        ),
        children: [
          TextBox(
            header: 'Email',
            placeholder: 'Type your email here :)',
          ),
          SizedBox(height: 20),
          Row(children: [
            Expanded(
              child: TextBox(
                readOnly: true,
                placeholder: 'Read only text box',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: TextBox(
                enabled: false,
                placeholder: 'Disabled text box',
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: AutoSuggestBox<String>(
                controller: autoSuggestBox,
                items: values,
                onSelected: (text) {
                  print(text);
                },
                textBoxBuilder: (context, controller, focusNode, key) {
                  return TextBox(
                    key: key,
                    controller: controller,
                    focusNode: focusNode,
                    suffixMode: OverlayVisibilityMode.editing,
                    suffix: IconButton(
                      icon: Icon(FluentIcons.close),
                      onPressed: () {
                        controller.clear();
                        focusNode.unfocus();
                      },
                    ),
                    placeholder: 'Type a color',
                    clipBehavior:
                        focusNode.hasFocus ? Clip.none : Clip.antiAlias,
                  );
                },
              ),
            ),
          ]),
          SizedBox(height: 20),
          TextBox(
            maxLines: null,
            controller: _clearController,
            suffixMode: OverlayVisibilityMode.always,
            minHeight: 100,
            suffix: IconButton(
              icon: Icon(FluentIcons.close),
              onPressed: () {
                _clearController.clear();
              },
            ),
            placeholder: 'Text box with clear button',
          ),
          SizedBox(height: 20),
          TextBox(
            header: 'Password',
            placeholder: 'Type your placeholder here',
            obscureText: !_showPassword,
            maxLines: 1,
            suffixMode: OverlayVisibilityMode.always,
            suffix: IconButton(
              icon: Icon(
                !_showPassword ? FluentIcons.lock : FluentIcons.unlock,
              ),
              onPressed: () => setState(() => _showPassword = !_showPassword),
            ),
            outsideSuffix: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Button(
                child: Text('Done'),
                onPressed: () {},
              ),
            ),
          ),
          SizedBox(height: 20),
          Wrap(children: [
            SizedBox(
              width: 200,
              child: InfoLabel(
                label: 'Colors',
                child: Combobox<String>(
                  placeholder: Text('Choose a color'),
                  isExpanded: true,
                  items: values
                      .map((e) => ComboboxItem<String>(
                            value: e,
                            child: Text(e),
                          ))
                      .toList(),
                  value: comboBoxValue,
                  onChanged: (value) {
                    print(value);
                    if (value != null) setState(() => comboBoxValue = value);
                  },
                ),
              ),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 295,
              child: DatePicker(
                // popupHeight: kOneLineTileHeight * 6,
                header: 'Date of birth',
                selected: date,
                onChanged: (v) => setState(() => date = v),
              ),
            ),
            SizedBox(width: 12),
            SizedBox(
              width: 240,
              child: TimePicker(
                // popupHeight: kOneLineTileHeight * 5,
                header: 'Arrival time',
                selected: date,
                onChanged: (v) => setState(() => date = v),
              ),
            ),
          ]),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
