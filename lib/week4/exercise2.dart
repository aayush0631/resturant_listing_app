import 'package:flutter/material.dart';

class ColorChangerForm extends StatefulWidget {
  const ColorChangerForm({super.key});

  @override
  State<ColorChangerForm> createState() => _ColorChnageFormState();
}

class _ColorChnageFormState extends State<ColorChangerForm> {
  List<bool> isSelected = [true, false, false];
  final List<Color> color = [
    Color.fromARGB(255, 0, 0, 0),
    Color.fromARGB(255, 0, 0, 255),
    Color.fromARGB(255, 0, 255, 0),
  ];

  Color currentColor = Color.fromARGB(155, 255, 0, 0);
  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('interactive color colour changer')),
      body: Container(
        decoration: BoxDecoration(color: currentColor),
        child: ToggleButtons(
          isSelected: isSelected,
          onPressed: (index) => setState(() {
            currentColor = color[index];
          }),
          children: [
            Padding(padding: EdgeInsets.all(10), child: Text('red')),
            Padding(padding: EdgeInsets.all(10), child: Text('blue')),
            Padding(padding: EdgeInsets.all(10), child: Text('green')),
          ],
        ),
      ),
    );
  }
}
