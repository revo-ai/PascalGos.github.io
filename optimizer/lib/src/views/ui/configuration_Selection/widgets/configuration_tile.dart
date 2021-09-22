import 'package:fluent_ui/fluent_ui.dart';
import 'package:hovering/hovering.dart';
import 'package:optimizer/src/views/ui/configuration_Selection/widgets/add_config_dialog.dart';

typedef void SelectedTileCallback(int selectedTileIndex);

class ConfigurationTile extends StatefulWidget {
  final SelectedTileCallback callback;
  final Function openConfigDialog;
  final String configurationName;
  final int index;
  int selectedTileIndex;
  bool selected;
  bool disabled;
  ConfigurationTile({
    Key? key,
    required this.callback,
    required this.openConfigDialog,
    required this.configurationName,
    required this.index,
    required this.selectedTileIndex,
    this.selected = false,
    this.disabled = false,
  }) : super(key: key);

  @override
  _ConfigurationTileState createState() => _ConfigurationTileState();
}

class _ConfigurationTileState extends State<ConfigurationTile> {
  Color _tileColor = Colors.teal;

  @override
  Widget build(BuildContext context) {
    setState(() {
      if (!this.widget.disabled) {
        _tileColor = this.widget.selectedTileIndex == this.widget.index
            ? Colors.blue
            : Colors.teal;
      } else {
        _tileColor = Colors.grey;
      }
    });
    return MouseRegion(
      onEnter: (event) {
        setState(() {
          if (this.widget.selectedTileIndex == this.widget.index &&
              !this.widget.disabled) {
            _tileColor = Colors.blue;
          }
        });
      },
      onExit: (event) {
        setState(() {
          if (this.widget.selectedTileIndex == this.widget.index &&
              !this.widget.disabled) {
            _tileColor = Colors.teal;
          }
        });
      },
      child: GestureDetector(
        onTap: () {
          setState(() {
            if (!this.widget.disabled) {
              print(this.widget.selectedTileIndex);
              this.widget.selectedTileIndex = this.widget.index;
              this.widget.callback(this.widget.selectedTileIndex);
            }
          });
        },
        onDoubleTap: () {
          setState(() {
            if (!this.widget.disabled) {
              print(this.widget.selectedTileIndex);
              this.widget.selectedTileIndex = this.widget.index;
              this.widget.callback(this.widget.selectedTileIndex);
              this.widget.openConfigDialog();
            }
          });
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
          color: _tileColor,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FluentIcons.open_file,
                size: 100,
              ),
              SizedBox(height: 10),
              Text(
                this.widget.configurationName,
                style: FluentTheme.of(context).typography.body,
              )
            ],
          ),
        ),
      ),
    );
  }
}
