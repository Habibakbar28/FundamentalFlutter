import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {

  final String text;
  final ValueChanged<String> onChanged;

  const SearchWidget({
    Key? key,
    required this.text,
    required this.onChanged,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextField(
        maxLines: 1,
        controller: controller,
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.black87,
          ),
          suffixIcon: widget.text.isNotEmpty
              ? GestureDetector(
            child: const Icon(Icons.close, color: Colors.black87),
            onTap: () {
              controller.clear();
              widget.onChanged('');
              FocusScope.of(context).requestFocus(FocusNode());
            },
          )
              : null,
          hintText: 'Cari Restauran disini',
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 16.0,
          ),
        ),
      ),
    );
  }
}