import 'package:flutter/material.dart';

class Text_and_Field extends StatelessWidget {
  const Text_and_Field({
    Key? key,
    required String text,
    required TextEditingController controller,
  }) : _controller = controller,_text = text,  super(key: key);

  final TextEditingController _controller;
  final String _text ;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Text("$_text : "),
          Expanded(
            child:  TextField(controller: _controller,
              decoration: const InputDecoration(
                  border: OutlineInputBorder()
              ),
            ),
          )
        ]);
  }
}