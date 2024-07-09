import 'package:flutter/material.dart';
import 'package:hage_mobile_app/src/features/personalization/controllers/user_controller.dart';

import '../../../controllers/signup/signup_controller.dart';

class RoleField extends StatefulWidget {
  final SignupController controller;


  const RoleField({Key? key, required this.controller}) : super(key: key);

  @override
  State<RoleField> createState() => _RoleFieldState();
}

class _RoleFieldState extends State<RoleField> {
  String _selectedValue = 'Dooro heerkaaga';

  @override
  Widget build(BuildContext context) {
    return Center(
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
              Icon(Icons.person, color: Colors.grey), // Static prefix icon
              const SizedBox(width: 8), // Add some space between the icon and the dropdown
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedValue = newValue!;
                        widget.controller.level.text = newValue; // Update the controller's variable
                      });
                    },
                    items: <String>['Dooro heerkaaga', 'Macalin', 'Arday', 'Marti']
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