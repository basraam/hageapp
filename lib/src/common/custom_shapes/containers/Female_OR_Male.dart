import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/AppBar/custom_AppBar.dart';
import '../../../utils/constants/BSizes.dart';
import '../../../features/personalization/controllers/changingControllers/updategenderController.dart';

class SexSelector extends StatefulWidget {
  final UpdateGenderController controller;

  const SexSelector({Key? key, required this.controller}) : super(key: key);

  @override
  State<SexSelector> createState() => _SexSelectorState();
}

class _SexSelectorState extends State<SexSelector> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.controller.sex.text.isEmpty
        ? 'Dooro Jinsigaaga'
        : widget.controller.sex.text;
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
          child: SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 1),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Row(
                children: [
                  Icon(Icons.person, color: Colors.grey),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedValue,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedValue = newValue!;
                            widget.controller.sex.text = newValue;
                          });
                        },
                        items: <String>['Dooro Jinsigaaga', 'Lab', 'Dhedig']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
