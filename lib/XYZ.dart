import 'package:flutter/material.dart';

class MultiSelectDropdown extends StatefulWidget {
  final List<String> options;
  final List<String> selectedValues;
  final Function(List<String>) onChanged;

  MultiSelectDropdown({
    required this.options,
    required this.selectedValues,
    required this.onChanged,
  });

  @override
  _MultiSelectDropdownState createState() => _MultiSelectDropdownState();
}

class _MultiSelectDropdownState extends State<MultiSelectDropdown> {
  late List<String> _selectedValues;

  @override
  void initState() {
    super.initState();
    _selectedValues = List<String>.from(widget.selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<List<String>>(
      items: widget.options.map((option) {
        return DropdownMenuItem<List<String>>(
          value: [_selectedValues.contains(option).toString(), option],
          child: Row(
            children: [
              Checkbox(
                value: _selectedValues.contains(option),
                onChanged: (checked) {
                  print('Checkbox onChanged called with value: $checked');
                  setState(() {
                    if (checked ?? false) {
                      _selectedValues.add(option);
                    } else {
                      _selectedValues.remove(option);
                    }
                  });
                  widget.onChanged(_selectedValues);
                },
                visualDensity: VisualDensity.adaptivePlatformDensity,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                activeColor: Colors.green,
                checkColor: Colors.white,
                tristate: false,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              width: 1,
              color: Colors.black,
            ),
          ),

              ),
              SizedBox(
                width: 10,
              ),
              Text(option),
            ],
          ),
        );
      }).toList(),
      isDense: true,
      isExpanded: true,
      value: null,
      onChanged: (selectedItems) {
        setState(() {
          _selectedValues = selectedItems!
              .where((item) => item != null && item[0] == true)
              .map((item) => item[1] as String)
              .toList();
        });
        widget.onChanged(_selectedValues);
      },
      decoration: InputDecoration(
        labelText: 'Select clients',
        border: OutlineInputBorder(),
      ),
    );
  }
}
