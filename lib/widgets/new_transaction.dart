
import 'package:expense_planner_mobile_app/widgets/adaptive_text_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants_and_styles.dart';

class NewTransaction extends StatefulWidget {
  final void Function(String title, double amount, DateTime chosenDate) addTx;

  const NewTransaction({super.key, required this.addTx});

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime? _selectedDate;

  //===============================================================================================
  // It will submit the entered data. work as a handler
  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate!,
    );

    Navigator.of(context).pop();
  }

  //===============================================================================================
  //It work as a Date picker for present or any Date
  void _datePicker() {
    showDatePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,

        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            //To let the content behind the soft keyboard to be visible
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,

            children: <Widget>[
              //Text Field for the Title
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => _submitData,
                // onChanged: (val) => titleInput = val,
              ),

              //Text Field for the Amount
              TextField(
                decoration: const InputDecoration(labelText: 'amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
                // onChanged: (val) => amountInput = val,
              ),

              //For the Date Picker
              SizedBox(
                height: 70,
                child: Row(
                  children: [

                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Date Chosen!'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate!)}',
                      ),
                    ),

                    //For selecting desired date
                    AdaptiveTextButton(text: 'Choose Date', handler: _datePicker),
                  ],
                ),
              ),

              //For Submitting the entered data
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 3,
                  backgroundColor: Theme.of(context).primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),

                onPressed: _submitData,
                child: const Text(
                  'Add Transaction',
                  style: kAddTransactionTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
