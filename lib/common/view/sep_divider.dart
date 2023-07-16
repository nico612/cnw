import 'package:flutter/material.dart';

class SepDivider extends StatelessWidget {
  const SepDivider({
    Key? key,
    this.text = const Text(''),
  }) : super(key: key);

  final Text text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13),
      child: Row(children: <Widget>[
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: text,
        ),
        const Expanded(child: Divider()),
      ]),
    );
  }
}
