import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomImputDatePicker extends StatefulWidget {
  final void Function(DateTime?)? onChanged;
  final String label;

  final DateTime? initialValue;

  final String? Function(DateTime?)? validator;

  const CustomImputDatePicker({
    Key? key,
    this.onChanged,
    required this.label,
    this.validator,
    this.initialValue,
  }) : super(key: key);

  @override
  State<CustomImputDatePicker> createState() => _CustomImputDatePickerState();
}

class _CustomImputDatePickerState extends State<CustomImputDatePicker> {
  TextEditingController? _textEditingController;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      String formattedDate =
          DateFormat('yyyy-MM-dd').format(widget.initialValue!);
      _textEditingController = TextEditingController(text: formattedDate);
    } else {
      _textEditingController = TextEditingController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormField<DateTime>(
      initialValue: widget.initialValue,
      validator: widget.validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      builder: (state) {
        final DateTime? value = state.value;
        final bool hasError = state.hasError;

        return Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 48,
                child: TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                      right: 0,
                      left: 10,
                      top: 8.0,
                      bottom: 8.0,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.7,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                        width: 1.7,
                        style: BorderStyle.solid,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    prefixIcon: const Icon(
                      Icons.date_range_outlined,
                      color: Colors.black,
                    ),
                    hintText: widget.label,
                  ),
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());

                    showDatePicker(
                      context: context,
                      initialDate: value ?? DateTime.now(),
                      firstDate: DateTime(1980),
                      lastDate: DateTime(2222),
                    ).then((selectedDate) {
                      if (selectedDate != null) {
                        if (widget.validator != null) {
                          state.validate();
                        }
                        if (widget.onChanged != null) {
                          state.didChange(selectedDate);
                          widget.onChanged!(selectedDate);

                          String formattedDate =
                              DateFormat('dd-MM-yyyy').format(selectedDate);
                          _textEditingController!.text = formattedDate;
                        }
                      }
                    }).ignore();
                  },
                ),
              ),
              if (hasError)
                Text(
                  state.errorText!,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 194, 18, 18),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
