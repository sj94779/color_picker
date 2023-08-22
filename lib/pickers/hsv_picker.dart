import 'package:flutter/cupertino.dart' show CupertinoTextField;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

// Just an example of how to use/interpret/format text input's result.
void copyToClipboard(String input) {
  String textToCopy = input.replaceFirst('#', '').toUpperCase();
  if (textToCopy.startsWith('FF') && textToCopy.length == 8) {
    textToCopy = textToCopy.replaceFirst('FF', '');
  }
  Clipboard.setData(ClipboardData(text: '#$textToCopy'));
}

class HSVColorPickerExample extends StatefulWidget {
  const HSVColorPickerExample({
    Key? key,
    required this.pickerColor,
    required this.onColorChanged,
    this.colorHistory,
    this.onHistoryChanged,
  }) : super(key: key);

  final Color pickerColor;
  final ValueChanged<Color> onColorChanged;
  final List<Color>? colorHistory;
  final ValueChanged<List<Color>>? onHistoryChanged;

  @override
  State<HSVColorPickerExample> createState() => _HSVColorPickerExampleState();
}

class _HSVColorPickerExampleState extends State<HSVColorPickerExample> {
  // Picker 1
  PaletteType _paletteType = PaletteType.hsl;
  bool _enableAlpha = true;
  bool _displayThumbColor = true;
  final List<ColorLabelType> _labelTypes = [ColorLabelType.hsl, ColorLabelType.hsv];
  bool _displayHexInputBar = false;

  // Picker 2
  bool _displayThumbColor2 = true;
  bool _enableAlpha2 = false;

  // Picker 3
  ColorModel _colorModel = ColorModel.rgb;
  bool _enableAlpha3 = false;
  bool _displayThumbColor3 = true;
  bool _showParams = true;
  bool _showIndicator = true;

  // Picker 4
  final textController =
      TextEditingController(text: '#2F19DB'); // The initial value can be provided directly to the controller.
  bool _enableAlpha4 = true;

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(height: 20),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: SingleChildScrollView(
                        child: ColorPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          colorPickerWidth: 300,
                          pickerAreaHeightPercent: 0.7,
                          enableAlpha: _enableAlpha,
                          labelTypes: _labelTypes,
                          displayThumbColor: _displayThumbColor,
                          paletteType: _paletteType,
                          pickerAreaBorderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(2),
                            topRight: Radius.circular(2),
                          ),
                          hexInputBar: _displayHexInputBar,
                          colorHistory: widget.colorHistory,
                          onHistoryChanged: widget.onHistoryChanged,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Color Picker with Slider',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),

          ],
        ),

        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: MediaQuery.of(context).orientation == Orientation.portrait
                            ? const BorderRadius.vertical(
                                top: Radius.circular(500),
                                bottom: Radius.circular(100),
                              )
                            : const BorderRadius.horizontal(right: Radius.circular(500)),
                      ),
                      content: SingleChildScrollView(
                        child: HueRingPicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          enableAlpha: _enableAlpha2,
                          displayThumbColor: _displayThumbColor2,
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Hue Ring Picker with Hex Input',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),

          ],
        ),


        const Divider(),
        const SizedBox(height: 5),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25))),
                      content: SingleChildScrollView(
                        child: SlidePicker(
                          pickerColor: widget.pickerColor,
                          onColorChanged: widget.onColorChanged,
                          colorModel: _colorModel,
                          enableAlpha: _enableAlpha3,
                          displayThumbColor: _displayThumbColor3,
                          showParams: _showParams,
                          showIndicator: _showIndicator,
                          indicatorBorderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Text(
                'Slider-only Color Picker',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),

          ],
        ),

        const Divider(),
        const SizedBox(height: 15),
        Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      scrollable: true,
                      titlePadding: const EdgeInsets.all(0),
                      contentPadding: const EdgeInsets.all(0),
                      content: Column(
                        children: [
                          ColorPicker(
                            pickerColor: widget.pickerColor,
                            onColorChanged: widget.onColorChanged,
                            colorPickerWidth: 300,
                            pickerAreaHeightPercent: 0.7,
                            enableAlpha: _enableAlpha4, // hexInputController will respect it too.
                            displayThumbColor: true,
                            paletteType: PaletteType.hsvWithHue,
                            labelTypes: const [],
                            pickerAreaBorderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(2),
                              topRight: Radius.circular(2),
                            ),
                            hexInputController: textController, // <- here
                            portraitOnly: true,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                            /* It can be any text field, for example:

                            * TextField
                            * TextFormField
                            * CupertinoTextField
                            * EditableText
                            * any text field from 3-rd party package
                            * your own text field

                            so basically anything that supports/uses
                            a TextEditingController for an editable text.
                            */
                            child: CupertinoTextField(
                              controller: textController,
                              // Everything below is purely optional.
                              prefix: const Padding(padding: EdgeInsets.only(left: 8), child: Icon(Icons.tag)),
                              suffix: IconButton(
                                icon: const Icon(Icons.content_paste_rounded),
                                onPressed: () => copyToClipboard(textController.text),
                              ),
                              autofocus: true,
                              maxLength: 9,
                              inputFormatters: [
                                // Any custom input formatter can be passed
                                // here or use any Form validator you want.
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(RegExp(kValidHexPattern)),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text(
                '  HSV Color Picker\n(Your own text field)',
                style: TextStyle(color: useWhiteForeground(widget.pickerColor) ? Colors.white : Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                primary: widget.pickerColor,
                shadowColor: widget.pickerColor.withOpacity(1),
                elevation: 10,
              ),
            ),
            const SizedBox(width: 20),

          ],
        ),

        const SizedBox(height: 80),
      ],
    );
  }
}
